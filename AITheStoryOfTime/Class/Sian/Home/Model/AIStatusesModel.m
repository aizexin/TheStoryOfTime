//
//  AIStatusesModel.m
//  AISian
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIStatusesModel.h"
#import "MJExtension.h"
#import "AIPhoto.h"
#import "NSDate+MJ.h"
#import "RegexKitLite.h"
#import "AIRegexResult.h"
#import "AIEmotionTool.h"
#import "AIUserModel.h"
#import "AIEmotionAttachment.h"
@implementation AIStatusesModel

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [AIPhoto class]};
}

/**
 一、今年
 1、今天
 1分钟内：刚刚
 1个小时内：xx分钟前
 
 2、昨天
 昨天 xx:xx
 
 3、至少是前天发的
 04-23 xx:xx
 
 二、非今年
 2012-07-24
 */
// _created_at == Mon Jul 14 15:48:07 +0800 2014
//                Tue Oct 27 13:07:54 +0800 2015（真机）
//                Tue Oct 27 13:09:38 +0800 2015(模拟器)
// Mon Jul 14 15:48:07 +0800 2014 -> NSDate -> 2014-07-14 15:48:07
//Wed Oct 14 19:50:45 +0800 2015
-(NSString *)created_at{

      NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //真机需要添加
    fmt.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    // 获得微博发布的具体时间
    NSDate *createDate = [fmt dateFromString:_created_at];
    AILog(@"%@",_created_at);
    // 判断是否为今年
    if (createDate.isThisYear) {
        if (createDate.isToday) { // 今天
            NSDateComponents *cmps = [createDate deltaWithNow];
            if (cmps.hour >= 1) { // 至少是1小时前发的
                return [NSString stringWithFormat:@"%ld小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                return [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
            } else { // 1分钟内发的
                return @"刚刚";
            }
        } else if (createDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }
}
// _source == <a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
// destSource = 来自微博 weibo.com
-(void)setSource:(NSString *)source{
    if (source.length == 0) {
        return;
    }
    _source = source;
    NSInteger location = [source rangeOfString:@">"].location + 1;
    NSInteger length = [source rangeOfString:@"</"].location - location;
    NSRange range = NSMakeRange(location, length);
    NSString *subStr = [source substringWithRange:range];
    _source = [NSString stringWithFormat:@"来自%@",subStr];
}

- (void)setUser:(AIUserModel *)user
{
    _user = user;
    
    [self createAttributedText];
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    [self createAttributedText];
//    [self createAttributedText];
//    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];
    
    //匹配表情
//    NSString *emotionRegex = @"";
}

- (void)createAttributedText
{
//    AILog(@"%@---%@",self.text,self.user);
    if (self.text == nil || self.user == nil) return;
    
    if (self.retweeted_status) {
        NSString *totalText = [NSString stringWithFormat:@"@%@ : %@", self.user.name, self.text];
        NSAttributedString *attributedString = [self attributedStringWithText:totalText];
        self.attributedText = attributedString;
    } else {
        self.attributedText = [self attributedStringWithText:self.text];
    }
}
/**
 *  根据字符串计算出所有的匹配结果（已经排好序）
 *
 *  @param text 字符串内容
 */
- (NSArray *)regexResultsWithText:(NSString *)text
{
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [NSMutableArray array];
    
    // 匹配表情
    NSString *emotionRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    [text enumerateStringsMatchedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        AIRegexResult *rr = [[AIRegexResult alloc] init];
        rr.string = *capturedStrings;
        rr.range = *capturedRanges;
        rr.emotion = YES;
        [regexResults addObject:rr];
    }];
    
    // 匹配非表情
    [text enumerateStringsSeparatedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        AIRegexResult *rr = [[AIRegexResult alloc] init];
        rr.string = *capturedStrings;
        rr.range = *capturedRanges;
        rr.emotion = NO;
        [regexResults addObject:rr];
    }];
    
    // 排序
    [regexResults sortUsingComparator:^NSComparisonResult(AIRegexResult *rr1, AIRegexResult *rr2) {
        int loc1 = rr1.range.location;
        int loc2 = rr2.range.location;
        return [@(loc1) compare:@(loc2)];
    }];
    return regexResults;
}

- (NSAttributedString *)attributedStringWithText:(NSString *)text
{
    // 1.匹配字符串
    NSArray *regexResults = [self regexResultsWithText:text];
    
    // 2.根据匹配结果，拼接对应的图片表情和普通文本
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    // 遍历
    [regexResults enumerateObjectsUsingBlock:^(AIRegexResult *result, NSUInteger idx, BOOL *stop) {
        AIEmotion *emotion = nil;
        if (result.isEmotion) { // 表情
            emotion = [AIEmotionTool emotionWithDesc:result.string];
        }
        
        if (emotion) { // 如果有表情
            // 创建附件对象
            AIEmotionAttachment *attach = [[AIEmotionAttachment alloc] init];
            
            // 传递表情
            attach.emotion = emotion;
            attach.bounds = CGRectMake(0, -3, AIStatusOrginalTextFont.lineHeight, AIStatusOrginalTextFont.lineHeight);
            
            // 将附件包装成富文本
            NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
            [attributedString appendAttributedString:attachString];
        } else { // 非表情（直接拼接普通文本）
            NSMutableAttributedString *substr = [[NSMutableAttributedString alloc] initWithString:result.string];
            
            // 匹配#话题#
            NSString *trendRegex = @"#[a-zA-Z0-9\\u4e00-\\u9fa5]+#";
            [result.string enumerateStringsMatchedByRegex:trendRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:AIStatusHighTextColor range:*capturedRanges];
            }];
            
            // 匹配@提到
            NSString *mentionRegex = @"@[a-zA-Z0-9\\u4e00-\\u9fa5\\-]+ ?";
            [result.string enumerateStringsMatchedByRegex:mentionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:AIStatusHighTextColor range:*capturedRanges];
            }];
            
            // 匹配超链接
            NSString *httpRegex = @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
            [result.string enumerateStringsMatchedByRegex:httpRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:AIStatusHighTextColor range:*capturedRanges];
            }];
            
            [attributedString appendAttributedString:substr];
        }
    }];
    
    // 设置字体
    [attributedString addAttribute:NSFontAttributeName value:AIStatusRichTextFont range:NSMakeRange(0, attributedString.length)];
    
    return attributedString;
}
@end

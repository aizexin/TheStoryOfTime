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
#import "AIDefine.h"
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
// Mon Jul 14 15:48:07 +0800 2014 -> NSDate -> 2014-07-14 15:48:07
//Wed Oct 14 19:50:45 +0800 2015
-(NSString *)created_at{

      NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    // 获得微博发布的具体时间
    NSDate *createDate = [fmt dateFromString:_created_at];
    
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
@end

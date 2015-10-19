//
//  AIEmotionTool.m
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/18.
//  Copyright © 2015年 aizexin. All rights reserved.
//
#define AIRecentFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recent_emotions.data"]
#import "AIEmotionTool.h"
#import "AIEmotion.h"
#import "MJExtension.h"
/**
 *  默认表情
 */
static NSArray *_defaultEmotions;
/**
 *  emoji表情
 */
static NSArray *_emojiEmotions;
/**
 *  浪小花表情
 */
static NSArray *_lxhEmotions;

/**最近表情*/
static NSMutableArray *_recentEmotions;

@implementation AIEmotionTool

+(NSArray *)defaultEmotions{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultEmotions = [AIEmotion objectArrayWithFile:plist];
        [_defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/default"];
    }
    return _defaultEmotions;
}
+(NSArray *)emojiEmotions{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiEmotions = [AIEmotion objectArrayWithFile:plist];
        [_emojiEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/emoji"];
    }
    return _emojiEmotions;
}
+ (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhEmotions = [AIEmotion objectArrayWithFile:plist];
        [_lxhEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/lxh"];
    }
    return _lxhEmotions;
}
+ (NSArray *)recentEmotions
{
    if (!_recentEmotions) {
        // 去沙盒中加载最近使用的表情数据
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:AIRecentFilepath];
        if (!_recentEmotions) { // 沙盒中没有任何数据
            _recentEmotions = [NSMutableArray array];
        }
    }
    return _recentEmotions;
}
+(void)addRecentEmotion:(AIEmotion*)emotion{
    //加载最近的表情数据
    [self recentEmotions];
    //删除之前的表情
    [_recentEmotions removeObject:emotion];
    //添加新的
    [_recentEmotions insertObject:emotion atIndex:0];
    //存入沙河
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:AIRecentFilepath];
}

@end

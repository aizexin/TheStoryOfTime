//
//  AIEmotionTool.h
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/18.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AIEmotion;

@interface AIEmotionTool : NSObject
/**添加最近表情*/
+(void)addRecentEmotion:(AIEmotion*)emotion;

/**默认表情*/
+(NSArray *)defaultEmotions;

/**emoji表情*/
+(NSArray *)emojiEmotions;

/**浪小花表情*/
+ (NSArray *)lxhEmotions;

/**最近表情*/
+ (NSArray *)recentEmotions;
/**
 *  根据表情的文字描述找出对应的表情对象
 */
+ (AIEmotion *)emotionWithDesc:(NSString *)desc;
@end

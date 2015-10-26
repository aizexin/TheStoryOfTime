//
//  AIEmotionTextView.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AITextView.h"

@class AIEmotion;
@interface AIEmotionTextView : AITextView
/**
 *  拼接表情到最后面
 */
- (void)appendEmotion:(AIEmotion *)emotion;

/**
 *  具体的文字内容
 */
- (NSString *)realText;
@end

//
//  AIEmotionAttachment.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIEmotionAttachment.h"

#import "AIEmotion.h"
@implementation AIEmotionAttachment

- (void)setEmotion:(AIEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png]];
}
@end

//
//  AIEmotionView.m
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/18.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import "AIEmotionView.h"
#import "AIEmotion.h"

@implementation AIEmotionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
    
    }
    return self;
}

-(void)setEmotion:(AIEmotion *)emotion{
    _emotion = emotion;
    if (emotion.code) {//emoji 表情
        
        //取消动画效果
        [UIView setAnimationsEnabled:NO];
        //设置emoji表情
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        [self setTitle:emotion.emoji forState:(UIControlStateNormal)];
        [self setImage:nil forState:(UIControlStateNormal)];
        //再次开启动画
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView setAnimationsEnabled:YES];
        });
    }else{ //图片表情
        NSString *icon = [NSString stringWithFormat:@"%@/%@",emotion.directory,emotion.png];
        UIImage *iconImage = [[UIImage imageNamed:icon]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [self setImage:iconImage forState:(UIControlStateNormal)];
        [self setTitle:nil forState:(UIControlStateNormal)];
    }
}
@end

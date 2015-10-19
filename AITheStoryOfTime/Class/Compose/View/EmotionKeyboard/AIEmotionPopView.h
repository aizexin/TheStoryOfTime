//
//  AIEmotionPopVIew.h
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/18.
//  Copyright © 2015年 aizexin. All rights reserved.
//  点击表情时候的气泡

#import <UIKit/UIKit.h>

@class AIEmotionView;
@interface AIEmotionPopView : UIView

+(instancetype)popView;

/**
 *  显示表情填出控件
 *
 *  @param fromEmotionView 点的哪个表情
 */
-(void)showFromEmotionView:(AIEmotionView*)fromEmotionView;

-(void)disMiss;
@end

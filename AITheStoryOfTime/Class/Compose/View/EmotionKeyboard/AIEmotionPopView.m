//
//  AIEmotionPopVIew.m
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/18.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import "AIEmotionPopView.h"
#import "AIEmotionView.h"
@interface AIEmotionPopView ()
@property (strong, nonatomic) IBOutlet AIEmotionView *emotionView;

@end

@implementation AIEmotionPopView

+(instancetype)popView{
    AIEmotionPopView *popView = [[[NSBundle mainBundle]loadNibNamed:@"AIEmotionPopView" owner:nil options:nil]lastObject];
    return popView;
}
/**
 *  显示表情填出控件
 *
 *  @param fromEmotionView 点的哪个表情
 */
-(void)showFromEmotionView:(AIEmotionView*)fromEmotionView{
    //显示表情
    self.emotionView.emotion = fromEmotionView.emotion;
    
    //添加到窗口上
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    //设置位置
    CGPoint point = CGPointMake(fromEmotionView.center.x, fromEmotionView.center.y-AINavgationBarH);
//    CGFloat centerX = fromEmotionView.centerX;
//    CGFloat centerY = fromEmotionView.centerY - self.height*0.5;
    CGPoint center = point;//CGPointMake(centerX, centerY);
    self.center = [window convertPoint:center fromView:fromEmotionView.superview];
}

-(void)disMiss{
    [self removeFromSuperview];
}
/**
 *  当一个控件显示之前会调用一次（如果控件在显示之前没有尺寸，不会调用）
 *
 *  @param rect 控件bounds
 */
-(void)drawRect:(CGRect)rect{
    [[UIImage imageNamed:@"emoticon_keyboard_magnifier"]drawInRect:rect];
}

@end

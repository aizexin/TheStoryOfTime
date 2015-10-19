//
//  AIHomeTitleButton.m
//  AISian
//
//  Created by 艾泽鑫 on 15/9/29.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import "AIHomeTitleButton.h"
#import "AIDefine.h"
#import "UIView+Extension.h"
@implementation AIHomeTitleButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置图片居中
        [self.imageView setContentMode:(UIViewContentModeCenter)];
        [self setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//        [self.imageView setBackgroundColor:[UIColor redColor]];
//        [self.titleLabel setBackgroundColor:[UIColor greenColor]];
        //设置文字右对齐
        [self.titleLabel setTextAlignment:(NSTextAlignmentRight)];
        // 高亮的时候不需要调整内部的图片为灰色
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat W = contentRect.size.width - self.imageView.frame.size.width;
//    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
//    dictM[NSFontAttributeName] = AINavigationTitleFont;
//    CGFloat W = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dictM context:nil].size.width;
    CGFloat H = contentRect.size.height;
    return CGRectMake(X, Y, W, H);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
   
    CGFloat Y = 0;
    CGFloat W = self.height;
    CGFloat H = self.height;
    CGFloat X = self.width-self.height;
    return CGRectMake(X, Y, W, H);
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    CGSize maxSize = CGSizeMake(MAXFLOAT, self.height);
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    self.width = [title boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dictM context:nil].size.width + 10 + self.height;
}
@end

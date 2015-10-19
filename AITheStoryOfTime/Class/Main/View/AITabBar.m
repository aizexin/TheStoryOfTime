//
//  AITabBar.m
//  AISian
//
//  Created by 艾泽鑫 on 15/10/3.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import "AITabBar.h"
#import "AIDefine.h"
#import "UIView+Extension.h"

@interface AITabBar ()
@property(nonatomic,weak)UIButton *plusBtn;
@end
@implementation AITabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addPlusButton];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self setTabBarItemFrame];
    [self setPlusFrame];
    
}
/**
 *  添加加号按钮
 */
- (void)addPlusButton{
    UIButton *plusBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //设置背景
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:(UIControlStateNormal)];
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:(UIControlStateHighlighted)];
    //设置加号
    [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:(UIControlStateNormal)];
    [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:(UIControlStateHighlighted)];
    
    //添加点击事件
    [plusBtn addTarget:self action:@selector(onClickPlusBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    self.plusBtn = plusBtn;
    [self addSubview:plusBtn];
}
/**
 *  加号点击事件
 *
 *  @param btn 加号
 */
-(void)onClickPlusBtn:(UIButton*)btn{
    if ([self.plusDelegate respondsToSelector:@selector(tabBarDidClickedPlusButton:)]) {
        [self.plusDelegate tabBarDidClickedPlusButton:self];
    }
}
/**
 *  设置加号的frame
 */
-(void)setPlusFrame{
    self.plusBtn.center = CGPointMake(self.width * 0.5, self.height *0.5);
    self.plusBtn.size = self.plusBtn.currentBackgroundImage.size;
}
/**
 *  设置所有item的Frame
 */
-(void)setTabBarItemFrame{
    CGFloat width = self.width / 5;
    CGFloat hight = self.height;
    int index = 0;
    for (UIView *tabBarItem in self.subviews) {
        if (![tabBarItem isKindOfClass:[NSClassFromString(@"UITabBarButton") class]]) {
            continue;
        }

        CGFloat itemW = width;
        CGFloat itemH = hight;
        CGFloat itemY = 0;
        CGFloat itemX = itemW * index;
        if (index >= 2) {
            itemX += width;
        }
        tabBarItem.frame = CGRectMake(itemX, itemY, itemW, itemH);
        index ++;
    }

}
@end

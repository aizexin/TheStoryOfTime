//
//  AIPopMenu.h
//  AISian
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AIPopMenu;
@protocol AIPopMenuDelegate <NSObject>

-(void)popMenuDisMiss:(AIPopMenu*)popMenu;

@end

@interface AIPopMenu : UIView

@property(nonatomic,weak)id<AIPopMenuDelegate> delegate;

/**
 *  初始化方法
 */
-(instancetype)initWithContentView:(UIView*)contentView;
+(instancetype)popMenuWithContentView:(UIView*)contentView;

/**
 *  设置菜单的背景图片
 */
- (void)setBackground:(UIImage *)background;
/**
 *  显示菜单
 */
- (void)showInRect:(CGRect)rect;
/**
 *  消失
 */
-(void)dismiss;
@end

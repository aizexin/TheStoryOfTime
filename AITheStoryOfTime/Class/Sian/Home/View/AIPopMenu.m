//
//  AIPopMenu.m
//  AISian
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIPopMenu.h"
#import "UIImage+Extension.h"
#import "UIView+Extension.h"
@interface AIPopMenu ()
/**
 *  内容
 */
@property(nonatomic,strong)UIView *contentView;
/**
 *  蒙版
 */
@property(nonatomic,weak)UIButton *cover;
/**
 *  显示内容
 */
@property(nonatomic,weak)UIImageView *container;


@end

@implementation AIPopMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建蒙版
        UIButton *cover = [[UIButton alloc]init];
        _cover = cover;
        cover.backgroundColor = [UIColor clearColor];
        [cover addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:cover];
        /*//创建内容
        _contentView = [[UIView alloc]init];
        [self addSubview:_contentView];*/
        //创建背景图片
        UIImageView *container = [[UIImageView alloc]initWithImage:[UIImage resizedImage:@"popover_background"]];
        container.userInteractionEnabled = YES;
        _container = container;
        [self addSubview:container];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.cover.frame = self.bounds;
}
#pragma mark -初始化方法
-(instancetype)initWithContentView:(UIView*)contentView{
    self = [super init];
    if (self) {
        self.contentView = contentView;
    }
    return self;
}
+(instancetype)popMenuWithContentView:(UIView*)contentView{
    return  [[self alloc]initWithContentView:contentView];
}

#pragma mark -公开方法
/**
 *  设置菜单的背景图片
 */
- (void)setBackground:(UIImage *)background{
    self.container.image = background;
}

- (void)showInRect:(CGRect)rect
{
    // 添加菜单整体到窗口身上
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    // 设置容器的frame
    self.container.frame = rect;
    [self.container addSubview:self.contentView];
    
    // 设置容器里面内容的frame
    CGFloat topMargin = 12;
    CGFloat leftMargin = 5;
    CGFloat rightMargin = 5;
    CGFloat bottomMargin = 8;
    
    self.contentView.y = topMargin;
    self.contentView.x = leftMargin;
    self.contentView.width = self.container.width - leftMargin - rightMargin;
    self.contentView.height = self.container.height - topMargin - bottomMargin;
}
-(void)dismiss{
    if ([self.delegate respondsToSelector:@selector(popMenuDisMiss:)]) {
        [self.delegate popMenuDisMiss:self];
    }
}

@end

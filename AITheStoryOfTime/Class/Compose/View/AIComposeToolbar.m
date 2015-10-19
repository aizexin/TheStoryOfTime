//
//  AIComposeToolbar.m
//  AISian
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIComposeToolbar.h"
#import "AIDefine.h"
#import "UIView+Extension.h"
@interface AIComposeToolbar ()
/**
 *  表情按钮
 */
@property(nonatomic,weak)UIButton *emoticonBtn;
@end

@implementation AIComposeToolbar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self addButtonWithNorImage:@"compose_camerabutton_background" higImage:@"compose_camerabutton_background_highlighted" andtag:AIComposeToolBarTagTypeCamera];
        [self addButtonWithNorImage:@"compose_toolbar_picture" higImage:@"compose_toolbar_picture_highlighted" andtag:AIComposeToolBarTagTypePicture];
        [self addButtonWithNorImage:@"compose_mentionbutton_background" higImage:@"compose_mentionbutton_background_highlighted" andtag:AIComposeToolBarTagTypeMention];
        [self addButtonWithNorImage:@"compose_trendbutton_background" higImage:@"compose_trendbutton_background_highlighted" andtag:AIComposeToolBarTagTypeTrend];
       self.emoticonBtn = [self addButtonWithNorImage:@"compose_emoticonbutton_background" higImage:@"compose_emoticonbutton_background_highlighted" andtag:AIComposeToolBarTagTypeEmotion];
    }
    return self;
}

/**
 *  添加一个按钮
 *
 *  @param norImage 普通图片
 *  @param higImage 高亮图片
 *  @param tag      按钮的类型
 *
 *  @return 返回这个按钮
 */
-(UIButton*)addButtonWithNorImage:(NSString*)norImage higImage:(NSString*)higImage andtag:(AIComposeToolBarTagType)tag{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setImage:[UIImage imageNamed:norImage] forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:higImage] forState:(UIControlStateHighlighted)];
    [btn addTarget:self action:@selector(onClickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    btn.tag = tag;
    [self addSubview:btn];
    return btn;
}

-(void)setShowEmotion:(BOOL)showEmotion{
    _showEmotion = showEmotion;
    if (showEmotion) {
        [self.emoticonBtn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:(UIControlStateNormal)];
        [self.emoticonBtn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:(UIControlStateHighlighted)];
    }else{
        [self.emoticonBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:(UIControlStateNormal)];
        [self.emoticonBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:(UIControlStateHighlighted)];
    }
}

-(void)layoutSubviews{
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = self.width / 5;
        btn.height = self.height;
        btn.x = i * btn.width;
    }
}

#pragma mark -按钮点击事件
-(void)onClickBtn:(UIButton*)button{
    
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClick:)]) {
        [self.delegate composeToolbar:self didClick:(AIComposeToolBarTagType)button.tag];
    }
}

@end

//
//  AIComposeToolbar.m
//  AISian
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIComposeToolbar.h"
#import "AIDefine.h"
//#import "UIView+Extension.h"
//define this constant if you want to use Masonry without the 'mas_' prefix
//#define MAS_SHORTHAND
//
////define this constant if you want to enable auto-boxing for default syntax
//#define MAS_SHORTHAND_GLOBALS
//#import "Masonry.h"
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
//        [self fitScreen];
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
    btn.backgroundColor = AIRandomColor;
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

//-(void)fitScreen{
//    UIButton *lastView = nil;
//    CGFloat width = self.frame.size.width/self.subviews.count;
//    for (int i = 0; i < self.subviews.count; i++) {
//        UIButton *view = self.subviews[i];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(lastView ? lastView.right : @0);
//            make.top.mas_equalTo(@0);
//            make.bottom.mas_equalTo(@0);
//            make.width.mas_equalTo(@(60));
////            make.height.mas_equalTo(@40);
//        }];
//        lastView = view;
//    }
//
//}

-(void)layoutSubviews{
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
//        btn.y = 0;
//        btn.width = self.width / 5;
//        btn.height = self.height;
//        btn.x = i * btn.width;
        CGFloat y = 0;
        CGFloat width = self.frame.size.width/5;
        CGFloat heigt = self.frame.size.height;
        CGFloat x = i *width;
        btn.frame = CGRectMake(x, y, width, heigt);
    }
}

#pragma mark -按钮点击事件
-(void)onClickBtn:(UIButton*)button{
    
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClick:)]) {
        [self.delegate composeToolbar:self didClick:(AIComposeToolBarTagType)button.tag];
    }
}

@end

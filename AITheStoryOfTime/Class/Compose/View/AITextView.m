//
//  AITextView.m
//  AISian
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//自定义带有placeholder的textView

#import "AITextView.h"
#import "AIDefine.h"
//#import "UIView+AIExtension.h"
@interface AITextView ()
@property(nonatomic,weak)UILabel *placeholderLabel;
@end
@implementation AITextView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加label
        UILabel *label = [[UILabel alloc]init];
        //设置默认字体
        self.font = [UIFont systemFontOfSize:14];
        //设置占位符默认颜色
        label.textColor = [UIColor lightGrayColor];
        label.font = self.font;
        label.numberOfLines = 0;
        self.placeholderLabel = label;
        [self addSubview:label];
        self.backgroundColor = [UIColor whiteColor];
        //通过监听通知来实现是否隐藏label
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeText:) name:UITextViewTextDidChangeNotification object:self];
        //设置始终有弹簧效果
        self.alwaysBounceVertical = YES;
        //隐藏滚动条
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}
/**
 *  监听文字改变
 */
-(void)changeText:(NSNotification*)notif{
    self.placeholderLabel.hidden = self.hasText;
}

-(void)layoutSubviews{
    CGSize maxSize = CGSizeMake(Mainsize.width, MAXFLOAT);
    NSMutableDictionary *paramDictM = [NSMutableDictionary dictionary];
    paramDictM[NSFontAttributeName] = self.placeholderLabel.font;
    CGSize size = [self.placeholderLabel.text boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:paramDictM context:nil].size;
    AILog(@"%@",NSStringFromCGSize(size));
    self.placeholderLabel.frame = (CGRect){5,8,size};
//    self.placeholderLabel.size = size;
//    self.placeholderLabel.x = 5;
//    self.placeholderLabel.y = 8;
}
#pragma mark -共有方法
- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self changeText:nil];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self changeText:nil];
}
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    [self setNeedsLayout];
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    self.placeholderLabel.textColor = placeholderColor;
}
@end

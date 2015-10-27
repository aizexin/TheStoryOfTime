//
//  AIStatusLabel.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/27.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

/*
 0.显示文字
 1.判断有多少个链接
 2.链接所属的边框范围
 */

#import "AIStatusLabel.h"

@interface AIStatusLabel ()
@property(nonatomic,weak)UITextView *textView;
@end

@implementation AIStatusLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor greenColor];
        UITextView *textView = [[UITextView alloc]init];
        
        //不能编辑
        textView.editable = NO;
        //不能滚动
        textView.scrollEnabled = NO;
        textView.userInteractionEnabled = NO;
        textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        
        textView.backgroundColor = [UIColor clearColor];
        self.textView = textView;
        [self addSubview:textView];
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.textView.frame = self.bounds;
}

#pragma mark -----------公共接口---------------
-(void)setAttributedText:(NSAttributedString *)attributedText{
    _attributedText = attributedText;
    self.textView.attributedText = attributedText;
}


#pragma mark ----------事件处理
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    //计算所有链接
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        NSString *linkText = attrs[AILink];
        if (!linkText) {
            return ;
        }
        //设置选中的字的范围
        self.textView.selectedRange = range;
        //算出选中字符范围的边框
        NSArray *rects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
        for (UITextSelectionRect *selectionRect in rects) {
            
            if (selectionRect.rect.size.width == 0 || selectionRect.rect.size.height == 0) continue;
            if (CGRectContainsPoint(selectionRect.rect, point)) {
                UIView *bg = [[UIView alloc]init];
                bg.layer.cornerRadius = 3;
                bg.frame = selectionRect.rect;
                bg.backgroundColor = [UIColor redColor];
                [self insertSubview:bg atIndex:0];
            }
           
        }

        AILog(@"%@,%@",attrs[AILink],NSStringFromRange(range));
    }];
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
//    AILog(@"%@",NSStringFromCGPoint(point));
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
//    AILog(@"%@",NSStringFromCGPoint(point));
}

@end

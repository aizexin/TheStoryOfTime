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
#import "AILink.h"

#define AILinkBackgroundTag 10000

@interface AIStatusLabel ()
@property(nonatomic,weak)UITextView *textView;
@property(nonatomic,strong)NSMutableArray *links;
@end

@implementation AIStatusLabel

-(NSMutableArray *)links{
    if (!_links) {
        NSMutableArray *links = [NSMutableArray array];
            //计算所有链接
            [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
                NSString *linkText = attrs[AILinkText];
                if (!linkText) {
                    return ;
                }
                //创建一个链接
                AILink *link = [[AILink alloc]init];
                link.text = linkText;
                link.range = range;
                //处理矩形框
                NSMutableArray *rects = [NSMutableArray array];
                
                //设置选中的字的范围
                self.textView.selectedRange = range;
                //算出选中字符范围的边框
                NSArray *selectionRects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
                for (UITextSelectionRect *selectionRect in selectionRects) {
        
                    if (selectionRect.rect.size.width == 0 || selectionRect.rect.size.height == 0) continue;
                    [rects addObject:selectionRect];
                }
                link.rects = rects;
                
                [links addObject:link];
            }];
        _links = links;
    }
    return _links;
}

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
    self.links = nil;
}


#pragma mark ----------事件处理
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    //获得被触摸的链接
    AILink *touchingLink = [self touchLinkWithPoint:point];
    //显示链接的背景颜色
    [self showLinkBackground:touchingLink];
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    //获得被触摸的链接
    AILink *touchingLink = [self touchLinkWithPoint:point];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeAllLinkBackground];
    });
    if (touchingLink) {
        [[NSNotificationCenter defaultCenter]postNotificationName:AILinkDidSelectedNotification object:nil userInfo:@{AILinkText:touchingLink.text}];
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesEnded:touches withEvent:event];
}

#pragma mark ---- 链接背景处理
/**
 *  通过被触摸的点返回对应链接
 *
 *  @param point 被触摸的点
 *
 *  @return 被触摸的链接
 */
-(AILink*)touchLinkWithPoint:(CGPoint)point{
    //查看点击了哪个链接
    __block AILink *touchingLink = nil;
    [self.links enumerateObjectsUsingBlock:^(AILink *link, NSUInteger idx, BOOL *stop) {
        for (UITextSelectionRect *selectionRect in link.rects) {
            if (CGRectContainsPoint(selectionRect.rect, point)) {
                touchingLink = link;
            }
        }
    }];
    return touchingLink;
}

-(void)showLinkBackground:(AILink *)touchingLink{
    for (UITextSelectionRect *selectionRect in touchingLink.rects) {
        //添加背景到选中的范围
        UIView *bg = [[UIView alloc]init];
        bg.tag = AILinkBackgroundTag;
        bg.layer.cornerRadius = 3;
        bg.frame = selectionRect.rect;
        bg.backgroundColor = [UIColor redColor];
        [self insertSubview:bg atIndex:0];
    }
}

-(void)removeAllLinkBackground{
    for (UIView *child in self.subviews) {
        if (child.tag == AILinkBackgroundTag) {
            [child removeFromSuperview];
        }
    }
}

@end

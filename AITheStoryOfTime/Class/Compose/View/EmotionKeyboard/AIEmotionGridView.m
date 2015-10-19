//
//  AIEmotionGridView.m
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/17.
//  Copyright © 2015年 aizexin. All rights reserved.
//   scrollView上一页显示的View

#import "AIEmotionGridView.h"
#import "AIEmotion.h"
#import "AIEmotionView.h"
#import "AIEmotionPopView.h"
#import "AIEmotionTool.h"
#import "UIView+Extension.h"
@interface AIEmotionGridView ()
@property(nonatomic,strong)NSMutableArray *emotionViewM;
/**
 *  删除按钮
 */
@property(nonatomic,weak)UIButton *deletBtn;
/**表情气泡*/
@property(nonatomic,strong)AIEmotionPopView *popView;
@end
@implementation AIEmotionGridView

-(AIEmotionPopView *)popView{
    if (!_popView) {
        _popView = [AIEmotionPopView popView];
    }
    return _popView;
}

-(NSMutableArray *)emotionViewM{
    if (!_emotionViewM) {
        _emotionViewM = [NSMutableArray array];
    }
    return _emotionViewM;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //添加删除按钮
        AIEmotionView *deletBtn = [[AIEmotionView alloc]init];;
        [deletBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:(UIControlStateNormal)];
        [deletBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:(UIControlStateHighlighted)];
        [deletBtn addTarget:self action:@selector(onClickDelete:) forControlEvents:(UIControlEventTouchUpInside)];
        self.deletBtn = deletBtn;
        [self addSubview:deletBtn];
        //添加长按手势
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}


-(AIEmotionView *)emotionViewWithPoint:(CGPoint)point{
   __block AIEmotionView *foundEmotionView = nil;
    [self.emotionViewM enumerateObjectsUsingBlock:^(AIEmotionView  *emotionView, NSUInteger idx, BOOL *  stop) {
        if (CGRectContainsPoint(emotionView.frame, point)) {
            foundEmotionView = emotionView;
            stop = YES;
        }
    }];
    return foundEmotionView;
}

-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    
    NSInteger count = emotions.count;
    NSInteger currentEmotionViewCount = self.emotionViewM.count;
    
    
    for (int i = 0; i < emotions.count; i++) {
        AIEmotionView *emotionView = nil;
        if (i >= currentEmotionViewCount) { //emotionView不够用
            emotionView = [[AIEmotionView alloc]init];
            //添加点击事件
            [emotionView addTarget:self action:@selector(emotionClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [self addSubview:emotionView];
            [self.emotionViewM addObject:emotionView];
        }else{
            emotionView = self.emotionViewM[i];
        }
        AIEmotion *emotion = emotions[i];
        emotionView.emotion = emotion;
        emotionView.hidden = NO;
    }
    // 隐藏多余的emotionView
    for (int i = count; i<currentEmotionViewCount; i++) {
        UIButton *emotionView = self.emotionViewM[i];
        emotionView.hidden = YES;
    }

}

#pragma mark -事件监听
/**
 *  监听点击表情
 */
-(void)emotionClick:(AIEmotionView*)emotionView{
    [self.popView showFromEmotionView:emotionView];
    [self selecteEmotion:emotionView.emotion];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView disMiss];
    });
    
}
/**
 *  长按相应事件
 */
-(void)longPress:(UILongPressGestureRecognizer *)recognizer{
    //获得触摸点
    CGPoint point = [recognizer locationInView:recognizer.view];
    //检测触摸点落在哪个表情上
    AIEmotionView *emotionView = [self emotionViewWithPoint:point];
    if (!emotionView) {
        [self.popView disMiss];
        return;
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {  //松手
        //移除气泡控件
        [self.popView disMiss];
        //选中表情  使用通知，通知控制器
        [self selecteEmotion:emotionView.emotion];
        
    }else{
        //显示表情在气泡中
        [self.popView showFromEmotionView:emotionView];
    }
}
/**
 *  监听删除按钮
 */
-(void)onClickDelete:(AIEmotionView*)delete{
    [[NSNotificationCenter defaultCenter]postNotificationName:AIEmotionDidDeletedNotification object:nil];
}
-(void)selecteEmotion:(AIEmotion *)emotion{
    if (emotion == nil) {
        return;
    }
    [AIEmotionTool addRecentEmotion:emotion];
    //选中表情  使用通知，通知控制器
    [[NSNotificationCenter defaultCenter]postNotificationName:AIEmotionDidSeletedNotification object:nil userInfo:@{AISelectedEmotion:emotion}];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftInset = 15;
    CGFloat topInset = 15;
    int count = (int)self.emotionViewM.count;
    CGFloat emotionViewW = (self.width - 2 *leftInset) / AIEmotionMaxCols;
    CGFloat emotionVIewH = (self.height - topInset)/AIEmotionMaxRows;
    
    
    for (int i = 0; i < count; i++) {
        UIButton *emotionView = self.emotionViewM[i];
        emotionView.x = leftInset + (i%AIEmotionMaxCols) *emotionViewW;
        emotionView.y = topInset + (i / AIEmotionMaxCols) * emotionVIewH;
        emotionView.width = emotionViewW;
        emotionView.height = emotionVIewH;
    }
    //设置delet的frame
    self.deletBtn.width = emotionViewW;
    self.deletBtn.height = emotionVIewH;
    self.deletBtn.x = self.width - self.deletBtn.width - leftInset;
    self.deletBtn.y = self.height - self.deletBtn.height;

}

@end

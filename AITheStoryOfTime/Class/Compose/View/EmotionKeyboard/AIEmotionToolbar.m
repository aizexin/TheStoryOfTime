//
//  AIEmotionToolbar.m
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/17.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import "AIEmotionToolbar.h"
#import "UIView+Extension.h"
@interface AIEmotionToolbar ()
@property(nonatomic,weak)UIButton *selBtn;
@end

@implementation AIEmotionToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加工具条上按钮
        [self setupButton:@"最近" type:AIEmotionTypeRecent];
        [self setupButton:@"默认"type:AIEmotionTypeDefault];
        [self setupButton:@"Emoji"type:AIEmotionTypeEmoji];
        [self setupButton:@"浪小花"type:AIEmotionTypeLxh];
        
    }
    return self;
}
-(void)layoutSubviews{
    //设置工具条上按钮
    
    for (int i = 0; i < AIEmotionToolbarCount; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = Mainsize.width/AIEmotionToolbarCount;
        btn.height = self.height;
        btn.x = i * btn.width;
    }
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
-(UIButton*)setupButton:(NSString*)title type:(AIEmotionType)type{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.tag = type;
    //设置文字
    [btn setTitle:title forState:(UIControlStateNormal)];
    
    btn.titleLabel.font = AIComposeToolbarFont;
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateSelected)];
    [btn addTarget:self action:@selector(onClickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    //添加按钮
    [self addSubview:btn];
    //设置图片
    int count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        if (count == 1) {
            //第一个
            [btn setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_normal"] forState:(UIControlStateNormal)];
            [btn setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_selected"] forState:(UIControlStateSelected)];
        }else if (count == AIEmotionToolbarCount){
            [btn setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_normal"] forState:(UIControlStateNormal)];
            [btn setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_selected"] forState:(UIControlStateSelected)];
        }else{
            //中间
            [btn setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_normal"] forState:(UIControlStateNormal)];
            [btn setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_selected"] forState:(UIControlStateSelected)];
        }
    }
    
    return btn;
}

-(void)setDelegate:(id<AIEmotionToolbarDelegate>)delegate{
    _delegate = delegate;
    //默认选中
    UIButton *defaultButton = (UIButton*)[self viewWithTag:AIEmotionTypeDefault];
    [self onClickBtn:defaultButton];
    
}

#pragma mark -按钮点击事件
-(void)onClickBtn:(UIButton*)btn{
    self.selBtn.selected = NO;
    btn.selected = YES;
    self.selBtn = btn;
    if ([self.delegate respondsToSelector:@selector(emotionToolbar:didSelectedButton:)]) {
        [self.delegate emotionToolbar:self didSelectedButton:btn.tag];
    }
}
@end

//
//  AIBirthBottomView.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIBirthBottomView.h"
#import "AIDateTool.h"
#import "AIFixScreen.h"
#import "AIBirthListView.h"
#define ShareBtnW 30
#define ShareBtnH 40
#define TipsH 25
@interface AIBirthBottomView ()
/**现在年龄*/
@property(nonatomic,weak)UILabel *nowAgelabel;
/**分享按钮*/
@property(nonatomic,weak)UIButton *shareBtn;
/**listView*/
@property(nonatomic,weak)AIBirthListView *listView;
/**提示*/
@property(nonatomic,weak)UILabel *tipsLabel;
/**跳转按钮*/
@property(nonatomic,weak)UIButton *jumpBtn;

/**定时器*/
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation AIBirthBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //现在年龄
        UILabel *ageLabel = [[UILabel alloc]init];
        [ageLabel setTextAlignment:(NSTextAlignmentRight)];
        self.nowAgelabel = ageLabel;
        [self addSubview:ageLabel];
        //分享按钮
        UIButton *shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [shareBtn setImage:[UIImage imageNamed:@"share_btn_night"] forState:(UIControlStateNormal)];
        self.shareBtn = shareBtn;
        [self addSubview:shareBtn];
        //tips
        UILabel *tipsLabel = [[UILabel alloc]init];
        self.tipsLabel = tipsLabel;
        [self addSubview:tipsLabel];
        
        //listView
        AIBirthListView *listView = [[AIBirthListView alloc]init];
        listView.die = YES;
        self.listView = listView;
        [self addSubview:listView];
        listView.backgroundColor = [UIColor greenColor];
        
        //跳转按钮
        UIButton *jumpBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [jumpBtn addTarget:self action:@selector(onClickJump:) forControlEvents:(UIControlEventTouchUpInside)];
        [jumpBtn setBackgroundColor:[UIColor blueColor]];
        self.jumpBtn = jumpBtn;
        [self addSubview:jumpBtn];
        [self fitScreen];
    }
    return self;
}

-(void)setDie:(BOOL)die{
    _die = die;
    [self startChange];
    self.listView.die = die;
    [self changeAge];
    //标签
    NSString *dieString = @"这是你生命中的";
    NSString *unDieString = @"在这个世界,你已经存在了";
    self.tipsLabel.text = die?dieString:unDieString;
    //按钮
    if (die) {
        [self.jumpBtn setTitle:@"死之钟" forState:(UIControlStateNormal)];
    }else{
        [self.jumpBtn setTitle:@"生之时" forState:(UIControlStateNormal)];
    }
    [self fitScreen];
}
/**
 *  改变年龄
 */
-(void)changeAge{
    if (!self.isDie) { //如果是生之时
        //年龄
        NSString *nowAge = [NSString stringWithFormat:@"%.8f",[AIDateTool allSeconds]/AIAllSecondOfYear];
        self.nowAgelabel.text  = [NSString stringWithFormat:@"你 %@ 岁了",nowAge];
    }
}

/**
 *  屏幕适配
 */
-(void)fitScreen{
    //年龄
    [self.nowAgelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(self.shareBtn.mas_left).offset = 0;
        make.height.equalTo(self.shareBtn.height);
    }];
    //分享按钮
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@(ShareBtnH));
        make.width.equalTo(@(ShareBtnW));
    }];
    //tips
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(self.nowAgelabel.bottom).offset = 0;
        make.height.equalTo(@(TipsH));
        make.width.equalTo(self.mas_width);
    }];
    //list
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(self.tipsLabel.mas_bottom).offset = 0;
        make.right.equalTo(@0);
        make.bottom.equalTo(self.jumpBtn.mas_top).offset = 0;
    }];
    //jumpBtn
    [self.jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.listView.mas_bottom).offset = 0;
        make.right.equalTo(@(-20));
        make.bottom.equalTo(@0);
    }];
    
}

#pragma mark 定时器相关
-(void)startChange{
    
//    if (self.timer) {
////        self.timer.fireDate = [NSDate distantFuture];
//    }else{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(starTimer) userInfo:nil repeats:YES];
//    }
    
}
-(void)stopChange{
//    [self.timer animationDidStop:nil finished:YES];
    self.timer.fireDate = [NSDate distantPast];
}
-(void)starTimer{
    [self changeAge];
    //TODO通知listView也改变值
    [self.listView startChange];
}

#pragma mark -点击事件
-(void)onClickJump:(UIButton*)jump{
    jump.selected = !jump.isSelected;
    if ([self.delegate respondsToSelector:@selector(birthBottomViewDidChange:)]) {
        [self.delegate birthBottomViewDidChange:self];
    }
}

@end

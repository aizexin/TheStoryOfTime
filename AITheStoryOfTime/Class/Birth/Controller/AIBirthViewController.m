//
//  AIBirthViewController.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIBirthViewController.h"
#import "BEMAnalogClockView.h"
#import "AIBirthBottomView.h"
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#define ClockPadding 45.0;
#define BottomViewPadding 10

@interface AIBirthViewController ()
@property(nonatomic,strong)BEMAnalogClockView *nowColck;
@property(nonatomic,strong)AIBirthBottomView *bottomView;
/**
 *  侧滑后能显示出来的view
 */
@property(nonatomic,strong)UIView *bgView;
@end

@implementation AIBirthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupbgView];
    [self.view setBackgroundColor:AIColor(211, 211, 211)];
    [self setupNowColock];
    [self setupBottonView];
    [self fitScrceen];
}
/**
 *  添加现在的时钟
 */
-(void)setupNowColock{
    //添加时钟

    BEMAnalogClockView *nowColck = [[BEMAnalogClockView alloc]init];
    self.nowColck = nowColck;
    //设置时钟里的属性
    self.nowColck.enableShadows = YES;
    self.nowColck.realTime = YES;
    self.nowColck.currentTime = YES;
    self.nowColck.borderColor = AIColor(26, 26, 1);
    //设置三个指针颜色
    self.nowColck.hourHandColor = [UIColor blackColor];
    self.nowColck.minuteHandColor = [UIColor blackColor];
    self.nowColck.secondHandColor = [UIColor redColor];
    //设置时钟里面的背景的颜色
    self.nowColck.faceBackgroundColor = [UIColor clearColor];
    self.nowColck.secondHandWidth = 2;
    //是否允许数字
    self.nowColck.enableDigit = NO;
    //取消刻度
    self.nowColck.enableGraduations = NO;

    [self.bgView addSubview:nowColck];
}

/**
 *  设置下面的view
 */
-(void)setupBottonView{

    AIBirthBottomView *bottomView = [[AIBirthBottomView alloc]init];
    [self.bgView addSubview:bottomView];
    self.bottomView = bottomView;
//    [self.bottomView setBackgroundColor:[UIColor redColor]];

}
/**
 *  设置能显示出来的view
 */
-(void)setupbgView{
    UIView *view = [[UIView alloc]init];
    self.bgView = view;
    [self.view addSubview:view];
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(self.view.width).multipliedBy(AIBirthShowScale);
    }];
}
/**
 *  屏幕适配
 */
-(void)fitScrceen{
    //时钟
    CGFloat padding = ClockPadding;
    [self.nowColck makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.top).offset = padding;
        make.right.equalTo(self.bgView.right).offset = -padding;
        make.left.equalTo(self.bgView.left).offset = padding;
        make.bottom.equalTo(self.bottomView.top).offset(@0);//self.bottomView).offset(@0);
        make.width.mas_equalTo(self.nowColck.height);
    }];
//    bottomView
    CGFloat viewPadding = BottomViewPadding;
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {

//        make.top.mas_equalTo(self.nowColck.bottom).offset = 0;
        make.right.equalTo(@(-viewPadding));
        make.left.equalTo(@(viewPadding));
        make.bottom.equalTo(@(-viewPadding));
    }];
}


@end

//
//  AIBirthViewController.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIBirthViewController.h"
#import "BEMAnalogClockView.h"


@interface AIBirthViewController ()
@property(nonatomic,strong)BEMAnalogClockView *nowColck;
@property(nonatomic,strong)UIView *bottomView;
@end

@implementation AIBirthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:AIColor(190, 190, 190)];
    [self setupNowColock];
    [self setupBottonView];
}
/**
 *  添加现在的时钟
 */
-(void)setupNowColock{
    //添加时钟
    CGFloat padding = 45;
    CGFloat nowColockW = Mainsize.width - 2*padding;
    CGFloat nowColockH = nowColockW;
    CGFloat nowColckX = padding;
    CGFloat nowColckY = padding;
    
    BEMAnalogClockView *nowColck = [[BEMAnalogClockView alloc]initWithFrame:CGRectMake(nowColckX, nowColckY, nowColockW, nowColockH)];
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
    
   
    [self.view addSubview:nowColck];
}

/**
 *  设置下面的view
 */
-(void)setupBottonView{
    CGFloat viewPadding = 10;
//    UILabel *label = [[UILabel alloc]init];
    CGFloat viewX = viewPadding;
    CGFloat viewY = CGRectGetMaxY(self.nowColck.frame)+ viewPadding;
    CGFloat viewW = (self.view.width - 2*viewPadding);
    CGFloat viewH = self.view.height * 0.5;
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    [self.bottomView setBackgroundColor:[UIColor redColor]];
    
}


@end

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
#import "UUDatePicker.h"
#import "UUDatePicker_DateModel.h"
#import "AIDateTool.h"
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#define ClockPadding 45.0;
#define BottomViewPadding 10

@interface AIBirthViewController ()<UUDatePickerDelegate>
@property(nonatomic,strong)BEMAnalogClockView *nowColck;
@property(nonatomic,strong)AIBirthBottomView *bottomView;
/**侧滑后能显示出来的view*/
@property(nonatomic,strong)UIView *bgView;
/**设置*/
@property(nonatomic,weak)UIButton *settingBtn;
/**蒙版 */
@property(nonatomic,strong)UIButton *core;
/**日期选择*/
@property(nonatomic,strong)UUDatePicker *dateView;
/**选中的时间模型*/
@property(nonatomic,strong)UUDatePicker_DateModel *seldate_dateModel;
@end

@implementation AIBirthViewController

#pragma mark 初始化方法
-(UUDatePicker_DateModel *)seldate_dateModel{
    if (!_seldate_dateModel) {
        _seldate_dateModel  = [[UUDatePicker_DateModel alloc]init];
    }
    return _seldate_dateModel;
}

-(UIView *)dateView{
    if (!_dateView) {
        _dateView = [[UUDatePicker alloc]init];
        _dateView.delegate = self;
        [_dateView setDatePickerStyle:(UUDateStyle_YearMonthDayHourMinute)];
        //设置最大时间为现在
        _dateView.maxLimitDate = [NSDate date];
//        _dateView.minLimitDate = nsdate
        [_dateView setBackgroundColor:[UIColor greenColor]];
      
    }
    return _dateView;
}

-(UIButton *)core{
    if (!_core) {
        _core = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _core.frame = self.bgView.bounds;
        _core.alpha = 0.3;
        _core.backgroundColor = [UIColor blackColor];
        [_core addTarget:self action:@selector(onClickCoreBtn:) forControlEvents:(UIControlEventTouchDown)];
        [_core setTitle:@"出生日" forState:(UIControlStateNormal)];
    }
    return _core;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupbgView];
    [self setupSetting];
    [self.view setBackgroundColor:AIColor(211, 211, 211)];
    [self setupNowColock];
    [self setupBottonView];
    [self fitScrceen];
}
/**
 *  添加设置按钮
 */
-(void)setupSetting{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.settingBtn = btn;
    [btn setImage:[UIImage imageNamed:@"left_set_ic"] forState:(UIControlStateNormal)];
    [self.bgView addSubview:btn];
    [btn addTarget:self action:@selector(onClickSettingBtn:) forControlEvents:(UIControlEventTouchUpInside)];
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
    //设置按钮
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset = 5;
        make.right.mas_equalTo(self.bgView.mas_right).offset = -5;
        make.width.mas_equalTo(@(40));
        make.height.mas_equalTo(@40);
        
    }];
    
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
#pragma mark -点击事件
-(void)onClickSettingBtn:(UIButton*)btn{
    //选择出生年月日
    
    [UIView animateWithDuration:.5 animations:^{
        
//        self.nowColck.hours = 0;
//        self.nowColck.minutes = 0;
//        self.nowColck.seconds = 0;
        [self.nowColck stopRealTime];
        self.bottomView.alpha = 0;
        
    }];
    [self.bgView insertSubview:self.core belowSubview:self.view];
    [self.bgView addSubview:self.dateView];
    [_dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.left.mas_equalTo(@0);
        make.height.mas_equalTo(@200);
    }];
}
/**
 *  点击蒙版
 */
-(void)onClickCoreBtn:(UIButton*)core{
    [self.dateView removeFromSuperview];
    [core removeFromSuperview];
    [UIView animateWithDuration:.5 animations:^{
        self.nowColck.currentTime = YES;
        [self.nowColck startRealTime];
        self.bottomView.alpha = 1;
    }];
    //这个时候确定时间
    //存储到沙盒
    [AIDateTool save:self.seldate_dateModel];
    
}
#pragma mark 代理方法
#pragma mark -UUDatePickerDelegate
-(void)uuDatePicker:(UUDatePicker *)datePicker year:(NSString *)year month:(NSString *)month day:(NSString *)day hour:(NSString *)hour minute:(NSString *)minute weekDay:(NSString *)weekDay{
    //得到时间
    AILog(@"year = %@,month = %@",year,month);
    self.seldate_dateModel.year = year;
    self.seldate_dateModel.month = month;
    self.seldate_dateModel.day = day;
    self.seldate_dateModel.hour = hour;
    self.seldate_dateModel.minute = minute;
    
}


@end

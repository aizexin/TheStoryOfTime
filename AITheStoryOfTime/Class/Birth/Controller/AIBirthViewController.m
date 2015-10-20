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
#import "AIFixScreen.h"
#import "test.h"
//#import "AIBirthEndViewController.h"
#define ClockPadding 45.0;
#define BottomViewPadding 10

@interface AIBirthViewController ()<UUDatePickerDelegate,AIBirthBottomViewDelegate>
/**
 *  生之钟
 */
@property(nonatomic,strong)BEMAnalogClockView *nowColck;


@property(nonatomic,strong)AIBirthBottomView *bottomView;
/**侧滑后能显示出来的view*/
@property(nonatomic,strong)UIView *bgView;
/**设置*/
@property(nonatomic,strong)UIButton *settingBtn;
/**蒙版 */
@property(nonatomic,strong)UIButton *core;
/**日期选择*/
@property(nonatomic,strong)UUDatePicker *dateView;
/**选中的时间模型*/
@property(nonatomic,strong)UUDatePicker_DateModel *seldate_dateModel;
@end

@implementation AIBirthViewController


#pragma mark 懒加载
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
    }
    return _dateView;
}

-(UIButton *)core{
    if (!_core) {
        _core = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _core.frame = [UIScreen mainScreen].bounds;
        _core.alpha = 0.3;
        _core.backgroundColor = [UIColor blackColor];
        [_core addTarget:self action:@selector(onClickCoreBtn:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _core;
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
    }
    return _bgView;
}

-(UIButton *)settingBtn{
    if (!_settingBtn) {
        _settingBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return _settingBtn;
}

-(BEMAnalogClockView *)nowColck{
    if (!_nowColck) {
        _nowColck = [[BEMAnalogClockView alloc]init];
//        _nowColck = nowColck;
        //设置时钟里的属性
        _nowColck.enableShadows = YES;
        _nowColck.realTime = YES;
        _nowColck.currentTime = YES;
        _nowColck.borderColor = AIColor(26, 26, 1);
   
        //设置时钟里面的背景的颜色
        _nowColck.faceBackgroundColor = [UIColor clearColor];
        _nowColck.secondHandWidth = 2;
        //是否允许数字
        _nowColck.enableDigit = NO;
        //取消刻度
        _nowColck.enableGraduations = NO;
        //中心颜色
        _nowColck.hubColor = [UIColor redColor];
        _nowColck.hubRadius = 5;
        _nowColck.enableHub = YES;
        //设置三个指针颜色
        _nowColck.hourHandColor = [UIColor blackColor];
        _nowColck.minuteHandColor = [UIColor blackColor];
        _nowColck.secondHandColor = [UIColor redColor];
    }
    return _nowColck;
}



#pragma mark 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.die = NO;
}
/**
 *  添加设置按钮
 */
-(void)setupUI{
    //设置背景view
    [self.view addSubview:self.bgView];
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(self.view.width).multipliedBy(AIBirthShowScale);
    }];
    //设置按钮
    [self.settingBtn setImage:[UIImage imageNamed:@"left_set_ic"] forState:(UIControlStateNormal)];
    [self.bgView addSubview:self.settingBtn];
    [self.settingBtn addTarget:self action:@selector(onClickSettingBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    //添加时钟
    [self.bgView addSubview:self.nowColck];
    AIBirthBottomView *bottomView = [[AIBirthBottomView alloc]init];
    //设置代理
    bottomView.delegate = self;
    [self.bgView addSubview:bottomView];
    self.bottomView = bottomView;
    //适配
    [self fitScrceen];
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
        make.bottom.equalTo(self.bottomView.top).offset(@0);
        make.width.mas_equalTo(self.nowColck.height);
    }];
//    bottomView
    CGFloat viewPadding = BottomViewPadding;
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {

        make.right.equalTo(@(-viewPadding));
        make.left.equalTo(@(viewPadding));
        make.bottom.equalTo(@(-viewPadding));
    }];
}

-(void)setDie:(BOOL)die{
    _die = die;
    self.bottomView.die = die;
    //根据die设置now的颜色
    if (self.isDie) {
        _nowColck.hourHandColor = [UIColor greenColor];
        _nowColck.minuteHandColor = [UIColor greenColor];
        _nowColck.secondHandColor = [UIColor greenColor];
        _bgView.backgroundColor = AIColor(211, 211, 211);
        //设置最小时间时间为现在
        self.dateView.maxLimitDate = nil;
        self.dateView.minLimitDate = [NSDate date];
    }else{
        _nowColck.hourHandColor = [UIColor redColor];
        _nowColck.minuteHandColor = [UIColor redColor];
        _nowColck.secondHandColor = [UIColor redColor];
        _bgView.backgroundColor = [UIColor whiteColor];
        //设置最大时间为现在
        self.dateView.maxLimitDate = [NSDate date];
        self.dateView.minLimitDate = nil;
    }
    [self.nowColck reloadClock];
}

#pragma mark -点击事件
-(void)onClickSettingBtn:(UIButton*)btn{
    if (self.isDie) {
        [_core setTitle:@"猜测自己能活到什么时候" forState:(UIControlStateNormal)];
    }else{
        [_core setTitle:@"出生日" forState:(UIControlStateNormal)];
    }
    //选择出生年月日
    
    [UIView animateWithDuration:.5 animations:^{
        self.nowColck.hours = 0;
        self.nowColck.minutes = 0;
        self.nowColck.seconds = 0;
        [self.nowColck reloadClock];
        [self.nowColck stopRealTime];
        self.bottomView.alpha = 0;
    }];

    UIWindow *lastWindow = [[UIApplication sharedApplication].windows lastObject];
    [lastWindow addSubview:self.core];
    [lastWindow addSubview:self.dateView];

    [_dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(@0);
        make.height.mas_equalTo(@216);
        make.width.mas_equalTo(@320);
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
    [AIDateTool save:self.seldate_dateModel die:self.isDie];
    //叫bottom开启定时器
    [self.bottomView startChange];
    
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

#pragma mark -AIBirthBottomViewDelegate
-(void)birthBottomViewDidChange:(AIBirthBottomView *)BottomView{
    
    [UIView transitionWithView:self.view duration:1. options:(UIViewAnimationOptionTransitionFlipFromTop) animations:^{
        self.die = !self.isDie;
    } completion:^(BOOL finished) {
        
    }];
}

@end

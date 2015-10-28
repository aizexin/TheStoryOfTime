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
#import "AIScreenTool.h"
#define ClockPadding 45.0
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
/**最大时间*/
@property(nonatomic,strong)NSDate *maxDate;
@end

@implementation AIBirthViewController


#pragma mark 懒加载

-(NSDate *)maxDate{
    if (!_maxDate) {
        _maxDate = [[NSDate alloc]init];
        NSDateFormatter *datefm = [[NSDateFormatter alloc]init];
        datefm.dateFormat = @"yyyyMMddHHmmss";
        _maxDate = [datefm dateFromString:@"21501100000000"];
    }
    return _maxDate;
}

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
        _nowColck.currentTime = YES;
        _nowColck.borderColor = AIColor(26, 26, 1);
   
        //设置时钟里面的背景的颜色
        _nowColck.faceBackgroundColor = [UIColor clearColor];
        _nowColck.secondHandWidth = 2;
        //是否允许数字
        _nowColck.enableDigit = NO;
        //取消刻度
        _nowColck.enableGraduations = NO;
        
        //设置三个指针颜色
        _nowColck.hourHandColor = [UIColor blackColor];
        _nowColck.minuteHandColor = [UIColor blackColor];
        _nowColck.secondHandColor = [UIColor redColor];
        //设置指针长度
        _nowColck.secondHandLength = (Mainsize.width - 2 * (ClockPadding+Mainsize.width * 0.11))*0.5;
        _nowColck.minuteHandLength = (_nowColck.secondHandLength *0.8 );
        _nowColck.hourHandLength = _nowColck.secondHandLength * 0.5;
        
        _nowColck.secondHandOffsideLength = 15;
        _nowColck.minuteHandOffsideLength = 10;
        _nowColck.hourHandOffsideLength = 5;
        _nowColck.borderWidth = 10;
        //中心颜色
        _nowColck.hubColor = [UIColor redColor];
        _nowColck.hubRadius = 5;
        _nowColck.enableHub = YES;
        //让钟动起来
        _nowColck.realTime = YES;
        
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
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(self.view.mas_width).multipliedBy(AIBirthShowScale);
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
    [self.nowColck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_top).offset = padding;
        make.right.equalTo(self.bgView.mas_right).offset = -padding;
        make.left.equalTo(self.bgView.mas_left).offset = padding;
        make.bottom.equalTo(self.bottomView.mas_top).mas_offset(@-50);
        make.width.mas_equalTo(self.nowColck.mas_height);
    }];
    //时钟的指针
    
//    bottomView
    CGFloat viewPadding = BottomViewPadding;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.equalTo(@(-viewPadding));
        make.left.equalTo(@(viewPadding));
        make.bottom.equalTo(@(-viewPadding));
    }];
}

-(void)setDie:(BOOL)die{
    _die = die;
    self.bottomView.die = die;
    //根据die设置now的颜色
    if (self.isDie) {  //死之中
        _nowColck.currentTime = NO;
        _nowColck.hourHandColor = [UIColor whiteColor];
        _nowColck.minuteHandColor = [UIColor whiteColor];
        _nowColck.secondHandAlpha = 0;
        //设置死钟指针
        [self setdieColck];
       _bgView.backgroundColor = [UIColor lightGrayColor];
        //设置最小时间时间为现在
        self.dateView.maxLimitDate = self.maxDate;
        self.dateView.minLimitDate = [NSDate date];
    }else{
        //设置时间
        _nowColck.currentTime = YES;
        _nowColck.secondHandAlpha = 1;
        _nowColck.hourHandColor = [UIColor blackColor];
        _nowColck.minuteHandColor = [UIColor blackColor];
        _nowColck.secondHandColor = [UIColor redColor];
        _bgView.backgroundColor = [UIColor whiteColor];
        //设置最大时间为现在
        self.dateView.maxLimitDate = [NSDate date];
        self.dateView.minLimitDate = nil;
    }
    [self.nowColck reloadClock];
}
/**
 *  设置死钟的指针
 */
-(void)setdieColck{
    [self.nowColck reloadClock];
    double proportion = [AIDateTool brith2NowAllSeconds]/[AIDateTool brith2EndAllSeconds];
    NSInteger hours = (NSInteger)(24 * proportion);
    NSInteger showHour = hours;
    if (showHour>=12) {
        showHour -= 12;
    }
    NSInteger minutes = (24*proportion - hours) * 60;
    _nowColck.hours = showHour;
    _nowColck.minutes = minutes;
    [self.nowColck updateTimeAnimated:YES];
}

#pragma mark -点击事件
-(void)onClickSettingBtn:(UIButton*)btn{
    //暂停定时器
    [self.bottomView stopChange];
    //让时钟归0
    [self show0Colck];
    UIWindow *lastWindow = [[UIApplication sharedApplication].windows lastObject];
    [lastWindow addSubview:self.core];
    //选择出生年月日
    //显示日历
    [self showDateView:lastWindow];
}
/**
 *  显示指针为0的时钟
 */
-(void)show0Colck{
    if (self.isDie) {
        [_core setTitle:@"猜测自己能活到什么时候" forState:(UIControlStateNormal)];
    }else{
        [_core setTitle:@"出生日" forState:(UIControlStateNormal)];
    }
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:.5 animations:^{
        weakSelf.nowColck.hours = 0;
        weakSelf.nowColck.minutes = 0;
        weakSelf.nowColck.seconds = 0;
        [weakSelf.nowColck updateTimeAnimated:YES];
        [weakSelf.nowColck stopRealTime];
        weakSelf.bottomView.alpha = 0;
    }];
}
/**
 *  显示日历
 */
-(void)showDateView:(UIWindow*)lastWindow{
    //需要直接回到现在
    [self.dateView scroll2NowDate];
    [lastWindow addSubview:self.dateView];
    
    CGFloat dateViewX = (self.bgView.frame.size.width - 320.0)*0.5;
    [_dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(@0);
        make.height.mas_equalTo(@216);
        make.width.mas_equalTo(@320);
        make.left.mas_equalTo(@(dateViewX));
    }];
}

/**
 *  点击蒙版
 */
-(void)onClickCoreBtn:(UIButton*)core{
    [self.dateView removeFromSuperview];
    [core removeFromSuperview];
    __weak typeof (self) weakSelf = self;

    [UIView animateWithDuration:.5 animations:^{
        weakSelf.bottomView.alpha = 1;
    }];
    if (self.isDie) { //死之中
        [self setdieColck];
    }else{
        [self.nowColck reloadClock];
    }
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
//    AILog(@"year = %@,month = %@",year,month);
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

-(void)birthBottomViewDidShare:(AIBirthBottomView *)BottomView{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
   UIImage *shareImage = [AIScreenTool screenWithSize:self.bgView.bounds.size inView:self.bgView];
    
    [UMSocialSnsService presentSnsIconSheetView:window.rootViewController appKey:AIUMAPPKEY shareText:@"时间,时间" shareImage:shareImage shareToSnsNames:[NSArray arrayWithObjects:
                                                                                                                                                     UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToQQ,nil] delegate:self];
//    //分享微信的时候选择消息类型
//    //1.纯图片
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
//    //2.纯文字，点击不会跳转
//    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeText;
//    //3.分享本应用，应用地址是微信开放平台填写的地址
//    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
}

-(void)viewWillAppear:(BOOL)animated{
    //因为ddMenu划过来会调用两次这个函数，时钟值刷新一次
    static NSInteger indexshow = 0;
    [super viewWillAppear:animated];
    if (0 == indexshow%2) {
        if (self.isDie) {//如果是死钟
            [self setdieColck];
        }else{
            [self.nowColck reloadClock];
        }
        AILog(@"viewWillAppear0-----------------");
    }
    indexshow++;
}
@end

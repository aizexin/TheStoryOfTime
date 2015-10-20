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
#define ShareBtnW 30
#define ShareBtnH 40
#define TipsH 25
@interface AIBirthBottomView ()
/**现在年龄*/
@property(nonatomic,weak)UILabel *nowAgelabel;
/**分享按钮*/
@property(nonatomic,weak)UIButton *shareBtn;
/**listView*/
@property(nonatomic,weak)UIView *listView;
/**提示*/
@property(nonatomic,weak)UILabel *tipsLabel;
/**跳转按钮*/
@property(nonatomic,weak)UIButton *jumpBtn;
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
        tipsLabel.text = @"在这个世界上,你已经存在了";
        [self addSubview:tipsLabel];
        
        //listView
        UIView *listView = [[UIView alloc]init];
        self.listView = listView;
        [self addSubview:listView];
        listView.backgroundColor = [UIColor greenColor];
        
        //跳转按钮
        UIButton *jumpBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [jumpBtn setBackgroundColor:[UIColor blueColor]];
        self.jumpBtn = jumpBtn;
        [self addSubview:jumpBtn];
        [self fitScreen];
        [self setupData];
    }
    return self;
}
-(void)setupData{
    //只需要告诉listView显示生还是死
    NSDateComponents *components = [AIDateTool existToday];
    if (components) {
#warning 已经读取出来数据准备设置
        AILog(@"year = %ld month = %ld",components.year,components.month);
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
-(void)viewDidAppear:(BOOL)animated{
    //从沙盒中取出数据
//    UUDatePicker_DateModel *birthModel = [AIDateTool dateBirth];
//    if (birthModel) {
//        self.
//    }
  
//    self.nowAgelabel.text = [NSString stringWithFormat:@"你"]
}

@end

//
//  ScreenshotDetailViewController.m
//  Category_demo
//
//  Created by songjian on 13-5-15.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "ScreenshotDetailViewController.h"

@implementation ScreenshotDetailViewController

#pragma mark - Handle Action

- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)onClickShare{
   
    [UMSocialSnsService presentSnsIconSheetView:self appKey:AIUMAPPKEY shareText:@"我的路径" shareImage:self.screenshotImage shareToSnsNames:[NSArray arrayWithObjects:
                                                                                                                                          UMShareToSina,nil] delegate:self];
    //1.纯图片
    //    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage;
        //分享微信的时候选择消息类型
  
//        [UMSocialData defaultData].extConfig.qqData = UMSocialWXMessageTypeImage;
//        //2.纯文字，点击不会跳转
//        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeText;
//        //3.分享本应用，应用地址是微信开放平台填写的地址
//        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
}

#pragma mark - Initialization

- (void)initNavigationBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                          target:self
                                                                                          action:@selector(backAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:(UIBarButtonItemStylePlain) target:self action:@selector(onClickShare)];
}

- (void)initImageView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.screenshotImage];
    imageView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
                                | UIViewAutoresizingFlexibleRightMargin
                                | UIViewAutoresizingFlexibleTopMargin
                                | UIViewAutoresizingFlexibleBottomMargin;
    
    [self.view addSubview:imageView];
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self initImageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barStyle    = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
}

@end

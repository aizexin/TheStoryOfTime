//
//  AIHomeHttpLinkViewController.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/27.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIHomeHttpLinkViewController.h"
#import "SVProgressHUD.h"
@interface AIHomeHttpLinkViewController ()<UIWebViewDelegate>
@property(nonatomic,weak)UIWebView *webView;
@end

@implementation AIHomeHttpLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加webView
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, Mainsize.width, Mainsize.height - AINavgationBarH)];
    webView.delegate = self;
    [self.view addSubview:webView];
    //
    NSURL *url = [NSURL URLWithString:self.httpLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    self.automaticallyAdjustsScrollViewInsets = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithStatus:@"正在玩儿命的加载..."];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"网速不给力哦~"];
    [SVProgressHUD dismiss];
}



@end

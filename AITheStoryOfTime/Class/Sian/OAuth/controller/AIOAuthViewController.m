//
//  AIOAuthViewController.m
//  AISian
//
//  Created by 艾泽鑫 on 15/10/7.
//  Copyright © 2015年 aizexin. All rights reserved.
//
/*client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。*/
//返回结果
//"access_token" = "2.00dUXnZF0Qvf9c1edfd95781084m7I";
//"expires_in" = 157679999;
//"remind_in" = 157679999;
//uid = 5109642743;

#import "AIOAuthViewController.h"
#import "AIDefine.h"
#import "MBProgressHUD+NJ.h"
#import "AINewFeatureViewController.h"
#import "AITabBarViewController.h"
#import "AIControllerTool.h"
#import "AIAccountTool.h"
#import "AIAccountModel.h"
#import "AIHttpTool.h"
@interface AIOAuthViewController ()<UIWebViewDelegate>
@end

@implementation AIOAuthViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //判断是否有网
    if (![AIHttpTool isReachable]) {

        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"picture_timeout_night"]];
        imageView.userInteractionEnabled = YES;
        imageView.center = self.view.center;
        [self.view addSubview:imageView];
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reloadView)];
        [imageView addGestureRecognizer:tap];
        [self.view setBackgroundColor:[UIColor whiteColor]];
//        [self.view addSubview:reloadBtn];
        return;
    }
    
    // 1.创建UIWebView
    UIWebView *webView = [[UIWebView alloc] init];
    CGRect rect = self.view.bounds;
    rect.origin.y += AINavgationBarH;
    rect.size.height = Mainsize.height - AINavgationBarH -44;
    webView.frame = rect;
    [self.view addSubview:webView];
    // 2.加载登录页面
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",AIAppKey,AIAppRediectURI]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.delegate = self;
    
}

#pragma mark ----点击事件
-(void)reloadView{
    [self viewDidLoad];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    AILog(@"%@",request.URL.absoluteString);
    //1.获得请求路径
    NSString *url = request.URL.absoluteString;
    //2.判断是不是回调地址
    NSString *string = [NSString stringWithFormat:@"%@/?code=",AIAppRediectURI];
    NSRange range = [url rangeOfString:string];
    if (range.location != NSNotFound) {//是回调地址
        //        获得code
        NSString *code = [[url componentsSeparatedByString:string]lastObject];
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}
/**
 *  根据code获取accessToken
 */
-(void)accessTokenWithCode:(NSString*)code{
  
    //2.
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[@"client_id"] = AIAppKey;
    dictM[@"client_secret"] = AIAppSecrect;
    dictM[@"grant_type"] = @"authorization_code";
    dictM[@"redirect_uri"] = AIAppRediectURI;
    dictM[@"code"] = code;
    [AIHttpTool post:@"https://api.weibo.com/oauth2/access_token" params:dictM success:^(id responseObject) {
        //面向模型开发，把字典转换为模型
        AIAccountModel *model = [AIAccountModel accountWithDict:responseObject];
        //得到的accessToken写入沙盒
        [AIAccountTool save:model];
        //选着控制器
        [AIControllerTool chooseRootController];
    } failure:^(NSError *error) {
        AILog(@"请求失败%@",error.description);
    }];
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在拼命的加载。。。"];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [MBProgressHUD hideHUD];
}

@end

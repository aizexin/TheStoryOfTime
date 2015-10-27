//
//  AppDelegate.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//
#import "AppDelegate.h"
#import "AIOAuthViewController.h"
#import "AIControllerTool.h"
#import "AIAccountModel.h"
#import "AIAccountTool.h"
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import <MAMapKit/MAMapKit.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //高德地图
    [MAMapServices sharedServices].apiKey = AIMAPKEY;
    //分享
    [UMSocialData setAppKey:AIUMAPPKEY];
    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:AIAppRediectURI];
    [UMSocialWechatHandler setWXAppId:AIWeChatAPPID appSecret:AIWeChatAPPSecret url:AIAppRediectURI];

    [UMSocialQQHandler setQQWithAppId:AIQQAPPID appKey:AIQQAPPSecret url:AIAppRediectURI];
    
    
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds ;

    [UMSocialData setAppKey:AIUMAPPKEY];
    [self.window makeKeyAndVisible];
    [AIControllerTool chooseRootController];
    
//    AIAccountModel *account = [AIAccountTool account];
//    
//    if (account.access_token) {
////        [AIControllerTool chooseRootController];
//    }else{
//        AIOAuthViewController *oauthVC = [[AIOAuthViewController alloc]init];
//        self.window.rootViewController = oauthVC;
//    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
//        AILog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

@end

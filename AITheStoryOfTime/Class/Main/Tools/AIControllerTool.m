//
//  AIControllerTool.m
//  AISian
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 aizexin. All rights reserved.
// 控制器相关操作

#import "AIControllerTool.h"
//#import "AITabBarViewController.h"
#import "AINewFeatureViewController.h"
#import "DDMenuController.h"
#import "AppDelegate.h"
@interface AIControllerTool ()

@end
@implementation AIControllerTool
+(void)chooseRootController{
 
    //切换控制器(tabBar或者是新特性)
//    AITabBarViewController *tabBarVC = [[AITabBarViewController alloc]init];
    //判断版本号
    NSString *versionKey = (__bridge NSString*)kCFBundleVersionKey;
    NSUserDefaults *defalut = [NSUserDefaults standardUserDefaults];
    //取出上个版本号
    NSString *lastVersion = [defalut valueForKey:versionKey];
    //获得当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([lastVersion isEqualToString:currentVersion]) { //不是第一次进入

        AppDelegate *app = [UIApplication sharedApplication].delegate;
//        app.ddVC  = [[DDMenuController alloc]initWithRootViewController:tabBarVC];
        //添加左边birth页面
//        AIBirthViewController *birthVC = [[AIBirthViewController alloc]init];
//        app.ddVC.leftViewController = birthVC;
        
        window.rootViewController = app.ddVC;
        //监听通知改变到左视图
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change2LeftVC) name:AIChange2LeftVC object:nil];
        
    }else{ //第一次进入
        AINewFeatureViewController *newFeature = [[AINewFeatureViewController alloc]init];
        window.rootViewController = newFeature;
        [defalut setValue:currentVersion forKey:versionKey];
        [defalut synchronize];
    }
}


@end

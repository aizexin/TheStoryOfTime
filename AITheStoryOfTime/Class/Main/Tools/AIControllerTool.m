//
//  AIControllerTool.m
//  AISian
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 aizexin. All rights reserved.
// 控制器相关操作

#import "AIControllerTool.h"
#import "AITabBarViewController.h"
#import "AINewFeatureViewController.h"
#import "DDMenuController.h"
#import "AIBirthViewController.h"
@implementation AIControllerTool
+(void)chooseRootController{
 
    //切换控制器(tabBar或者是新特性)
    AITabBarViewController *tabBarVC = [[AITabBarViewController alloc]init];
    //判断版本号
    NSString *versionKey = (__bridge NSString*)kCFBundleVersionKey;
    NSUserDefaults *defalut = [NSUserDefaults standardUserDefaults];
    //取出上个版本号
    NSString *lastVersion = [defalut valueForKey:versionKey];
    //获得当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([lastVersion isEqualToString:currentVersion]) {
        
        
        DDMenuController *ddmVC = [[DDMenuController alloc]initWithRootViewController:tabBarVC];
        //添加左边birth页面
        AIBirthViewController *birthVC = [[AIBirthViewController alloc]init];
        ddmVC.leftViewController = birthVC;
        
        window.rootViewController = ddmVC;
        
    }else{
        
        AINewFeatureViewController *newFeature = [[AINewFeatureViewController alloc]init];
        window.rootViewController = newFeature;
        [defalut setValue:currentVersion forKey:versionKey];
        [defalut synchronize];
    }
}
@end

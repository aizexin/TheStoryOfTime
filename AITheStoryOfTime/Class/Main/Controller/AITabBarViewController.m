//
//  AITabBarViewController.m
//  AISian
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AITabBarViewController.h"
#import "AIJokeViewController.h"
#import "AIMapViewController.h"
#import "AIEverydayViewController.h"
#import "AiHomeViewController.h"
#import "AIDefine.h"
#import "AIBaseNavController.h"
#import "AITabBar.h"
#import "AIComposeViewController.h"
#import "AIAccountTool.h"
#import "AIAccountModel.h"
#import "AIOAuthViewController.h"
#import "AIHttpTool.h"
#import "SVProgressHUD.h"
@interface AITabBarViewController ()<AITabBarDelegate>

@end

@implementation AITabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //显示状态条
    if ([UIApplication sharedApplication].statusBarHidden == YES) {
        //iOS7，需要plist里设置 View controller-based status bar appearance 为NO
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }
    //添加子视图控制器
    [self addAllChildVcs];
    
    //调整tabBar
    AITabBar *customTabBar = [[AITabBar alloc]init];
    customTabBar.plusDelegate = self;
    [self setValue:customTabBar forKey:@"tabBar"];
}

- (void)addAllChildVcs{
    
    AIAccountModel *account = [AIAccountTool account];
    
    
    if (account.access_token) {
        AiHomeViewController *homeVC = [[AiHomeViewController alloc]init];
        [self addOneChildVC:homeVC title:@"首页" imageName:@"home_night" selImageName:@"home_press"];
    }else{
        AIOAuthViewController *oauthVC = [[AIOAuthViewController alloc]init];
        [self addOneChildVC:oauthVC title:@"首页" imageName:@"home_night" selImageName:@"home_press"];
    }
    
    
    
    AIJokeViewController *messageVC = [[AIJokeViewController alloc]init];
    [self addOneChildVC:messageVC title:@"笑话" imageName:@"funny_night" selImageName:@"funny_press"];
    
    AIMapViewController *discoverVC = [[AIMapViewController alloc]init];
    [self addOneChildVC:discoverVC title:@"地图" imageName:@"tabbar_discover" selImageName:@"tabbar_discover_selected"];
    AIEverydayViewController *profile = [[AIEverydayViewController alloc]init];
    [self addOneChildVC:profile title:@"Everyday" imageName:@"mine_night" selImageName:@"mine_press_night"];
}
/**
 *  添加自控制器
 *
 *  @param chilidVC     自控制器
 *  @param title        标题
 *  @param imageName    正常图片
 *  @param selImageName 被选中图片
 */
-(void)addOneChildVC:(UIViewController*)chilidVC title:(NSString*)title imageName:(NSString*)imageName selImageName:(NSString*)selImageName{
    //设置标题
    chilidVC.title = title;
    //设置正常文字颜色
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = AITabBarItemFont;
    dictM[NSForegroundColorAttributeName] = [UIColor blackColor];
    [chilidVC.tabBarItem setTitleTextAttributes:dictM forState:(UIControlStateNormal)];
    //设置被选中文字颜色
    NSMutableDictionary *seldictM = [NSMutableDictionary dictionary];
    seldictM[NSFontAttributeName] = AITabBarItemFont;
    seldictM[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [chilidVC.tabBarItem setTitleTextAttributes:seldictM forState:(UIControlStateSelected)];
    //设置正常图片
    chilidVC.tabBarItem.image = [[UIImage imageNamed:imageName]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    //被选中的图片
    UIImage *selImage = [[UIImage imageNamed:selImageName]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    chilidVC.tabBarItem.selectedImage = selImage;
    //添加导航控制器
    AIBaseNavController *navVC = [[AIBaseNavController alloc]initWithRootViewController:chilidVC];
    
    
    [self addChildViewController:navVC];
}
#pragma mark -AITabBarDelegate
-(void)tabBarDidClickedPlusButton:(AITabBar *)tabBar{
    if ([AIAccountTool account]) {
        AIComposeViewController *composeVC = [[AIComposeViewController alloc]init];
        composeVC.title = @"发微博";
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:composeVC];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        [SVProgressHUD showImage:[UIImage imageNamed:@"UMS_delete_image_button_normal"] status:@"还没登陆"];
    }
    
}


@end

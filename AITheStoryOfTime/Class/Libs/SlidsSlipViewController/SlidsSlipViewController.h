//
//  SlidsSlipViewController.h
//  5
//
//  Created by MS on 14-6-6.
//  Copyright (c) 2014年 xuli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlidsSlipViewController : UIViewController
{
    UIViewController * leftControl;
    UIViewController * mainControl;
    UIViewController * righControl;
    
    UIImageView * imgBackground;
    
    CGFloat scalef;
}


//滑动速度系数-建议在0.5-1之间。默认为0.5
@property (assign,nonatomic) CGFloat speedf;

//是否允许点击视图恢复视图位置。默认为yes
@property (nonatomic,retain) UITapGestureRecognizer *sideslipTapGes;

//初始化
-(id)initWithLeftView:(UIViewController *)LeftView
                    andMainView:(UIViewController *)MainView
                   andRightView:(UIViewController *)RighView
             andBackgroundImage:(UIImage *)image;


//恢复位置
-(void)showMainView;

//显示左视图
-(void)showLeftView;

//显示右视图
-(void)showRighView;


@end

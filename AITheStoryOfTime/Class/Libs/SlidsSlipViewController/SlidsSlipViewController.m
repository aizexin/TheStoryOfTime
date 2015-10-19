//
//  SlidsSlipViewController.m
//  5
//
//  Created by MS on 14-6-6.
//  Copyright (c) 2014年 xuli. All rights reserved.
//

#import "SlidsSlipViewController.h"

@interface SlidsSlipViewController ()

@end

@implementation SlidsSlipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(id)initWithLeftView:(UIViewController *)LeftView
                    andMainView:(UIViewController *)MainView
                   andRightView:(UIViewController *)RighView
             andBackgroundImage:(UIImage *)image;
{
    if(self){
        _speedf = 0.5;
        
        leftControl = LeftView;
        mainControl = MainView;
        righControl = RighView;
        
        UIImageView * imgview = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [imgview setImage:image];
        [self.view addSubview:imgview];
        
        //拖拽手势
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
        [mainControl.view addGestureRecognizer:pan];
        
        
        //单击手势
        _sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        _sideslipTapGes.numberOfTapsRequired = 1;
        
        [mainControl.view addGestureRecognizer:_sideslipTapGes];
        
        //在当前视图上添加左右主视图
        [self.view addSubview:leftControl.view];
        [self.view addSubview:righControl.view];
        [self.view addSubview:mainControl.view];
        
        //默认状态下左右视图是隐藏的
        leftControl.view.hidden = YES;
        righControl.view.hidden = YES;
        
    }
    return self;
}



#pragma mark - 滑动手势
//滑动手势
- (void)panAction:(UIPanGestureRecognizer *)pan
{
    
    CGPoint point = [pan translationInView:self.view];
    
    scalef = (point.x * _speedf + scalef);
    
    //根据视图位置判断是左滑还是右边滑动
    if (pan.view.frame.origin.x >= 0){
        pan.view.center = CGPointMake(pan.view.center.x + point.x * _speedf,pan.view.center.y);
        pan.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1 - scalef /1000,1 - scalef / 1000);
        [pan setTranslation:CGPointMake(0, 0) inView:self.view];
        
        righControl.view.hidden = YES;
        leftControl.view.hidden = NO;
        
    }
    else
    {
        pan.view.center = CGPointMake(pan.view.center.x + point.x * _speedf,pan.view.center.y);
        pan.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1 + scalef/1000,1 + scalef/1000);
        [pan setTranslation:CGPointMake(0, 0) inView:self.view];
        
        
        righControl.view.hidden = NO;
        leftControl.view.hidden = YES;
    }
    
    
    
    //手势结束后修正位置
    if (pan.state == UIGestureRecognizerStateEnded)
    {
        if (scalef > 140 * _speedf){
            [self showLeftView];
        }
        else if (scalef < -140 * _speedf) {
            [self showRighView];        }
        else
        {
            [self showMainView];
            scalef = 0;
        }
    }
    
}


#pragma mark - 单击手势
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    
    if (tap.state == UIGestureRecognizerStateEnded)
    {
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
        [UIView commitAnimations];
        scalef = 0;
        
    }
    
}

#pragma mark - 修改视图位置
//恢复位置
-(void)showMainView
{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    mainControl.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}

//显示左视图
-(void)showLeftView
{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
    mainControl.view.center = CGPointMake(340,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
    
}

//显示右视图
-(void)showRighView
{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
    mainControl.view.center = CGPointMake(-60,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}

//warning 为了界面美观，所以隐藏了状态栏。如果需要显示则去掉此代码
- (BOOL)prefersStatusBarHidden
{
    return YES; //返回NO表示要显示，返回YES将hiden
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

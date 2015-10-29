//
//  AINewFeatureViewController.m
//  AISian
//
//  Created by 艾泽鑫 on 15/10/3.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import "AINewFeatureViewController.h"
#import "AITabBarViewController.h"
#import "UIView+AIExtension.h"
#import "DDMenuController.h"
#import "AIBirthViewController.h"
#define ImageCount 4
@interface AINewFeatureViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIPageControl *pageControl;
@end

@implementation AINewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.添加UIScrollView
    [self setupScrollView];
    //2.添加pageControl
    [self setupPageControl];
}
#pragma mark -添加ScrollView
- (void)setupScrollView{
    UIScrollView *scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Mainsize.width, Mainsize.height)];
    [self.view addSubview:scrollV];
    scrollV.pagingEnabled = YES;
    
    for (int i = 0; i < ImageCount; i++) {
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i+1];
//        if (FourInch) { // 4inch  需要手动去加载4inch对应的-568h图片
//            imageName = [imageName stringByAppendingString:@"-568h"];
//        }
        UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        imageV.size = Mainsize;
        imageV.y = 0;
        imageV.x = Mainsize.width * i;
        [scrollV addSubview:imageV];
        if (i == ImageCount - 1) {
            [self setupLastImageView:imageV];
        }
    }
    scrollV.contentSize = CGSizeMake(ImageCount * Mainsize.width, Mainsize.height);
    scrollV.bounces = NO;
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.delegate = self;
}
#pragma mark -设置最后一个图片
-(void)setupLastImageView:(UIImageView*)imageView{
    imageView.userInteractionEnabled = YES;
    //1.设置开始按钮
    [self setupStartButton:imageView];
    //2.设置分享按钮
//    [self setupShareButton:imageView];
}
/**
 *  设置开始按钮
 */
-(void)setupStartButton:(UIImageView*)imageView{
    UIButton *starBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [imageView addSubview:starBtn];
    //设置背景图片
    [starBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:(UIControlStateNormal)];
    [starBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:(UIControlStateHighlighted)];
    starBtn.size = starBtn.currentBackgroundImage.size;
    CGPoint center= CGPointMake(self.view.frame.size.width *0.5, self.view.frame.size.height * 0.8);
    starBtn.center = center;
//    starBtn.centerX = self.view.width *0.5;
//    starBtn.centerY = self.view.height * 0.8;
    //设置文字
    [starBtn setTitle:@"开启光阴" forState:(UIControlStateNormal)];
    //添加点击事件
    [starBtn addTarget:self action:@selector(onClickStartBtn) forControlEvents:(UIControlEventTouchUpInside)];
}
/**
 *  设置分享按钮
 */
-(void)setupShareButton:(UIImageView*)imageView{
    UIButton *shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    shareBtn.size = CGSizeMake(150, 35);
    CGPoint center = CGPointMake(self.view.frame.size.width *0.5, self.view.frame.size.height * 0.7);
    shareBtn.center = center;
//    shareBtn.centerX = self.view.width *0.5;
//    shareBtn.centerY = self.view.height * 0.7;
    [imageView addSubview:shareBtn];
    //设置图片
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:(UIControlStateNormal)];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:(UIControlStateSelected)];
    //设置文字
    [shareBtn setTitle:@"分享给大家" forState:(UIControlStateNormal)];
    [shareBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [shareBtn setTitle:@"分享给大家" forState:(UIControlStateSelected)];
     [shareBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
    //设置间距
    [shareBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    //添加点击事件
    [shareBtn addTarget:self action:@selector(onClickShareBtn:) forControlEvents:(UIControlEventTouchUpInside)];
}

#pragma mark -按钮点击事件
-(void)onClickStartBtn{
    AITabBarViewController *tabBarVC = [[AITabBarViewController alloc]init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    DDMenuController *ddmVC = [[DDMenuController alloc]initWithRootViewController:tabBarVC];
    //添加左边birth页面
    AIBirthViewController *birthVC = [[AIBirthViewController alloc]init];
    ddmVC.leftViewController = birthVC;
    
    window.rootViewController = ddmVC;
    
//    window.rootViewController = [[AITabBarViewController alloc]init];
}
-(void)onClickShareBtn:(UIButton*)btn{
    btn.selected = !btn.isSelected;
}

#pragma mark -添加pageControl
-(void)setupPageControl{
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = ImageCount;
    pageControl.pageIndicatorTintColor = AIColor(189, 189, 189);
    pageControl.currentPageIndicatorTintColor = AIColor(253, 98, 42); // 当前页的小圆点颜色
    CGPoint centerPoint = CGPointMake(self.view.width * 0.5, self.view.height - 30);
    pageControl.center = centerPoint;

    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
}

#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float floatPageNum = scrollView.contentOffset.x / scrollView.width;
    int intPageNum = (int)(floatPageNum + 0.5);
    self.pageControl.currentPage = intPageNum;
}

@end

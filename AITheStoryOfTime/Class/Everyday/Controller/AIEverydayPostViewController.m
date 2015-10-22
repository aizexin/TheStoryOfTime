//
//  AIEverydayPostViewController.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//  拍照完成页面

#import "AIEverydayPostViewController.h"
#import "AIEverydayToolbar.h"
#import "AIFixScreen.h"
#import "SCCommon.h"
#define SC_APP_SIZE         [[UIScreen mainScreen] applicationFrame].size
#define SC_APP_SIZE         [[UIScreen mainScreen] applicationFrame].size
#define CAMERA_TOPVIEW_HEIGHT   44  //title
#define AIEverydayPhotoRect CGRectMake(0, 0, SC_APP_SIZE.width, SC_APP_SIZE.width + CAMERA_TOPVIEW_HEIGHT)
@interface AIEverydayPostViewController ()
/**
 *  拍照得到的image
 */
@property(nonatomic,weak)UIImageView *imageV;
/**
 *  工具栏
 */
@property(nonatomic,weak)AIEverydayToolbar *toolbarView;
/**
 *  眼睛位线
 */
@property(nonatomic,strong)UIView *eyesLineView;
/**
 *  嘴位线
 */
@property(nonatomic,strong)UIView *mouthLineView;
/**
 *  鼻子线
 */
@property(nonatomic,strong)UIView *noseLineView;
@end

@implementation AIEverydayPostViewController

#pragma mark ----------------懒加载----------------------
-(UIView *)eyesLineView{
    if (!_eyesLineView) {
        _eyesLineView = [[UIView alloc]init];
        _eyesLineView.backgroundColor = [UIColor redColor];
        _eyesLineView.frame = CGRectMake(0, 0, AIViewSize.width, AIEverydayBaseLineWith);
    }
    return _eyesLineView;
}
-(UIView *)mouthLineView{
    if (!_mouthLineView) {
        _mouthLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AIViewSize.width, AIEverydayBaseLineWith)];
        _mouthLineView.backgroundColor = [UIColor redColor];
    }
    return _mouthLineView;
}
-(UIView *)noseLineView{
    if (!_noseLineView) {
        _noseLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,  AIEverydayBaseLineWith,AIViewSize.height)];
        _noseLineView.backgroundColor = [UIColor redColor];
    }
    return _noseLineView;
}

#pragma mark ----------------初始化----------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    [self setupData];
}
#pragma mark ----------------UI----------------------
-(void)setupUI{
    //获得的相片
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.backgroundColor = [UIColor redColor];
    self.imageV = imageV;
    [self.view addSubview:imageV];
    //工具栏
    AIEverydayToolbar *toolbar = [[AIEverydayToolbar alloc]init];
    self.toolbarView = toolbar;
    toolbar.backgroundColor = AIRandomColor;
    [self.view addSubview:toolbar];
    //屏幕适配
    [self fitScreen];
    AILog(@"%@",NSStringFromCGRect(toolbar.frame));
}
-(void)fitScreen{
    //工具栏
    [self.toolbarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.height.mas_equalTo(@(AIEverydayToolBarHeight));
    }];
    //相片
    self.imageV.frame = AIEverydayPhotoRect;
    
}
#pragma mark --------------数据 ---------------------
-(void)setupData{
    self.imageV.image = self.image;
    //点击事件
    [self.toolbarView setCancelImage:^{//取消按钮
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [self.toolbarView setResetImage:^{//重拍按钮
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.toolbarView setSaveImage:^{//保存按钮
       [SCCommon saveImageToPhotoAlbum:self.image];//存至本机
       [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark --------------确定基准线的位置----------------------
#warning 回去再做

@end

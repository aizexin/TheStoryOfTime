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
#import "AIEverydayLineView.h"
#import "AIEverydayLineFrameModel.h"
#import "AIEverydayTool.h"

#define SC_APP_SIZE         [[UIScreen mainScreen] applicationFrame].size
#define CAMERA_TOPVIEW_HEIGHT   44  //title
#define AIEverydayPhotoRect CGRectMake(0, 0, SC_APP_SIZE.width, SC_APP_SIZE.width + CAMERA_TOPVIEW_HEIGHT)
//基准线最小x值
#define AILineMinX 50

#define AILineMinY 50
//基准线活动范围
#define AILineMAXContentRect CGRectMake(AILineMinX, AILineMinY, Mainsize.width - 2*AILineMinX, Mainsize.height - 2 *AILineMinY)


@interface AIEverydayPostViewController ()
/**拍照得到的image*/
@property(nonatomic,weak)UIImageView *imageV;
/**工具栏*/
@property(nonatomic,weak)AIEverydayToolbar *toolbarView;
/**眼睛位线*/
@property(nonatomic,strong)AIEverydayLineView *eyesLineView;
/**嘴位线*/
@property(nonatomic,strong)AIEverydayLineView *mouthLineView;
/**鼻子线*/
@property(nonatomic,strong)AIEverydayLineView *noseLineView;
/**是否在设置基准线*/
@property(nonatomic,assign,getter=isSettingLine)BOOL settingLine;
/**是否已经设置了基准线*/
@property(nonatomic,assign,getter=isSetedLine)BOOL setedLine;



@end

@implementation AIEverydayPostViewController

#pragma mark ----------------懒加载----------------------
-(UIView *)eyesLineView{
    if (!_eyesLineView) {
        _eyesLineView = [[AIEverydayLineView alloc]init];
        _eyesLineView.type = AILineTypeEyes;
    }
    return _eyesLineView;
}
-(UIView *)mouthLineView{
    if (!_mouthLineView) {
        _mouthLineView = [[AIEverydayLineView alloc]init];
        _mouthLineView.type = AILineTypeMouth;
    }
    return _mouthLineView;
}
-(UIView *)noseLineView{
    if (!_noseLineView) {
        _noseLineView = [[AIEverydayLineView alloc]init];
        _noseLineView.type = AILineTypeNose;
    }
    return _noseLineView;
}

#pragma mark ----------------初始化----------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AILog(@"isSetedLine%d",self.isSetedLine);
    
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
#pragma mark --------------数据 toolbar响应事件---------------------
-(void)setupData{
    __weak typeof (self) weakSelf = self;
    self.imageV.image = self.image;
    //点击事件
    [self.toolbarView setCancelImage:^{//取消按钮
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [self.toolbarView setResetImage:^{//重拍按钮
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.toolbarView setSaveImage:^{//保存按钮
       [SCCommon saveImageToPhotoAlbum:weakSelf.image];//存至本机
        if (!self.isSetedLine) {//如果是在设置基准线
            [self saveLineFrame];
        }
        //存储到数据库
        [AIEverydayTool saveImage:weakSelf.image];
    [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark --------------确定基准线的位置----------------------
-(void)setupBaseLine{
    self.imageV.userInteractionEnabled = YES;
    //眼睛
    [self.imageV addSubview:self.eyesLineView];
    UIPanGestureRecognizer *panEyes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHorizontalLine:)];
    [self.eyesLineView addGestureRecognizer:panEyes];
    //嘴巴
    [self.imageV addSubview:self.mouthLineView];
    UIPanGestureRecognizer *panMouth = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHorizontalLine:)];
    [self.mouthLineView addGestureRecognizer:panMouth];
    
    //鼻子
    [self.imageV addSubview:self.noseLineView];
    UIPanGestureRecognizer *panNose = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHorizontalLine:)];
    [self.noseLineView addGestureRecognizer:panNose];
    //手势冲突顺序
    //当tap2 和 tap3同时出现在视图上，取消tap2
//    [panEyes requireGestureRecognizerToFail:panMouth];
//    [panMouth requireGestureRecognizerToFail:panMouth];
}
-(void)panHorizontalLine:(UIPanGestureRecognizer*)pan{
//    AIEverydayLineView * line = (AIEverydayLineView*)pan.view;
//    AILog(@"---------%d,%@",line.type,NSStringFromCGRect([line showLineRectInImageView]));
    if (pan.view.frame.size.height == (SC_APP_SIZE.width + CAMERA_TOPVIEW_HEIGHT)) {
        //移动的坐标值
        CGPoint translation = [pan translationInView:self.view];
        //移动后的坐标  只能左右移动
        //手移到的地方
        CGPoint movePoint = CGPointMake(pan.view.center.x + translation.x, pan.view.center.y + translation.y);
        if (CGRectContainsPoint(AILineMAXContentRect, movePoint)) {
            
            pan.view.center = CGPointMake(pan.view.center.x + translation.x, pan.view.center.y);
            //设置坐标和速度
            [pan setTranslation:CGPointZero inView:self.imageV];
        }

    }else{
        //移动的坐标值
        CGPoint translation = [pan translationInView:self.view];
        //移动后的坐标  只能上下移动
        //手移到的地方
        CGPoint movePoint = CGPointMake(pan.view.center.x + translation.x, pan.view.center.y + translation.y);
        if (CGRectContainsPoint(AILineMAXContentRect, movePoint)) {
            
            pan.view.center = CGPointMake(pan.view.center.x, pan.view.center.y + translation.y);
            //设置坐标和速度
            [pan setTranslation:CGPointZero inView:self.imageV];
        }
    }
}

#pragma mark--------------数据存储------------------
-(void)saveLineFrame{
    AIEverydayLineFrameModel *lineModel = [[AIEverydayLineFrameModel alloc]init];
    lineModel.eyesFrameStr = [self.eyesLineView showLineRectInImageView];
    lineModel.mouthFrameStr = [self.mouthLineView showLineRectInImageView];
    lineModel.noseFrameStr = [self.noseLineView showLineRectInImageView];
    //保存到本地
    [AIEverydayTool saveLineFrameModel:lineModel];
    //保存是否已经设置
//    self.setedLine = ;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"setedLine"];
    [defaults synchronize];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   self.setedLine = [[NSUserDefaults standardUserDefaults]boolForKey:@"setedLine"];
//    AILog(@"viewWillAppear----------isSetedLine%d",self.isSetedLine);
    if (!self.isSetedLine) {//如果没有设置基准线
        //设置基准线
        [self setupBaseLine];
    }
}
@end












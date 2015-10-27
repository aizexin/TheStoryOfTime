//
//  AIEverydayViewController.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//
#import "AIEverydayViewController.h"
#import "AIEverydayCell.h"
#import "PostViewController.h"
#import "SCCaptureCameraController.h"
#import "AIEverydayPostViewController.h"
#import "AIEverydayTool.h"
#import "AIEverydayCellModel.h"
#import "UIBarButtonItem+AIExtension.h"
#import "AIEverydayDefine.h"
#import "AIEverydayVideoImageView.h"
#import "SVProgressHUD.h"
@interface AIEverydayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionV;
/**
 *  资源
 */
@property(nonatomic,strong)NSMutableArray *dataSource;
/**蒙版 */
@property(nonatomic,strong)UIButton *core;
/**用来播放图片的imageview*/
@property(nonatomic,strong)AIEverydayVideoImageView *videoImage;


@end

@implementation AIEverydayViewController
static NSString *identifier = @"AIEverydayCell";



#pragma mark -懒加载
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(UICollectionView *)collectionV{
    if (!_collectionV) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat cellW =self.view.frame.size.width/3-10;
        CGFloat cellH = cellW;
        
        CGRect rect = self.view.bounds;
        rect.origin.y = AINavgationBarH;
        rect.size.height -= AINavgationBarH;
        flowLayout.itemSize = CGSizeMake(cellW, cellH);
        _collectionV = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:flowLayout];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        
        
        UINib *nib = [UINib nibWithNibName:@"AIEverydayCell" bundle:nil];
        [_collectionV registerNib:nib forCellWithReuseIdentifier:identifier];
//        [_collectionV setBackgroundColor:[UIColor redColor]];
    }
    return _collectionV;
}

-(UIButton *)core{
    if (!_core) {
        _core = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _core.frame = [UIScreen mainScreen].bounds;
        _core.alpha = 0.7;
        _core.backgroundColor = [UIColor blackColor];
        [_core addTarget:self action:@selector(onClickCoreBtn:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _core;
}

//-(UIImageView *)videoImage{
//    if (!_videoImage) {
//        _videoImage = [[AIEverydayVideoImageView alloc]init];
//    }
//    return _videoImage;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Everyday";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTagert:self action:@selector(onClickRightItem:) NorImageName:@"video" andHeiImageName:@"video"];
    [self.view addSubview:self.collectionV];
}
#pragma mark------------点击事件------------------
-(void)onClickRightItem:(UIBarButtonItem*)item{
    if (self.dataSource.count <=0 ) {
        [SVProgressHUD showErrorWithStatus:@"还没有照片哦~"];
        return;
    }
    //弹出视图框可以播放，
    
    //添加videoImage
    CGRect rect =AIEverydayPhotoRect;
    rect.origin.y = (Mainsize.height - rect.size.height) *0.5;
#warning 这里不能用懒加载 ，每次数据不一样
    self.videoImage =  [[AIEverydayVideoImageView alloc]initWithFrame:rect];
    
    UIWindow *lastWindow = [[UIApplication sharedApplication].windows lastObject];
    //添加蒙版
    [lastWindow addSubview:self.core];
    [lastWindow addSubview:self.videoImage];
}
/**
 *  点击蒙版
 */
-(void)onClickCoreBtn:(UIButton*)core{
    [UIView animateWithDuration:0.5 animations:^{
        [self.videoImage removeFromSuperview];
        [self.core removeFromSuperview];
    } completion:^(BOOL finished) {
     
    }];
    
    
}

#pragma mark -----------代理方法--
#pragma mark --------数据源
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count+1;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AIEverydayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.cellImage.image = nil;
    if (indexPath.item == 0) {
        //测试图片
        cell.cellImage.image = [UIImage imageNamed:@"game_center"];
        [cell.deleteBtn setHidden:YES];
        cell.timeLabel.hidden = YES;
    }else{
       [cell.deleteBtn setHidden:NO];
        cell.timeLabel.hidden = NO;
        cell.cellImage.userInteractionEnabled = YES;
//        AILog(@"count ------ %d", self.dataSource.count);
        AIEverydayCellModel *model = self.dataSource[indexPath.item-1];
        cell.model = model;
        
        __weak typeof (self) weakSelf = self;
        [cell setDeleteBlock:^() {
//             AILog(@"indexPath-----%@",model.cellId);
            [AIEverydayTool deleteEverdayCellModelWithIndex:[model.cellId integerValue] ];
            [weakSelf.dataSource removeObject:model];
            [weakSelf.collectionV reloadData];
        }];
    }
    
    return cell;
}





#pragma mark --------collection代理------
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) {//开始照相等功能
        SCCaptureCameraController *cameraVC = [[SCCaptureCameraController alloc]init];
        [self.navigationController pushViewController:cameraVC animated:YES];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    if (self.navigationController && self.navigationController.navigationBarHidden) {
        self.navigationController.navigationBarHidden = NO;
    }
    self.dataSource = [AIEverydayTool allEverydayCellModel];
    [self.collectionV reloadData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

@end

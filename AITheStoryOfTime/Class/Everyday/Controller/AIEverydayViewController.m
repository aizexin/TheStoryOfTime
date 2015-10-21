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
@interface AIEverydayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionV;
/**
 *  资源
 */
@property(nonatomic,strong)NSMutableArray *dataSource;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    for (int i = 0; i < 20; i++) {
        [self.dataSource addObject:[NSString stringWithFormat:@"测试数据%d",i]];
    }
    [self.view addSubview:self.collectionV];
    
}
#pragma mark -----------代理方法--
#pragma mark --------数据源
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AIEverydayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.cellImage.image = nil;
    
    if (indexPath.item == 0) {
        //测试颜色
        cell.cellImage.image = [UIImage imageNamed:@"game_center"];
//        cell.cellImage.backgroundColor = [UIColor redColor];
    }
    
    return cell;
}

#pragma mark --------collection代理
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) {//开始照相等功能
        AIEverydaySCNavigationController *nav = [[AIEverydaySCNavigationController alloc] init];
        nav.scNaigationDelegate = self;
        [nav showCameraWithParentController:self];
    }
}

#pragma mark - AIEverydaySCNavigationController delegate
- (void)didTakePicture:(AIEverydaySCNavigationController *)navigationController image:(UIImage *)image {
    PostViewController *con = [[PostViewController alloc] init];
    con.postImage = image;
    [navigationController pushViewController:con animated:YES];
}



@end

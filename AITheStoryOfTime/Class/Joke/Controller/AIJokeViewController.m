//
//  AIJokeViewController.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIJokeViewController.h"
#import "AIJokeTableViewCell.h"
#import "AIJokeTool.h"
#import "AIJokeParamModel.h"
#import "AIJokeCellModel.h"
#import "AIJokeDataModel.h"
#import "AIJokeContentDataModel.h"
#import "AIJokeGroupModel.h"
#import "AIJokeCellFrameModel.h"
#import "AIJokeDefine.h"
#import "NSDate+DateTools.h"
#import "MJRefresh.h"
@interface AIJokeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *tableView;
/**
 *  笑话数据里面装的是frameJoke模型
 */
@property(nonatomic,strong)NSMutableArray *dataSourceM;
@property(nonatomic,weak)UIRefreshControl *refresh;
@property(nonatomic,assign,getter=isLoading)BOOL loading;

/**
 *  上次请求数据得到的最小时间
 */
@property(nonatomic,strong)NSNumber *minTime;
/**
 *  上次请求数据得到的最大时间
 */
@property(nonatomic,strong)NSNumber *maxTime;


@end

@implementation AIJokeViewController

#pragma mark -------懒加载-------------
-(NSMutableArray *)dataSourceM{
    if (!_dataSourceM) {
        _dataSourceM = [NSMutableArray array];
    }
    return _dataSourceM;
}

#pragma mark --------------生命周期--------------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"笑话";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initTableView];

    //加载刷新控件
    [self setupRefresh];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shareBtnDidSelected:) name:AIJokeShareEventNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //先清空数据库
    [AIJokeTool cleanJoke];
    //存储前20条数据
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:20];
    if (self.dataSourceM.count >= 20) {
        for (int i = 0; i < 20; i++) {
            AIJokeCellFrameModel *cellFrameModel = _dataSourceM[i];
            [arrayM addObject:cellFrameModel.groupModel];
        }
    }
    [AIJokeTool save20Joke:arrayM];
}
-(void)viewWillAppear:(BOOL)animated{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *array =[AIJokeTool readJokeTable];
        for (AIJokeGroupModel *groupModel in array) {
            
            AIJokeCellFrameModel *cellFrameModel = [[AIJokeCellFrameModel alloc]init];
            cellFrameModel.groupModel = groupModel;
            [self.dataSourceM addObject:cellFrameModel];
        }
    });
    
    [super viewWillAppear:animated];
}


#pragma mark -----------通知----------------
-(void)shareBtnDidSelected:(NSNotification*)notifi{
    NSString *joke = notifi.userInfo[@"jokeContent"];
    [UMSocialSnsService presentSnsIconSheetView:self appKey:AIUMAPPKEY shareText:joke shareImage:[UIImage imageNamed:@"AppIcon"] shareToSnsNames:[NSArray arrayWithObjects:
                                                                                                                                                     UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToQQ,
                                                                                                                                                     UMShareToQzone,
                                                                                                                                                     nil] delegate:self];
    //2.纯文字，点击不会跳转
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeText;
  
}

#pragma mark ---------------------初始化方法-----------------
-(void)initTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, AINavgationBarH, Mainsize.width, Mainsize.height - AINavgationBarH -44) style:(UITableViewStylePlain)];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //去掉分割线
    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    self.tableView.backgroundColor = AITabelViewBgColor;
    [self.view addSubview:tableView];
    //
    
}
#pragma mark ----------------数据源---------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceM.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AIJokeTableViewCell *cell = [AIJokeTableViewCell createJokeCell:tableView];
    cell.frameData =self.dataSourceM[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 立即取消选中
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AIJokeCellFrameModel *frameModel = self.dataSourceM[indexPath.row];
    return frameModel.jokeCellHeight;
}

#pragma mark ----------------请求数据----------

/**
 *  集成刷新控件
 */
- (void)setupRefresh{
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    self.refresh = refresh;
    [self.tableView addSubview:refresh];
    //2.监听refresh
    [refresh addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:(UIControlEventValueChanged)];
    //3.让刷新空间自动进入刷新状态
    [refresh beginRefreshing];
    //4.加载数据
    if (self.dataSourceM.count==0) {
        [self refreshControlStateChange:self.refresh];
    }
    //5.添加上拉加载更多控件
    //上啦加载
    [self refreshAndLoad];
}
/**
 *  下拉刷新方法
 */
-(void)refreshControlStateChange:(UIRefreshControl*)refreshControl{
    
    if (!self.minTime) {
        NSTimeInterval time=[[NSDate date] timeIntervalSince1970];
        NSInteger second=time;      //NSTimeInterval返回的是double类型
        self.minTime = @(second);
    }
    AIJokeParamModel *params = [[AIJokeParamModel alloc]init];
    params.min_time = [self.minTime stringValue];
    AILog(@" 下拉刷新方法params.min_time --------%@",params.min_time );
   
    [AIJokeTool JokeWithParams:params success:^(AIJokeCellModel *resultModel) {

        self.minTime = @([resultModel.data.min_time integerValue]);
        NSMutableArray *arrayM = [NSMutableArray arrayWithArray:resultModel.data.data];
        for (AIJokeContentDataModel *contentData in arrayM) {
            AIJokeCellFrameModel *frameModel = [[AIJokeCellFrameModel alloc]init];
            frameModel.groupModel = contentData.group;
            [self.dataSourceM insertObject:frameModel atIndex:0];
            // 让刷新控件停止刷新（恢复默认的状态）
            [refreshControl endRefreshing];
        }
        //刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        AILog(@"请求笑话数据失败%@",error.description);
        // 让刷新控件停止刷新（恢复默认的状态）
        [refreshControl endRefreshing];
    }];
    
}

-(void)refreshAndLoad{
 
    //2.加载
    [self.tableView addFooterWithCallback:^{
        if (self.isLoading) {
            return ;
        }
        self.loading = YES;
        //重新加载数据
        _loading = NO;
        [self loadMoreData];
        [self.tableView footerEndRefreshing];
    }];
    
}
/**
 *  加载更多数据
 */
-(void)loadMoreData{
    AIJokeParamModel *params = [[AIJokeParamModel alloc]init];
    if (!self.maxTime) {
        NSTimeInterval time=[[NSDate date] timeIntervalSince1970];
        NSInteger second=time;      //NSTimeInterval返回的是double类型
        self.maxTime = @(second);
    }
    params.min_time = [self.maxTime stringValue];
//    AILog(@"加载更多数据params.min_time --------%@",params.min_time );
    [AIJokeTool JokeWithParams:params success:^(AIJokeCellModel *resultModel) {

        self.maxTime = @([resultModel.data.max_time integerValue]);
        NSMutableArray *arrayM = [NSMutableArray arrayWithArray:resultModel.data.data];
        for (AIJokeContentDataModel *contentData in arrayM) {
            AIJokeCellFrameModel *frameModel = [[AIJokeCellFrameModel alloc]init];
            frameModel.groupModel = contentData.group;
            [self.dataSourceM addObject:frameModel];
//            [self.dataSourceM insertObject:frameModel atIndex:0];
        }
        //刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        AILog(@"请求笑话数据失败%@",error.description);
    }];
    
    [self.tableView reloadData];
}

#pragma mark --------------------数据库操作---------------



@end

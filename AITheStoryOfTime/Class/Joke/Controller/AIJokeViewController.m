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
@interface AIJokeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSourceM;
@end

@implementation AIJokeViewController

#pragma mark --------------生命周期--------------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"笑话";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initTableView];
    [self loadData];
//    [self.view setBackgroundColor:[UIColor blueColor]];
}

#pragma mark ---------------------初始化方法-----------------
-(void)initTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, AINavgationBarH, Mainsize.width, Mainsize.height - AINavgationBarH -44) style:(UITableViewStylePlain)];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:tableView];
    
}
#pragma mark ----------------数据源---------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceM.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AIJokeTableViewCell *cell = [AIJokeTableViewCell createJokeCell:tableView];
    AIJokeCellModel *model = self.dataSourceM[indexPath.row];
    cell.data = model;
    return cell;
}

#pragma mark ----------------请求数据----------
-(void)loadData{
    AIJokeParamModel *params = [[AIJokeParamModel alloc]init];
    [AIJokeTool JokeWithParams:params success:^(AIJokeCellModel *resultModel) {
        AILog(@"%@",resultModel.data.data);
        self.dataSourceM = resultModel.data.data;
    } failure:^(NSError *error) {
        AILog(@"请求笑话数据失败%@",error.description);
    }];
}




@end

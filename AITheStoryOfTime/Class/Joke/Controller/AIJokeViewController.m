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
@interface AIJokeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSourceM;
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
    [self loadData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shareBtnDidSelected:) name:AIJokeShareEventNotification object:nil];
}

#pragma mark -----------通知----------------
-(void)shareBtnDidSelected:(NSNotification*)notifi{
    NSString *joke = notifi.userInfo[@"jokeContent"];
    [UMSocialSnsService presentSnsIconSheetView:self appKey:AIUMAPPKEY shareText:joke shareImage:[UIImage imageNamed:@"AppIcon"] shareToSnsNames:[NSArray arrayWithObjects:
                                                                                                                                                     UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToQQ,
                                                                                                                                                     UMShareToQzone,
                                                                                                                                                     nil] delegate:self];
    //    //分享微信的时候选择消息类型
    //    //1.纯图片
    //    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    //    //2.纯文字，点击不会跳转
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeText;
    //    //3.分享本应用，应用地址是微信开放平台填写的地址
    //    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
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
    cell.backgroundColor = [UIColor clearColor];
    AIJokeCellFrameModel *frameModel = self.dataSourceM[indexPath.row];
    cell.frameData = frameModel;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 立即取消选中
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AIJokeCellFrameModel *frameModel = self.dataSourceM[indexPath.row];
    return frameModel.jokeCellHeight ;
}

#pragma mark ----------------请求数据----------
-(void)loadData{
    AIJokeParamModel *params = [[AIJokeParamModel alloc]init];
    [AIJokeTool JokeWithParams:params success:^(AIJokeCellModel *resultModel) {
        AILog(@"%@",resultModel.data.data);
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithArray:resultModel.data.data];
        for (AIJokeContentDataModel *contentData in arrayM) {
            AIJokeCellFrameModel *frameModel = [[AIJokeCellFrameModel alloc]init];
            frameModel.groupModel = contentData.group;
            [self.dataSourceM addObject:frameModel];
        }
        //刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        AILog(@"请求笑话数据失败%@",error.description);
    }];
}




@end

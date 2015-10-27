//
//  AiHomeViewController.m
//  AISian
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//
#warning 还没判断网络状态

#import "AiHomeViewController.h"
#import "AITemp1ViewController.h"
//#import "UIBarButtonItem+AIExtension.h"
#import "AITemp1ViewController.h"
#import "AIHomeTitleButton.h"
#import "AIDefine.h"
#import "AIPopMenu.h"
#import "AIAccountTool.h"
#import "AIAccountModel.h"
#import "MJExtension.h"
#import "AIStatusesModel.h"
#import "UIImageView+AFNetworking.h"
#import "AIUserModel.h"
#import "AILoadMoreFooter.h"
#import "MJRefresh.h"
#import "AIStatusesTool.h"
#import "AIStatusCell.h"
#import "AIStatusFrame.h"
#import "AIHomeHttpLinkViewController.h"
#define TipsLabelH 35
#define TipsLabelW Mainsize.width

#define HomeTitleH 35

@interface AiHomeViewController ()<AIPopMenuDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)AIHomeTitleButton *titleBtn;
@property(nonatomic,strong)AIPopMenu *popMenu;
@property(nonatomic,strong)NSMutableArray *statusesFrames;
@property(nonatomic,strong)AILoadMoreFooter *footer;

/**
 *  是否在刷新
 */
@property(nonatomic,assign,getter=isRefeshing)BOOL refeshing;
/**
 *  判断是否在加载
 */
@property(nonatomic,assign,getter=isLoading)BOOL loading;
@end

@implementation AiHomeViewController

#pragma mark -懒加载

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, AINavgationBarH, Mainsize.width, Mainsize.height-AINavgationBarH-44);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(AILoadMoreFooter *)footer{
    if (!_footer) {
        _footer = [AILoadMoreFooter footer];
    }
    return _footer;
}

-(NSMutableArray *)statusesFrames{
    if (!_statusesFrames) {
        _statusesFrames = [NSMutableArray array];
    }
    return _statusesFrames;
}

#pragma mark -初始化方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"首页";
    self.tableView.backgroundColor = AITabelViewBgColor;
    //去掉分割线
    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    AILog(@"%@",NSHomeDirectory());
    //设置导航栏内容
    [self setupNavBar];

    //集成刷新控件
    [self setupRefresh];
    //上啦加载
    [self refreshAndLoad];
    //请求用户信息
    [self setupUserInfo];
    
    //监听链接通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(linkDidSelected:) name:AILinkDidSelectedNotification object:nil];
}
/**
 *  链接被点击事件
 */
-(void)linkDidSelected:(NSNotification*)note{
    NSString *linkText = note.userInfo[AILinkText];
    if ([linkText hasPrefix:@"http"]) {//如果是http链接
        AIHomeHttpLinkViewController *httpLinkVC = [[AIHomeHttpLinkViewController alloc]initWithNibName:@"AIHomeHttpLinkViewController" bundle:nil];
        httpLinkVC.httpLink = linkText;
        [self.navigationController pushViewController:httpLinkVC animated:YES];
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self ];
}

/**
 *  加载用户信息
 */
-(void)setupUserInfo{
    AIUserInfoParamModel *param = [[AIUserInfoParamModel alloc]init];
    param.access_token = [AIAccountTool account].access_token;
    param.uid = [AIAccountTool account].uid;
    [AIStatusesTool userInfoStatusesWithParams:param success:^(AIUserInfoResultModel *resultModel) {
        
        [self.titleBtn setTitle:resultModel.name forState:(UIControlStateNormal)];
//        self.sc_navigationItem.title = resultModel.name;
        //存储账号信息
        
        AIAccountModel *account = [AIAccountTool account];
        account.screen_name = resultModel.name;
        [AIAccountTool save:account];
        
    } failure:^(NSError *error) {
        AILog(@"请求失败%@",error.description);
    }];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh{
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:refresh];
    //2.监听refresh
    [refresh addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:(UIControlEventValueChanged)];
    //3.让刷新空间自动进入刷新状态
    [refresh beginRefreshing];
    //4.加载数据
    [self refreshControlStateChange:refresh];
    //5.添加上拉加载更多控件

}
/**
 *  刷新方法
 */
-(void)refreshControlStateChange:(UIRefreshControl*)refresh{
   
    AIHomeStatusesParamModel *paramModel = [[AIHomeStatusesParamModel alloc]init];
    paramModel.access_token = [AIAccountTool account].access_token;
    AIStatusesModel *statuse = [[self.statusesFrames firstObject] statusesModel];
    if (statuse) {
        paramModel.since_id = @([statuse.idstr longLongValue]);
    }
    [AIStatusesTool homeStatusesWithParams:paramModel success:^(AIHomeStatusesResultModel *resultModel) {

        AILog(@"请求成功");
        NSArray *statuses = [self statusesFramesWithStatuses:resultModel.statuses];
        //讲数据查到最前面
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        [self.statusesFrames insertObjects:statuses atIndexes:indexSet];
        [self.tableView reloadData];
        //提示用户刷新数量
        [self showNewStatuesCount:statuses.count];
        //停止刷新
        [refresh endRefreshing];
    } failure:^(NSError *error) {
        AILog(@"请求失败%@",error.description);
        //停止刷新
        [refresh endRefreshing];
    }];


}

#pragma mark -刷新加载
-(void)refreshAndLoad{
    /*//1.刷新
    [self.tableView addHeaderWithCallback:^{
        if (self.refeshing) {
            return ;
        }
        self.refeshing = YES;
        //加载数据
        
        _refeshing = NO;
        //隐藏刷新驶入
        [self.tableView headerEndRefreshing];
    }];*/
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
  
    // max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
    AIStatusesModel *lastStatuse = [[self.statusesFrames lastObject]statusesModel];
    
    AIHomeStatusesParamModel *paramModel = [[AIHomeStatusesParamModel alloc]init];
    paramModel.access_token = [AIAccountTool account].access_token;
    if (lastStatuse) {
        paramModel.max_id = @([lastStatuse.idstr longLongValue] - 1);
    }
    [AIStatusesTool homeStatusesWithParams:paramModel success:^(AIHomeStatusesResultModel *resultModel) {
        //数据模型转化为Frame模型
        NSArray *statuses = [self statusesFramesWithStatuses:resultModel.statuses];

        [self.statusesFrames addObjectsFromArray:statuses];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        AILog(@"加载失败%@",error.description);
    }];
    [self.tableView reloadData];
}

-(NSArray*)statusesFramesWithStatuses:(NSArray*)statuses{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (AIStatusesModel *statusesModel in statuses) {
        AIStatusFrame *statusFrame = [[AIStatusFrame alloc]init];
        statusFrame.statusesModel = statusesModel;
        [arrayM addObject:statusFrame];
    }
    return arrayM;
}

/**
 *  提示用户刷新数量
 *
 *  @param count 最新微博的数量
 */
-(void)showNewStatuesCount:(NSInteger)count{
    UILabel *label = [[UILabel alloc]init];
    
    if (count) {
        label.text = [NSString stringWithFormat:@"共有%ld条新数据",count];
    }else{
        label.text = @"没有新数据";
    }
    //3.设置背景
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    [label setTextAlignment:(NSTextAlignmentCenter)];
    label.textColor = [UIColor whiteColor];
    //设置frame
//    label.width = self.view.width;
//    label.height = 35;
//    label.x = 0;
//    label.y = 64 - label.height;
    label.frame = CGRectMake(0, AINavgationBarH - TipsLabelH,Mainsize.width, TipsLabelH );
    //添加到当行控制器的view中
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
//    [self.view insertSubview:label belowSubview:self.sc_navigationBar];
    
    //动画
    CGFloat duration = 0.75;
    label.alpha = 0.;
    //往下移动
    [UIView animateWithDuration:duration animations:^{
        [label setTransform:(CGAffineTransformMakeTranslation(0, TipsLabelH))];
        label.alpha = 1.;
    }];
    //往上移动
    [UIView animateWithDuration:duration delay:1. options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        label.transform = CGAffineTransformIdentity;
        label.alpha = 0.;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
    
}

/**
 *  设置navBar
 */
-(void)setupNavBar{
    //设置导航栏左右按钮
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTagert:self action:@selector(onClickLeftItem:) NorImageName:@"navigationbar_friendsearch" andHeiImageName:@"navigationbar_friendsearch_highlighted"];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTagert:self action:nil NorImageName:@"navigationbar_pop" andHeiImageName:@"navigationbar_pop_highlighted"];
 
    //
    
    AIHomeTitleButton *titleBtn = [[AIHomeTitleButton alloc]init];
    _titleBtn = titleBtn;
//    titleBtn.height = HomeTitleH;
    titleBtn.frame = CGRectMake(0, 0, 30, HomeTitleH);
    //设置标题昵称
    //1获得用户信息
    AIAccountModel *account = [AIAccountTool account];
    if (account.screen_name) {//看沙盒中有没有上次数据
        [titleBtn setTitle:account.screen_name forState:(UIControlStateNormal)];
    }else{
        [titleBtn setTitle:@"首页" forState:(UIControlStateNormal)];
    }
    
    UIImage *higImage = [UIImage resizedImage:@"navigationbar_filter_background_highlighted"];
    [titleBtn setBackgroundImage:higImage forState:(UIControlStateHighlighted)];
    [titleBtn addTarget:self action:@selector(onClickTitleItem:) forControlEvents:(UIControlEventTouchUpInside)];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:(UIControlStateNormal)];
    self.navigationItem.titleView = titleBtn;
    
}

#pragma mark -按钮点击事件
/**
 *  点击做按钮
 */
-(void)onClickLeftItem:(UIBarButtonItem*)item{
    AITemp1ViewController *temp1VC = [[AITemp1ViewController alloc]init];
    [self.navigationController pushViewController:temp1VC animated:YES];
}
/**
 *  点击标题
 */
-(void)onClickTitleItem:(AIHomeTitleButton*)btn{
    UIImage *image = [UIImage imageNamed:@"navigationbar_arrow_down"];
    if ([image isEqual: [btn imageForState:(UIControlStateNormal)]]) {
        [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:(UIControlStateNormal)];
        self.popMenu = [AIPopMenu popMenuWithContentView:[[UISwitch alloc]init]];
        self.popMenu.delegate = self;
        [self.popMenu showInRect:CGRectMake(100, 0, 100, 100)];
        [self.view addSubview:self.popMenu];
    }else{
        [_popMenu dismiss];
    }
}

#pragma  mark -AIPopMenuDelegate
-(void)popMenuDisMiss:(AIPopMenu *)popMenu{
    [_titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:(UIControlStateNormal)];
    [popMenu removeFromSuperview];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.statusesFrames > 0) {
        self.footer.hidden = NO;
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusesFrames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AIStatusCell *cell = [AIStatusCell statusCell:tableView];
    cell.backgroundColor = [UIColor clearColor];
    cell.statusFrame = self.statusesFrames[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AITemp1ViewController *temp1VC = [[AITemp1ViewController alloc]init];
    [self.navigationController pushViewController:temp1VC animated:YES];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AIStatusFrame *statusFrame = self.statusesFrames[indexPath.row];
    
    return statusFrame.cellHeight ;
}

@end

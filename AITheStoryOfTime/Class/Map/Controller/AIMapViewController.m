//
//  AIMapViewController.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "UIBarButtonItem+AIExtension.h"
#import "ScreenshotDetailViewController.h"
#warning  测试时用最小改变大小
#define AIMapMinChange 0.00000
enum{
    OverlayViewControllerOverlayTypeCircle = 0,
    OverlayViewControllerOverlayTypePolyline,
    OverlayViewControllerOverlayTypePolygon
};
@interface AIMapViewController ()<MAMapViewDelegate,UIActionSheetDelegate>
/**
 *  高德地图
 */
@property(nonatomic,strong)MAMapView *mapView;
/**
 *  遮盖
 */
@property (nonatomic, strong) NSMutableArray *overlays;
/**
 *  后台遮盖
 */
@property (nonatomic, strong) NSMutableArray *backgroundOverlays;
/**
 *  前台和后台的遮盖
 */
@property(nonatomic,strong)NSMutableArray *allOverlays;
/**
 *  上一个点
 */
@property(nonatomic,assign)CLLocationCoordinate2D lastPoint;

@property (nonatomic, retain)UISegmentedControl *showSegment;
@property (nonatomic, retain)UISegmentedControl *modeSegment;

/**
 *  是否在后台运行
 */
@property(nonatomic,assign,getter=isBackground)BOOL background;
@end

@implementation AIMapViewController

#pragma mark -----------------懒加载---------
-(NSMutableArray *)allOverlays{
    if (!_allOverlays) {
        _allOverlays = [NSMutableArray array];
    }
    return _allOverlays;
}

-(NSMutableArray *)backgroundOverlays{
    if (!_backgroundOverlays) {
        _backgroundOverlays = [NSMutableArray array];
    }
    return _backgroundOverlays;
}

#pragma mark ---------------------点击事件------------
-(void)onClickMapRightItem{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"地图操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清除地图" otherButtonTitles:@"截屏", nil];
    [sheet showInView:self.view];
    
}

#pragma mark -----代理-----
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    AILog(@"buttonIndex%ld",buttonIndex);
    switch (buttonIndex) {
        case 0: //清除
            [_mapView removeOverlays:self.allOverlays];
            [self.allOverlays removeAllObjects];
            break;
        case 1: {//截屏
            UIImage *image = [self.mapView takeSnapshotInRect:self.mapView.bounds];
            [self transitionToDetailWithImage:image];
        }
            break;
        default:
            break;
    }

}

#pragma mark---------------------高德demo-------------
#pragma mark - MAMapViewDelegate


- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{
    self.modeSegment.selectedSegmentIndex = mode;
}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        
        circleRenderer.lineWidth   = 4.f;
        circleRenderer.strokeColor = [UIColor blueColor];
        circleRenderer.fillColor   = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
        
        return circleRenderer;
    }
    else if ([overlay isKindOfClass:[MAPolygon class]])
    {
        MAPolygonRenderer *polygonRenderer = [[MAPolygonRenderer alloc] initWithPolygon:overlay];
        polygonRenderer.lineWidth   = 4.f;
        polygonRenderer.strokeColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
        polygonRenderer.fillColor   = [UIColor redColor];
        
        return polygonRenderer;
    }
    else if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth   = 4.f;
        polylineRenderer.strokeColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        
        return polylineRenderer;
    }
    
    return nil;
}

#pragma mark - Action Handle

- (void)showsSegmentAction:(UISegmentedControl *)sender
{
    self.mapView.showsUserLocation = !sender.selectedSegmentIndex;
    if (!_mapView.isShowsUserLocation) {
        _lastPoint = kCLLocationCoordinate2DInvalid;;
    }
}

- (void)modeAction:(UISegmentedControl *)sender
{
    self.mapView.userTrackingMode = sender.selectedSegmentIndex;
}

#pragma mark - NSKeyValueObservering

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"showsUserLocation"])
    {
        NSNumber *showsNum = [change objectForKey:NSKeyValueChangeNewKey];
        
        self.showSegment.selectedSegmentIndex = ![showsNum boolValue];
    }
}

#pragma mark - Initialization

- (void)initToolBar
{
    UIBarButtonItem *flexble = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                             target:nil
                                                                             action:nil];
    
    self.showSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Start", @"Stop", nil]];
    self.showSegment.segmentedControlStyle = UISegmentedControlStyleBar;
    [self.showSegment addTarget:self action:@selector(showsSegmentAction:) forControlEvents:UIControlEventValueChanged];
    self.showSegment.selectedSegmentIndex = 0;
    UIBarButtonItem *showItem = [[UIBarButtonItem alloc] initWithCustomView:self.showSegment];
    
    self.modeSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"None", @"Follow", @"Head", nil]];
    self.modeSegment.segmentedControlStyle = UISegmentedControlStyleBar;
    [self.modeSegment addTarget:self action:@selector(modeAction:) forControlEvents:UIControlEventValueChanged];
    self.modeSegment.selectedSegmentIndex = 1;
    UIBarButtonItem *modeItem = [[UIBarButtonItem alloc] initWithCustomView:self.modeSegment];
    
    self.toolbarItems = [NSArray arrayWithObjects:flexble, showItem, flexble, modeItem, flexble, nil];
}

- (void)initObservers
{
    /* Add observer for showsUserLocation. */
    [self.mapView addObserver:self forKeyPath:@"showsUserLocation" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)returnAction
{
    self.mapView.userTrackingMode  = MAUserTrackingModeNone;
    
    [self.mapView removeObserver:self forKeyPath:@"showsUserLocation"];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initToolBar];
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTagert:self action:@selector(onClickMapRightItem) NorImageName:@"pic_icon" andHeiImageName:@"pic_icon"];
    self.title = @"地图";
    //地图
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 55, Mainsize.width, Mainsize.height-35)];
    self.mapView.delegate =self;
    [self.view addSubview:self.mapView];
    //设置默认缩放比例
    _mapView.zoomLevel = 17;
    AILog(@"%f,%f",self.mapView.minZoomLevel,_mapView.maxZoomLevel);

}

- (void)viewWillAppear:(BOOL)animated
{
    AILog(@"MAP---------------viewWillAppear");
    [super viewWillAppear:animated];
    
    self.navigationController.toolbar.barStyle      = UIBarStyleBlack;
    self.navigationController.toolbar.translucent   = YES;
    [self.navigationController setToolbarHidden:NO animated:animated];
    
    [self initObservers];
    [self.mapView setCompassImage:[UIImage imageNamed:@"compass"]];

}

- (void)viewDidAppear:(BOOL)animated
{
    AILog(@"MAP---------------viewDidAppear");
    [super viewDidAppear:animated];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;

    //清空以前的 线
    [self.mapView removeOverlays:self.allOverlays];
    //添加到地图上
    AILog(@"count----------%d",self.allOverlays.count);
    [self.mapView addOverlays:self.allOverlays];
    //标记为前台
    self.background = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    AILog(@"MAP---------------viewDidDisappear");
    [super viewDidDisappear:animated];
//后台定位
    if (iOS9) {
         _mapView.allowsBackgroundLocationUpdates = YES;
    }else{
        _mapView.pausesLocationUpdatesAutomatically = NO;
    }
    [self.mapView setCompassImage:nil];
    //标记为后台
    self.background = YES;
    
}
- (void)didReceiveMemoryWarning {
    AILog(@"MAP------------didReceiveMemoryWarning");
    [super didReceiveMemoryWarning];
}

#pragma mark -当位置更新时，会进定位回调，通过回调函数，能获取到定位点的经纬度坐标
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    
    if(updatingLocation)
    {
         //初始化lastPoint为当前位置
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _lastPoint = userLocation.coordinate;
        });
        [self backgroundOverlayOnMap:userLocation];
        //取出当前位置的坐标
//        AILog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
//        double latitude = userLocation.coordinate.latitude;
//        double longitude = userLocation.coordinate.longitude;
//        double changeLatitude = (fabs(1000000*(latitude-_lastPoint.latitude)))/1000000.0;
//        double changeLongitude = (fabs(1000000*(longitude-_lastPoint.longitude)))/1000000.0;
//        double change = sqrt(changeLatitude *changeLatitude + changeLongitude*changeLongitude);
//        AILog(@"change----------%f",change);
//        if (change >=  AIMapMinChange) {
            //            if (self.isBackground) {
//                [self backgroundOverlayOnMap:userLocation];
//            }else{
//                //直接画到地图上
//                [self overlayOnMap:userLocation];                
//            }
//        }

    }
}

#pragma mark --------------------遮盖-------------------------
-(void)overlayOnMap:(MAUserLocation*)userLocation{
    //添加到数组中
    self.overlays = [NSMutableArray array];
    
    //多线段
    /* Polyline. */
    CLLocationCoordinate2D polylineCoords[2];
    polylineCoords[0].latitude = userLocation.coordinate.latitude;
    polylineCoords[0].longitude = userLocation.coordinate.longitude;
    
    polylineCoords[1] = _lastPoint;
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:polylineCoords count:2];
    [self.overlays insertObject:polyline atIndex:0];
    //添加到一个数组中方便待会删除
    [self.allOverlays addObject:polyline];
    //添加到地图上
    [self.mapView addOverlays:self.overlays];
    _lastPoint = userLocation.coordinate;
}

-(void)backgroundOverlayOnMap:(MAUserLocation*)userLocation{
    AILog(@"backgroundOverlayOnMap");
    
    //多线段
    /* Polyline. */
    CLLocationCoordinate2D polylineCoords[2];
    polylineCoords[0].latitude = userLocation.coordinate.latitude;
    polylineCoords[0].longitude = userLocation.coordinate.longitude;
    
    polylineCoords[1] = _lastPoint;
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:polylineCoords count:2];
    [self.backgroundOverlays insertObject:polyline atIndex:0];
   
    //添加到一个数组中方便待会删除
    [self.allOverlays insertObject:polyline atIndex:0];
    [self.mapView addOverlays:self.allOverlays];
    _lastPoint = userLocation.coordinate;
}

#pragma mark--------------截屏-------------------
- (void)transitionToDetailWithImage:(UIImage *)image
{
    ScreenshotDetailViewController *detailViewController = [[ScreenshotDetailViewController alloc] init];
    detailViewController.screenshotImage = image;
    detailViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    
    [self presentViewController:navi animated:YES completion:^{
        
    }];
}


@end

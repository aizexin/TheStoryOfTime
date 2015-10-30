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
#define AIMapMinChange 0.00003
enum{
    OverlayViewControllerOverlayTypeCircle = 0,
    OverlayViewControllerOverlayTypePolyline,
    OverlayViewControllerOverlayTypePolygon
};
@interface AIMapViewController ()<MAMapViewDelegate>
/**
 *  高德地图
 */
@property(nonatomic,strong)MAMapView *mapView;
/**
 *  遮盖
 */
@property (nonatomic, strong) NSMutableArray *overlays;
@property(nonatomic,assign)CLLocationCoordinate2D lastPoint;


@property (nonatomic, retain)UISegmentedControl *showSegment;
@property (nonatomic, retain)UISegmentedControl *modeSegment;
@end

@implementation AIMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initToolBar];
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTagert:self action:@selector(onClickScreenshots) NorImageName:@"pic_icon" andHeiImageName:@"pic_icon"];
    self.title = @"地图";
    //地图
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 55, Mainsize.width, Mainsize.height-35)];
    self.mapView.delegate =self;
    [self.view addSubview:self.mapView];

}
#pragma mark ---------------------点击事件------------
-(void)onClickScreenshots{
    UIImage *image = [self.mapView takeSnapshotInRect:self.mapView.bounds];//[AIScreenTool screenWithSize:self.view.frame.size inView:self.view];
    [self transitionToDetailWithImage:image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.toolbar.barStyle      = UIBarStyleBlack;
    self.navigationController.toolbar.translucent   = YES;
    [self.navigationController setToolbarHidden:NO animated:animated];
    
    [self initObservers];
    
    [self.mapView setCompassImage:[UIImage imageNamed:@"compass"]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//后台定位
    if (iOS9) {
         _mapView.allowsBackgroundLocationUpdates = YES;
    }else{
        _mapView.pausesLocationUpdatesAutomatically = NO;
    }
    [self.mapView setCompassImage:nil];
    
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
        //取出当前位置的坐标
//        AILog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        double latitude = userLocation.coordinate.latitude;
        double longitude = userLocation.coordinate.longitude;
        double changeLatitude = (fabs(1000000*(latitude-_lastPoint.latitude)))/1000000.0;
        double changeLongitude = (fabs(1000000*(longitude-_lastPoint.longitude)))/1000000.0;
        double change = sqrt(changeLatitude *changeLatitude + changeLongitude*changeLongitude);
//        AILog(@"change----------%f",change);
//        kCLLocationCoordinate2DInvalid
        if (change >=  AIMapMinChange) {
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
            //添加到地图上
            [self.mapView addOverlays:self.overlays];
            
        }
        _lastPoint = userLocation.coordinate;
        
    }
}

#pragma mark --------------------遮盖-------------------------


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

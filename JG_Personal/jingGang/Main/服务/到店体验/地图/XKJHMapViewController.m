//
//  XKJHMapViewController.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/11.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKJHMapViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "PublicInfo.h"
#import "GlobeObject.h"
#import "Util.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"

@interface XKJHMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKMapPoi * _mapPoi;
    __weak IBOutlet UILabel *addressLabel;
    BMKLocationService* _locService;//定位
    BMKGeoCodeSearch  * _geocodesearch;//编码
}
//大头针
@property (nonatomic, strong) BMKPointAnnotation *pointAnnotation;
//地图
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

@end

@implementation XKJHMapViewController

#pragma mark - 大头针实例化
- (BMKPointAnnotation *)pointAnnotation
{
    if (_pointAnnotation == nil)
    {
        _pointAnnotation = [[BMKPointAnnotation alloc] init];
        [_mapView addAnnotation:_pointAnnotation];
    }
    return _pointAnnotation;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI
{
    if (!self.latitude)
    {
        self.latitude = 22.558888;
        self.longitude = 113.950723;
        self.shopAddress = @"广东省深圳市南山区科技园";
    }
//    _mapView.showMapScaleBar = YES;
//    //自定义比例尺的位置
//    _mapView.mapScaleBarPosition = CGPointMake(_mapView.frame.size.width - 70, _mapView.frame.size.height - 170);//CGPointMake(kScreenWidth- 60,  kScreenHeight- 90);
    
    [Util setNavTitleWithTitle:@"地图" ofVC:self];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _locService = [[BMKLocationService alloc]init];
    _mapView.zoomLevel = 18;
    
    if (self.latitude > 0 && self.longitude > 0 && self.shopAddress.length > 0) //定位到商店位置并大头针
    {
        self.pointAnnotation.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
        self.pointAnnotation.title = [NSString stringWithFormat:@"%@",self.shopAddress];
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
        addressLabel.text = self.shopAddress;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _geocodesearch.delegate = self;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate = nil;
    _locService.delegate = nil;
}

#pragma mark - 定位事件
- (IBAction)GPSAction:(UIButton *)sender
{
    [_locService startUserLocationService];
    _locService.delegate = self;
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
}
#pragma mark - 确定到商户所在地
- (IBAction)annotationTap:(UITapGestureRecognizer *)sender
{
    _locService.delegate = nil;
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
}


#if 0
#pragma mark - 点击地图，确定位置
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi
{
    if (self.addressBlock)
    {
        _mapPoi = mapPoi;
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = mapPoi.pt;
        [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
        self.pointAnnotation.coordinate = mapPoi.pt;
    }
}
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    if (self.addressBlock)
    {
        _mapPoi = nil;
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = coordinate;
        [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
        self.pointAnnotation.coordinate = coordinate;
    }
}
#pragma mark - 反向地理编码
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0)
    {
        NSMutableString *title = [[NSMutableString alloc] initWithString:result.address];;
        if (_mapPoi != nil)
        {
            [title appendString:_mapPoi.text];
        }
        self.pointAnnotation.coordinate = result.location;
        self.pointAnnotation.title = title;
        addressLabel.text = title;
        self.latitude = result.location.latitude;
        self.longitude = result.location.longitude;
    }
}
#pragma mark - 正向地理编码
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0)
    {
        _mapView.centerCoordinate = result.location;
    }
}
#endif


@end

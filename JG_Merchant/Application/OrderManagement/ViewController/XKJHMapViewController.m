//
//  XKJHMapViewController.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/11.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKJHMapViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "UIBarButtonItem+WNXBarButtonItem2.h"

@interface XKJHMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    NSString *_resultAddress;
    CGFloat   _resultLatitude;
    CGFloat   _resultLongitude;
    
    BMKMapPoi * _mapPoi;
    
    __weak IBOutlet UILabel *addressLabel;
    BMKLocationService* _locService;//定位
    BMKGeoCodeSearch *_geocodesearch;//编码
}

//大头针
@property (nonatomic, strong) BMKPointAnnotation *pointAnnotation;
//地图
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

@end

@implementation XKJHMapViewController

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
#pragma mark - 确定回调
- (void)certain
{
    if (_resultAddress.length == 0)
    {
        [Util ShowAlertWithOnlyMessage:@"请点击商户所在地"];
        return;
    }
    if (self.addressBlock)
    {
        self.addressBlock(_resultAddress,_resultLatitude,_resultLongitude);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)initUI
{
    [Util setNavTitleWithTitle:@"地图" ofVC:self];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 50, 50);
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [rightBtn addTarget:self action:@selector(certain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc ]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _mapView.zoomLevel = 15;
//    _mapView.showMapScaleBar = YES;
//    //自定义比例尺的位置
//    _mapView.mapScaleBarPosition = CGPointMake(_mapView.frame.size.width - 70, _mapView.frame.size.height - 170);
    
    if (self.latitude > 0 && self.longitude > 0 && self.selectAddress.length > 0) //如果已选过的店铺地址，定位到该位置并大头针
    {
        self.pointAnnotation.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
        self.pointAnnotation.title = [NSString stringWithFormat:@"%@%@",self.address,self.selectAddress];
        addressLabel.text = self.pointAnnotation.title;
        _resultAddress = self.selectAddress;
        _resultLatitude = self.latitude;
        _resultLongitude = self.longitude;
    }
    else if(self.address.length > 0) //如果选择了地区，那对该地区进行编码
    {
        BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
        geocodeSearchOption.address = self.address;
        [_geocodesearch geoCode:geocodeSearchOption];
    }
    else if (!self.address.length)//没有选择地区时使用地位功能
    {
        _locService = [[BMKLocationService alloc]init];
        [_locService startUserLocationService];
        _locService.delegate = self;
        _mapView.showsUserLocation = NO;
        _mapView.userTrackingMode = BMKUserTrackingModeFollow;
        _mapView.showsUserLocation = YES;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _geocodesearch.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate = nil;
    _locService.delegate = nil;
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    
    //    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    _locService.delegate = nil;
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
}
#pragma mark - 点击地图，确定位置
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi
{
    _mapPoi = mapPoi;
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = mapPoi.pt;
    [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    self.pointAnnotation.coordinate = mapPoi.pt;

}
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    _mapPoi = nil;
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = coordinate;
    [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    self.pointAnnotation.coordinate = coordinate;
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
        _resultLatitude = result.location.latitude;
        _resultLongitude = result.location.longitude;
        BMKAddressComponent *componet = result.addressDetail;
        _resultAddress = [NSString stringWithFormat:@"%@%@%@",componet.streetName,componet.streetNumber, _mapPoi ? _mapPoi.text : @""];
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

@end

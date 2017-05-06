//
//  BaiduLocationManage.m
//  百度定位
//
//  Created by thinker on 15/12/21.
//  Copyright © 2015年 thinker. All rights reserved.
//

#import "BaiduLocationManage.h"

@interface BaiduLocationManage ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BaiduGeoCodeResultBlock _resultBlock;
}

@property (nonatomic, strong)    BMKGeoCodeSearch  * geocodesearch;//编码


@property (nonatomic, strong) BMKLocationService *location;

@property(nonatomic,strong)CLGeocoder *geocoder;

@end


@implementation BaiduLocationManage

+(id)shareManage
{
    static BaiduLocationManage *manage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[BaiduLocationManage alloc] init];
        //初始化BMKLocationService
        manage.location = [[BMKLocationService alloc] init];
    });
    return manage;
}

-(void)setWithCoordinate2D:(CLLocationCoordinate2D)coordinate withAddress:(BaiduGeoCodeResultBlock)result
{
    _resultBlock = result;
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = coordinate;
    [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    self.geocodesearch.delegate = self;
}

-(void)setBaiduLocationBlock:(BaiduLocationBlock)baiduLocationBlock
{
    _baiduLocationBlock = baiduLocationBlock;
    self.location.delegate = self;
    [self.location startUserLocationService];
}

#pragma mark - BMKLocationServiceDelegate
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
//    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    _currentLocation = userLocation;
    if (_baiduLocationBlock) {
        _baiduLocationBlock(userLocation);
        [self.location stopUserLocationService];
//        self.location.delegate = self;
    }
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = [placemarks firstObject];
        _currentCity = placemark.addressDictionary[@"City"];
        NSLog(@"address ---- %@ name = %@",placemark.addressDictionary[@"FormattedAddressLines"][0],placemark.name);
        
    }];
    
}
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"error ---- %@",error);
}

#pragma mark - BMKGeoCodeSearchDelegate
//反向编码
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0)
    {
        _resultBlock(result.address);
        searcher.delegate = nil;
    }
}


#pragma mark - getter

-(CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

-(BMKGeoCodeSearch *)geocodesearch
{
    if (!_geocodesearch) {
        _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    }
    return _geocodesearch;
}

@end

//
//  mapShared.m
//  jingGang
//
//  Created by thinker on 15/9/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "mapObject.h"
#import "PublicInfo.h"
#import "VApiManager.h"
#import "GlobeObject.h"

@interface mapObject ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BOOL isFirst;
    BaiduLocationResult _resultBlock;           //定位后返回定位信息
    BaiduLocationResultAndCityID _resultBlockID;//定位后返回定位信息，和城市id
}
//定位
@property (nonatomic, strong) BMKLocationService *locService;
//地理编码
@property (nonatomic, strong) BMKGeoCodeSearch   *geocodesearch;

@end

@implementation mapObject

+(id)sharedMap
{
    static dispatch_once_t onceToken;
    static mapObject *mapModel = nil;
    dispatch_once(&onceToken, ^{
        mapModel = [[self alloc] init];
        mapModel.locService = [[BMKLocationService alloc ]init];
        mapModel.geocodesearch = [[BMKGeoCodeSearch alloc ]init];
        mapModel.baiduCity = kUserDefaultOfkey(@"baiduCity");
        mapModel.baiduCityID = kUserDefaultOfkey(@"baiduCityID");
        mapModel.baiduLatitude = kUserDefaultOfkey(@"baiduLatitude");
        mapModel.baiduLongitude = kUserDefaultOfkey(@"baiduLogitude");
    });
    return mapModel;
}
- (void)setLocationService:(BOOL)LocationService
{
    _LocationService = LocationService;
    [self baiduUserLocationService:LocationService];
}
/**
 *  百度定位是否开启
 *
 *  @param status YES：为开始   NO：为关闭
 */
- (void)baiduUserLocationService:(BOOL)status
{
    
    if (status)   //开始定位
    {
        [_locService startUserLocationService];
        _locService.delegate = self;
        _geocodesearch.delegate = self;
    }
    else          //关闭定位
    {
        [_locService stopUserLocationService];
        _locService.delegate = nil;
        _geocodesearch.delegate = nil;
    }
}

-(void)BaiduPositionReusltAddID:(BaiduLocationResultAndCityID)block
{
    _resultBlockID = block;
    [self baiduUserLocationService:YES];

}
-(void)BaiduPositionReuslt:(BaiduLocationResult)block
{
    _resultBlock = block;
    [self baiduUserLocationService:YES];
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    if (!self.LocationService)    //TODO:判断是否长期开始定位功能
    {
        [_locService stopUserLocationService];
        _locService.delegate = nil;
    }
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
}
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"没有打开定位配置 ---- %@",error);
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=INTERNET_TETHERING"]];
}
#pragma mark - 反向地理编码
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    WEAK_SELF
    if (error == 0)
    {
        if (_resultBlock)
        {
            _resultBlock(result.addressDetail,result.location);
        }
        
        VApiManager *vapiManager = [[VApiManager alloc] init];
        PersonalCityGetRequest *cityRequest = [[PersonalCityGetRequest alloc] init:GetToken];
        cityRequest.api_cityName = result.addressDetail.city;
        [vapiManager personalCityGet:cityRequest success:^(AFHTTPRequestOperation *operation, PersonalCityGetResponse *response) {
            NSDictionary *dict = (NSDictionary *)response.areaBO;
            
            if (!isFirst || weak_self.LocationService == YES)
            {
                if (weak_self.baiduCityID == nil && weak_self.baiduCity == nil)
                {
                    weak_self.baiduCity = result.addressDetail.city;
                    weak_self.baiduCityID = dict[@"id"];
                }
                weak_self.baiduLatitude = @(result.location.latitude);
                weak_self.baiduLongitude = @(result.location.longitude);
            }
            if (!isFirst) //TODO:打开APP定位后进行一次数据缓存
            {
                NSUserDefaults *defaults = kUserDefaults;
                [defaults setObject:weak_self.baiduCity forKey:@"baiduCity"];
                [defaults setObject:weak_self.baiduCityID forKey:@"baiduCityID"];
                [defaults setObject:weak_self.baiduLatitude forKey:@"baiduLatitude"];
                [defaults setObject:weak_self.baiduLongitude forKey:@"baiduLogitude"];
                isFirst = YES;
            }
            if (_resultBlockID && weak_self.LocationService == NO)
            {
                _resultBlockID(result.addressDetail.city,result.location,dict[@"id"]);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"定位获取城市ID出错 ---- %@",error);
        }];
    }
    else
    {
        [self baiduUserLocationService:YES];
    }
}
@end

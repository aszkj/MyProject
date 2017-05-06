//
//  BaiduLocationManage.m
//  百度定位
//
//  Created by thinker on 15/12/21.
//  Copyright © 2015年 thinker. All rights reserved.
//

#import "BaiduLocationManage.h"

const NSInteger stopLocationTimeIntegral = 10 * 60;

@interface BaiduLocationManage ()<BMKLocationServiceDelegate>
{
    CLLocation *cllocation;
}

@property (nonatomic, strong) BMKLocationService *location;
@property (nonatomic, copy) BaiduLocationBlock baiduLocationBlock;
@property (nonatomic, copy) BaiduLocationErrorBlock baiduLocationErrorBlock;

@property (nonatomic, assign) BOOL isFirstLocationSuccessed;

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

-(void)stopLocationService {

    [self.location stopUserLocationService];
}

-(void)startLocationBackBlock:(BaiduLocationBlock)baiduLocationBlock
                   errorBlock:(BaiduLocationErrorBlock)errorblock
{
    _baiduLocationBlock = baiduLocationBlock;
    _baiduLocationErrorBlock = errorblock;
    [self _startLocation];
}

- (void)_startLocation {
    self.isFirstLocationSuccessed = YES;
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
    JLog(@"定位成功 ---didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    _currentLocation = userLocation;
    if (self.isFirstLocationSuccessed && _baiduLocationBlock) {
        self.isFirstLocationSuccessed = NO;
        self.latitude = _currentLocation.location.coordinate.latitude;
        self.longtitude = _currentLocation.location.coordinate.longitude;
        if (self.baiduLocationBlock) {
            self.baiduLocationBlock(userLocation.location,nil);
        }
        
        [self performSelector:@selector(stopLocationService) withObject:nil afterDelay:stopLocationTimeIntegral];
    }
}


- (void)_reversGecodeToCityWithLocation:(CLLocation *)location {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error){
            if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            //将获得的所有信息显示到label上
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            if (!city) {
                city = @"--";
            }
            if (self.baiduLocationBlock) {
                self.baiduLocationBlock(location,city);
            }
            JLog(@"地理编码后的city = %@", city);
        }
        else if (error == nil && [array count] == 0)
        {
            JLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            JLog(@"An error occurred = %@", error);
        }
    }];

}

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
    JLog(@"已停止定位");
}
/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    JLog(@"定位失败，错误%@",error);
    if (self.baiduLocationErrorBlock) {
        self.baiduLocationErrorBlock(error);
    }
}



@end

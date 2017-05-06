//
//  BaiduLocationManage.m
//  百度定位
//
//  Created by thinker on 15/12/21.
//  Copyright © 2015年 thinker. All rights reserved.
//

#import "BaiduLocationManage.h"

@interface BaiduLocationManage ()<BMKLocationServiceDelegate>

@property (nonatomic, strong) BMKLocationService *location;

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
        self.location.delegate = self;
    }
}



@end

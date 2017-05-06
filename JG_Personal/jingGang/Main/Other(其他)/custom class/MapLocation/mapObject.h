//
//  mapShared.h
//  jingGang
//
//  Created by thinker on 15/9/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI/BMapKit.h>

/**
 *  获取当前地理位置以及城市ID
 *
 *  @param block addressDetail：位置详情  location：经纬度 cityID：城市ID
 */
typedef void (^BaiduLocationResult)(BMKAddressComponent *addressDetail,CLLocationCoordinate2D location);
typedef void (^BaiduLocationResultAndCityID)(NSString *addressCity,CLLocationCoordinate2D location,NSNumber *cityID);

@interface mapObject : NSObject


/**
 *  地图单利对象
 *
 *  @return
 */
+(id)sharedMap;


#pragma mark - ------------百度定位结果信息----------------
/**
 *  百度定位--城市 类型NSString
 */
@property (nonatomic, strong) NSString  *baiduCity;
/**
 *  百度定位--城市id 类型NSNumber
 */
@property (nonatomic, strong) NSNumber  *baiduCityID;
/**
 *  百度定位--纬度 类型NSNumber
 */
@property (nonatomic, strong) NSNumber  *baiduLatitude;
/**
 *  百度定位--经度 类型NSNumber
 */
@property (nonatomic, strong) NSNumber  *baiduLongitude;


#pragma mark - ------------百度定位设置----------------

/**
 *  百度定位是否开启  <<<<<<有开始必须要有关闭，否者一直定位>>>>>>
 *
 *  @param LocationService YES为开启定位，NO为关闭定位
 */
@property (nonatomic, assign) BOOL      LocationService;





#pragma mark - ---------------------------------------
/**
 *  获取当前的地理位置
 *
 *  @param block addressDetail：位置详情  location：经纬度 
 */
//- (void)BaiduPositionReuslt:(BaiduLocationResult)block;
/**
 *  获取当前地理位置以及城市ID
 *
 *  @param block addressCity：定位城市  location：经纬度 cityID：城市ID
 */
- (void)BaiduPositionReusltAddID:(BaiduLocationResultAndCityID)block;




@end

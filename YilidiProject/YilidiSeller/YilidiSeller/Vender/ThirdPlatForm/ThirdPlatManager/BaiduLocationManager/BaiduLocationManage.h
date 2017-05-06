//
//  BaiduLocationManage.h
//  百度定位
//
//  Created by thinker on 15/12/21.
//  Copyright © 2015年 thinker. All rights reserved.
//

#import <Foundation/Foundation.h>
//引入定位功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>



typedef void (^BaiduLocationBlock)(CLLocation *location,NSString *city);
typedef void (^BaiduLocationErrorBlock)(NSError *error);


@interface BaiduLocationManage : NSObject


+(id)shareManage;

/**
 *  当前定位的位置
 */
@property (nonatomic, strong) BMKUserLocation *currentLocation;
/**
 *  开始定位
 *
 *  @param baiduLocationBlock 返回定位结果
 *  @param errorblock         返回错误信息
 */
-(void)startLocationBackBlock:(BaiduLocationBlock)baiduLocationBlock
                   errorBlock:(BaiduLocationErrorBlock)errorblock;

/**
 *  停止定位
 */
-(void)stopLocationService;



@end

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


typedef void (^BaiduLocationBlock)(BMKUserLocation *location);

@interface BaiduLocationManage : NSObject


+(id)shareManage;

/**
 *  当前定位的位置
 */
@property (nonatomic, strong) BMKUserLocation *currentLocation;
/**
 *  定位结果通过block返回
 */
@property (nonatomic, copy) BaiduLocationBlock baiduLocationBlock;



@end

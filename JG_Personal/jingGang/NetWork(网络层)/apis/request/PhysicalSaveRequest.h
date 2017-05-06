//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PhysicalSaveResponse.h"

@interface PhysicalSaveRequest : AbstractRequest
/** 
 * 体检最小值|视力检查
 */
@property (nonatomic, readwrite, copy) NSNumber *api_minValue;
/** 
 * 体检最大值|如果只有一个值或者体检最大值|色盲测试
 */
@property (nonatomic, readwrite, copy) NSNumber *api_maxValue;
/** 
 * 散光测试
 */
@property (nonatomic, readwrite, copy) NSNumber *api_middleValue;
/** 
 * 类型|1视力表2视力检测3色盲测试4散光测试5听力6血压7心率8肺活量9血氧
 */
@property (nonatomic, readwrite, copy) NSNumber *api_type;
/** 
 * 时间|如：2015-07-08
 */
@property (nonatomic, readwrite, copy) NSString *api_time;
/** 
 * 终端类型：0:PC,1:android,2:ios
 */
@property (nonatomic, readwrite, copy) NSNumber *api_terminalType;
/** 
 * 地区id|市级
 */
@property (nonatomic, readwrite, copy) NSNumber *api_areaId;
/** 
 * 纬度
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeLon;
/** 
 * 经度
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeLat;
@end

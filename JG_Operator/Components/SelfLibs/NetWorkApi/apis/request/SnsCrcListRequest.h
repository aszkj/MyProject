//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SnsCrcListResponse.h"

@interface SnsCrcListRequest : AbstractRequest
/** 
 * 推荐位置Code;由后台人员提供
 */
@property (nonatomic, readwrite, copy) NSString *api_posCode;
/** 
 * 查询时间戳
 */
@property (nonatomic, readwrite, copy) NSString *api_timeStamp;
/** 
 * 城市id,主要用于服务的推荐位
 */
@property (nonatomic, readwrite, copy) NSNumber *api_cityId;
/** 
 * 纬度
 */
@property (nonatomic, readwrite, copy) NSNumber *api_lon;
/** 
 * 经度
 */
@property (nonatomic, readwrite, copy) NSNumber *api_lat;
@end

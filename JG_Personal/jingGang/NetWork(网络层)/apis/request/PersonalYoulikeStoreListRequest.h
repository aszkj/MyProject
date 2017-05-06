//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PersonalYoulikeStoreListResponse.h"

@interface PersonalYoulikeStoreListRequest : AbstractRequest
/** 
 * 服务id|以逗号隔开
 */
@property (nonatomic, readwrite, copy) NSString *api_gId;
/** 
 * 纬度
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeLon;
/** 
 * 经度
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeLat;
/** 
 * 地区id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_areaId;
@end

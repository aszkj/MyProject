//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PersonalGroupGoodsLikeResponse.h"

@interface PersonalGroupGoodsLikeRequest : AbstractRequest
/** 
 * 服务id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_gId;
/** 
 * 纬度
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeLon;
/** 
 * 经度
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeLat;
@end

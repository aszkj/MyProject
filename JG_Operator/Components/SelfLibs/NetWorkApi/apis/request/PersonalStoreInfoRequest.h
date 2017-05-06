//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PersonalStoreInfoResponse.h"

@interface PersonalStoreInfoRequest : AbstractRequest
/** 
 * 店铺id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeId;
/** 
 * 纬度
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeLon;
/** 
 * 经度
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeLat;
@end

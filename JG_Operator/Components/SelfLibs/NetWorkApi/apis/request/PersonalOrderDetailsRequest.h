//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PersonalOrderDetailsResponse.h"

@interface PersonalOrderDetailsRequest : AbstractRequest
/** 
 * 订单id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_orderId;
/** 
 * 纬度
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeLon;
/** 
 * 经度
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeLat;
@end

//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ShopTransportGetResponse.h"

@interface ShopTransportGetRequest : AbstractRequest
/** 
 * 购物车id
 */
@property (nonatomic, readwrite, copy) NSString *api_cartIds;
/** 
 * 地区id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_areaId;
@end

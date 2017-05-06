//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ShopUserAddressAllResponse.h"

@interface ShopUserAddressAllRequest : AbstractRequest
/** 
 * def为true获取默认收货地址|false获取全部收货地址
 */
@property (nonatomic, readwrite, copy) NSNumber *api_def;
@end

//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "IntegralExchangeResponse.h"

@interface IntegralExchangeRequest : AbstractRequest
/** 
 * 积分商品id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_id;
/** 
 * 数量
 */
@property (nonatomic, readwrite, copy) NSNumber *api_count;
@end

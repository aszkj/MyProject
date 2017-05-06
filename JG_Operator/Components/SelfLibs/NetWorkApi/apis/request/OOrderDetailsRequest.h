//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "OOrderDetailsResponse.h"

@interface OOrderDetailsRequest : AbstractRequest
/** 
 * 订单id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_orderId;
@end

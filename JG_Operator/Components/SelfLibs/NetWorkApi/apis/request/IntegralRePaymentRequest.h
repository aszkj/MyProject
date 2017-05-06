//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "IntegralRePaymentResponse.h"

@interface IntegralRePaymentRequest : AbstractRequest
/** 
 * 积分订单ID
 */
@property (nonatomic, readwrite, copy) NSNumber *api_id;
@end

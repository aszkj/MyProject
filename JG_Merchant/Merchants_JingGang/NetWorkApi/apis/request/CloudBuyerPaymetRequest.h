//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "CloudBuyerPaymetResponse.h"

@interface CloudBuyerPaymetRequest : AbstractRequest
/** 
 * id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_id;
/** 
 * 充值金额
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pdAmount;
/** 
 * 充值方式
 */
@property (nonatomic, readwrite, copy) NSString *api_pdPayment;
@end

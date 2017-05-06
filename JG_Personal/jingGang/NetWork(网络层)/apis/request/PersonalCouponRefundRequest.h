//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PersonalCouponRefundResponse.h"

@interface PersonalCouponRefundRequest : AbstractRequest
/** 
 * 消费码
 */
@property (nonatomic, readwrite, copy) NSString *api_groupSn;
/** 
 * 退款原因
 */
@property (nonatomic, readwrite, copy) NSString *api_refundReasion;
@end

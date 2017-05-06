//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PersonalOrderPayResponse.h"

@interface PersonalOrderPayRequest : AbstractRequest
/** 
 * 支付类型
 */
@property (nonatomic, readwrite, copy) NSString *api_payType;
/** 
 * 订单id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_orderId;
/** 
 * 是否用云币
 */
@property (nonatomic, readwrite, copy) NSNumber *api_isAvailableBalance;
/** 
 * 支付密码
 */
@property (nonatomic, readwrite, copy) NSString *api_paymentPassword;
@end

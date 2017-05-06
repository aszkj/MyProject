//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ShopTradePaymetResponse.h"

@interface ShopTradePaymetRequest : AbstractRequest
/** 
 * 支付方式:  alipay_app,wx_app
 */
@property (nonatomic, readwrite, copy) NSString *api_paymentType;
/** 
 * 主订单 id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_mainOrderId;
/** 
 * 是否用户云币支付
 */
@property (nonatomic, readwrite, copy) NSNumber *api_isUserMoneyPaymet;
/** 
 * 用户支付密码，如果为云币支付该密码不能为空
 */
@property (nonatomic, readwrite, copy) NSString *api_paymetPassword;
/** 
 * 类型：1商城支付；2服务支付；3积分兑换支付
 */
@property (nonatomic, readwrite, copy) NSNumber *api_type;
@end

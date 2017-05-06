//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "WeiXinPaymet.h"

@interface ShopTradePaymetResponse :  AbstractResponse
//是否已经完成了支付
@property (nonatomic, readonly, copy) NSNumber *isCompletePay;
//支付方式
@property (nonatomic, readonly, copy) NSString *paymetType;
//支付密文,支付宝用
@property (nonatomic, readonly, copy) NSString *paySignature;
//weixin 支付相关
@property (nonatomic, readonly, copy) WeiXinPaymet *weiXinPaymet;
//订单状态
@property (nonatomic, readonly, copy) NSNumber *orderStatus;
@end

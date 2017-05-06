//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "WeiXinPaymet.h"

@interface CloudBuyerPaymetResponse :  AbstractResponse
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
//云币充值id
@property (nonatomic, readonly, copy) NSNumber *predepositId;
//云币充值金额
@property (nonatomic, readonly, copy) NSNumber *pdAmount;
//云币创建时间
@property (nonatomic, readonly, copy) NSDate *addTime;
//收款银行
@property (nonatomic, readonly, copy) NSString *cashBank;
//银行帐号
@property (nonatomic, readonly, copy) NSString *cashAccount;
//银行支行
@property (nonatomic, readonly, copy) NSString *cashSubbranch;
@end

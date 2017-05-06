//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "CloudBuyerCashSaveResponse.h"

@interface CloudBuyerCashSaveRequest : AbstractRequest
/** 
 * 提现金额
 */
@property (nonatomic, readwrite, copy) NSNumber *api_cashAmount;
/** 
 * 提现方式
 */
@property (nonatomic, readwrite, copy) NSString *api_cashPayment;
/** 
 * 收款人姓名
 */
@property (nonatomic, readwrite, copy) NSString *api_cashUserName;
/** 
 * 收款银行
 */
@property (nonatomic, readwrite, copy) NSString *api_cashBank;
/** 
 * 收款账号
 */
@property (nonatomic, readwrite, copy) NSString *api_cashAccount;
/** 
 * 提现密码
 */
@property (nonatomic, readwrite, copy) NSString *api_cashPassword;
/** 
 * 提现备注
 */
@property (nonatomic, readwrite, copy) NSString *api_cashInfo;
/** 
 * 用户类型
 */
@property (nonatomic, readwrite, copy) NSNumber *api_userType;
/** 
 * 银行支行
 */
@property (nonatomic, readwrite, copy) NSString *api_cashSubbranch;
/** 
 * 提现类型0,web端1,APP端
 */
@property (nonatomic, readwrite, copy) NSNumber *api_cashRelation;
/** 
 * 云币提现id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_cashId;
@end

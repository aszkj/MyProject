//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "OperatorRegisterUserList.h"
#import "OperatorManagement.h"
#import "OperatorProfit.h"
#import "OperatorMember.h"
#import "CashMoneyDetails.h"
#import "OperatorRelationList.h"
#import "OperatorProfitList.h"
#import "OperatorInfo.h"

@interface OperatorRegisterListResponse :  AbstractResponse
//营运商信息
@property (nonatomic, readonly, copy) OperatorInfo *operatorInfo;
//营运商提现明细
@property (nonatomic, readonly, copy) NSArray *cashMoneyDetailsBOs;
//营运商会员
@property (nonatomic, readonly, copy) NSArray *memberList;
//收益列表
@property (nonatomic, readonly, copy) NSArray *operatorList;
//营运商邀请码
@property (nonatomic, readonly, copy) NSString *invitationCode;
//营运商商户管理
@property (nonatomic, readonly, copy) NSArray *operatorRebateList;
//营运商收益
@property (nonatomic, readonly, copy) NSArray *operatorpProfitList;
//收益总计
@property (nonatomic, readonly, copy) NSNumber *profitTotal;
//营运商关系汇总
@property (nonatomic, readonly, copy) OperatorRelationList *operatorRelation;
//营运商注册会员列表
@property (nonatomic, readonly, copy) NSArray *operatorRegisterList;
//预期收益
@property (nonatomic, readonly, copy) NSArray *expectProfit;
//预期收益总额
@property (nonatomic, readonly, copy) NSNumber *expectProfitTotal;
@end

//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "OperatorMember.h"
#import "CashMoneyDetails.h"
#import "Operator.h"

@interface OperatorInfoResponse :  AbstractResponse
//营运商信息
@property (nonatomic, readonly, copy) Operator *operatorInfo;
//营运商提现明细
@property (nonatomic, readonly, copy) NSArray *cashMoneyDetailsBOs;
//营运商会员
@property (nonatomic, readonly, copy) NSArray *memberList;
@end

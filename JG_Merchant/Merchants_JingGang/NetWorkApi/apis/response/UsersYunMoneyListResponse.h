//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "UserYunMoneyBO.h"

@interface UsersYunMoneyListResponse :  AbstractResponse
//用户云币明细
@property (nonatomic, readonly, copy) NSArray *userYunMoneyBO;
//用户云币明细记录总数
@property (nonatomic, readonly, copy) NSNumber *userYunMoneyCount;
//用户云币总数
@property (nonatomic, readonly, copy) NSNumber *availableBalance;
//用户云币明细
@property (nonatomic, readonly, copy) NSDictionary *listMap;
@end

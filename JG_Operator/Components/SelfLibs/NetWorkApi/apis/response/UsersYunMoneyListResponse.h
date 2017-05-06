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
//用户积分明细
@property (nonatomic, readonly, copy) NSArray *userYunMoneyBO;
//用户积分明细总数
@property (nonatomic, readonly, copy) NSNumber *userYunMoneyCount;
//用户积分明细
@property (nonatomic, readonly, copy) NSDictionary *listMap;
@end

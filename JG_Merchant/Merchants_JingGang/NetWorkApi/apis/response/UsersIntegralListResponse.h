//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "UserIntegralDetailBO.h"

@interface UsersIntegralListResponse :  AbstractResponse
//用户积分明细
@property (nonatomic, readonly, copy) NSArray *userIntegralDetailBO;
//用户积分明细总数
@property (nonatomic, readonly, copy) NSNumber *userIntegralCount;
@end

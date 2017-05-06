//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "UserCustomer.h"
#import "UserIntegral.h"

@interface GetUserIntegralResponse :  AbstractResponse
//用户信息 
@property (nonatomic, readonly, copy) UserCustomer *customer;
//用户积分信息
@property (nonatomic, readonly, copy) UserIntegral *integral;
@end

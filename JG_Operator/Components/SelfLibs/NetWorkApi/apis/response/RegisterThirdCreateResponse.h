//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"

@interface RegisterThirdCreateResponse :  AbstractResponse
//用户ID
@property (nonatomic, readonly, copy) NSNumber *uid;
//登陆账号
@property (nonatomic, readonly, copy) NSString *loginName;
@end

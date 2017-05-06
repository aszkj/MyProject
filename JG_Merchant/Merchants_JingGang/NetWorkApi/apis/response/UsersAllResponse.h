//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "User.h"

@interface UsersAllResponse :  AbstractResponse
//用户列表 
@property (nonatomic, readonly, copy) NSArray *users;
@end

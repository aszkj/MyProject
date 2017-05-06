//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"

@interface UsersRefererInfoResponse :  AbstractResponse
//用户id
@property (nonatomic, readonly, copy) NSNumber *userId;
//用户昵称
@property (nonatomic, readonly, copy) NSString *nickName;
@end

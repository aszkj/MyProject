//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"

@interface UsersInvitationCodeBindResponse :  AbstractResponse
//是否邀请成功
@property (nonatomic, readonly, copy) NSNumber *verfiySuccess;
@end

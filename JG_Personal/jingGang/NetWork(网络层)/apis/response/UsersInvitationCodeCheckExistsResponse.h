//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"

@interface UsersInvitationCodeCheckExistsResponse :  AbstractResponse
//是否邀请过
@property (nonatomic, readonly, copy) NSNumber *isExist;
//是否邀请成功
@property (nonatomic, readonly, copy) NSString *invitationCode;
@end

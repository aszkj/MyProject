//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "CircleInvitation.h"

@interface UsersInvitationLookResponse :  AbstractResponse
//帖子信息
@property (nonatomic, readonly, copy) CircleInvitation *invitation;
@end

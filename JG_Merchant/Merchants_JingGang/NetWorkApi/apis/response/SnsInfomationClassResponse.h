//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "InvitationClassBO.h"

@interface SnsInfomationClassResponse :  AbstractResponse
//帖子分类列表
@property (nonatomic, readonly, copy) NSArray *invitationClasses;
@end

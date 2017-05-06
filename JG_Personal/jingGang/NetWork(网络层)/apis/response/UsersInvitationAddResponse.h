//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"

@interface UsersInvitationAddResponse :  AbstractResponse
//帖子ID
@property (nonatomic, readonly, copy) NSNumber *apiId;
//用户ID
@property (nonatomic, readonly, copy) NSNumber *uid;
//帖子标题
@property (nonatomic, readonly, copy) NSString *title;
//用户昵称
@property (nonatomic, readonly, copy) NSString *userName;
@end

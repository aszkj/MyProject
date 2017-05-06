//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "CircleInvitation.h"

@interface UsersInvitationAllListResponse :  AbstractResponse
//帖子列表
@property (nonatomic, readonly, copy) NSArray *invitation;
//总记录
@property (nonatomic, readonly, copy) NSNumber *totalCount;
//最后一条记录时间
@property (nonatomic, readonly, copy) NSNumber *times;
@end

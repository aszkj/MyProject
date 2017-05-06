//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "CircleInvitation.h"

@interface UsersCircleInvitationListResponse :  AbstractResponse
//圈子列表
@property (nonatomic, readonly, copy) NSArray *circle;
//总记录
@property (nonatomic, readonly, copy) NSNumber *totalCount;
//最后一条记录时间
@property (nonatomic, readonly, copy) NSNumber *times;
//列表总页数
@property (nonatomic, readonly, copy) NSNumber *totalPage;
@end

//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "UserExperts.h"

@interface UsersExpertsListResponse :  AbstractResponse
//专家列表
@property (nonatomic, readonly, copy) NSArray *experts;
//总记录
@property (nonatomic, readonly, copy) NSNumber *totalCount;
//专家详情
@property (nonatomic, readonly, copy) UserExperts *expertsDetail;
@end

//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "UserConsultingListBO.h"

@interface UsersConsultingListResponse :  AbstractResponse
//用户咨询问题列表
@property (nonatomic, readonly, copy) NSArray *consultingResult;
//总记录
@property (nonatomic, readonly, copy) NSNumber *totalCount;
@end

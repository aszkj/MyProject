//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "CheckResultHistory.h"

@interface UsersCheckHistoryResponse :  AbstractResponse
//自测历史结果列表
@property (nonatomic, readonly, copy) NSArray *checkResults;
//总记录
@property (nonatomic, readonly, copy) NSNumber *totalCount;
@end

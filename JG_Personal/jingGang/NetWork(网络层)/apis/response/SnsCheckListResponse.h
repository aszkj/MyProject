//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "CheckGroup.h"

@interface SnsCheckListResponse :  AbstractResponse
//自测题列表
@property (nonatomic, readonly, copy) NSArray *checkGruops;
//总记录
@property (nonatomic, readonly, copy) NSNumber *totalCount;
@end

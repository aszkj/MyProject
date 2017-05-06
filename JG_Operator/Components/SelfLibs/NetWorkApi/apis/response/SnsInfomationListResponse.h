//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "InfomationBO.h"

@interface SnsInfomationListResponse :  AbstractResponse
//帖子列表
@property (nonatomic, readonly, copy) NSArray *invitation;
@end

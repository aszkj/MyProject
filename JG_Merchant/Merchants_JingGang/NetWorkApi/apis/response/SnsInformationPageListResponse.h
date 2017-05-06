//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "InformationBO.h"

@interface SnsInformationPageListResponse :  AbstractResponse
//文章列表
@property (nonatomic, readonly, copy) NSArray *informations;
//总记录
@property (nonatomic, readonly, copy) NSNumber *totalCount;
@end

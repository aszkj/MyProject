//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "HumanBody.h"
#import "InformationClassBO.h"

@interface SnsInformationClassResponse :  AbstractResponse
//资讯分类列表
@property (nonatomic, readonly, copy) NSArray *informationClasses;
//男性部位列表
@property (nonatomic, readonly, copy) NSArray *boyList;
@end

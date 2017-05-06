//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "CheckReport.h"
#import "ResultGroup.h"
#import "ResultItem.h"
#import "ResultDetails.h"

@interface ReportResultDetailsSaveResponse :  AbstractResponse
//我的体检报告
@property (nonatomic, readonly, copy) NSArray *circle;
//总记录
@property (nonatomic, readonly, copy) NSNumber *totalCount;
//分类列表
@property (nonatomic, readonly, copy) NSArray *resultGroupBOs;
//常用体检项
@property (nonatomic, readonly, copy) NSArray *usingResultItemBOs;
//体检项目
@property (nonatomic, readonly, copy) NSArray *resultItemBOs;
//体检项信息
@property (nonatomic, readonly, copy) ResultItem *resultItem;
//添加体检报告
@property (nonatomic, readonly, copy) CheckReport *report;
//用户体检项信息
@property (nonatomic, readonly, copy) ResultDetails *userDetails;
@end

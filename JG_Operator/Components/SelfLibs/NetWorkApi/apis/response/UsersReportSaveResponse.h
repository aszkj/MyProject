//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "FoodClass.h"

@interface UsersReportSaveResponse :  AbstractResponse
//帖子id
@property (nonatomic, readonly, copy) NSNumber *apiId;
//是否点赞信息
@property (nonatomic, readonly, copy) NSNumber *isPraise;
//是否收藏信息
@property (nonatomic, readonly, copy) NSNumber *isFavorites;
//举报类型列表|以逗号隔开,
@property (nonatomic, readonly, copy) NSString *reportList;
//是否举报成功
@property (nonatomic, readonly, copy) NSNumber *flag;
//食物分类列表
@property (nonatomic, readonly, copy) NSArray *foodClassList;
@end

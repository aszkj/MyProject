//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "StoreSearch.h"
#import "FavaGroupGoods.h"
#import "RecommStoreInfo.h"
#import "GroupStoreFava.h"
#import "GroupService.h"
#import "GroupArea.h"
#import "GroupGoods.h"
#import "AwayStore.h"

@interface PersonalFavoritesListResponse :  AbstractResponse
//所有城市
@property (nonatomic, readonly, copy) NSArray *areaListBos;
//搜索商户
@property (nonatomic, readonly, copy) NSArray *searchStoreList;
//关键字搜索
@property (nonatomic, readonly, copy) NSArray *keyWordList;
//城市下面的区域
@property (nonatomic, readonly, copy) NSArray *areaList;
//是否评论成功
@property (nonatomic, readonly, copy) NSNumber *isEvaluation;
//评论页面
@property (nonatomic, readonly, copy) GroupService *service;
//收藏的商户
@property (nonatomic, readonly, copy) NSArray *favaStoreList;
//首页推荐
@property (nonatomic, readonly, copy) NSArray *recommStoreInfo;
//离我最近
@property (nonatomic, readonly, copy) NSArray *awayStoreList;
//猜你喜欢
@property (nonatomic, readonly, copy) NSArray *youLike;
//收藏服务列表
@property (nonatomic, readonly, copy) NSArray *favaList;
//服务热门搜索
@property (nonatomic, readonly, copy) NSArray *hotSearch;
@end

//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "ShopStore.h"
#import "Goods.h"
#import "GoodsCase.h"
#import "GoodsClass.h"

@interface LikeGoodsListResponse :  AbstractResponse
//商城首页橱窗列表
@property (nonatomic, readonly, copy) NSArray *goodsCaseList;
//商品列表
@property (nonatomic, readonly, copy) NSArray *goodsList;
//商品分类列表
@property (nonatomic, readonly, copy) NSArray *goodsClassList;
//猜你喜欢商品列表
@property (nonatomic, readonly, copy) NSArray *goodsLikeList;
//列表总记录数
@property (nonatomic, readonly, copy) NSNumber *totalSize;
//店铺信息
@property (nonatomic, readonly, copy) ShopStore *storeInfo;
//有你喜欢
@property (nonatomic, readonly, copy) NSArray *youLikelist;
@end

//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "FavaStore.h"
#import "EvaluatePage.h"
#import "Goods.h"
#import "OrderForfDetail.h"
#import "SelfOrder.h"

@interface SelfDetailResponse :  AbstractResponse
//用户订单列表
@property (nonatomic, readonly, copy) NSArray *orderList;
//订单详情
@property (nonatomic, readonly, copy) OrderForfDetail *selfOrder;
//我的评价列表
@property (nonatomic, readonly, copy) NSArray *selfEvaluate;
//我收藏的商品列表
@property (nonatomic, readonly, copy) NSArray *selfFavaGoodsList;
//我收藏的商铺列表
@property (nonatomic, readonly, copy) NSArray *selfStroeList;
@end

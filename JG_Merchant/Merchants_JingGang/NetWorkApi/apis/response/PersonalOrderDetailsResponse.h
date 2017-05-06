//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "PGroupGoods.h"
#import "PayPage.h"
#import "MyselfGroupOrderLine.h"
#import "POrderDetails.h"
#import "PGroup.h"
#import "MyselfGroupOrder.h"
#import "GroupArea.h"
#import "GroupGoods.h"

@interface PersonalOrderDetailsResponse :  AbstractResponse
//地区
@property (nonatomic, readonly, copy) GroupArea *areaBO;
//促销推荐
@property (nonatomic, readonly, copy) NSArray *groupGoodsBOs;
//热门城市
@property (nonatomic, readonly, copy) NSArray *hotCityList;
//店铺详情
@property (nonatomic, readonly, copy) PGroup *storeInfo;
//服务详情
@property (nonatomic, readonly, copy) GroupGoods *youLikeGoods;
//个人线上订单列表
@property (nonatomic, readonly, copy) NSArray *myselfOrderList;
//个人线下订单列表
@property (nonatomic, readonly, copy) NSArray *myselfOrderLineList;
//订单详情
@property (nonatomic, readonly, copy) POrderDetails *orderDetails;
//立即购买
@property (nonatomic, readonly, copy) PGroupGoods *groupGoods;
//支付页面
@property (nonatomic, readonly, copy) PayPage *payPage;
@end

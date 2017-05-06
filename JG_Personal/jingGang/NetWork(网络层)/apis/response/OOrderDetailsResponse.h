//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "GroupOrder.h"
#import "Merchant.h"
#import "GroupGoods.h"

@interface OOrderDetailsResponse :  AbstractResponse
//商户首页
@property (nonatomic, readonly, copy) Merchant *merchant;
//订单列表
@property (nonatomic, readonly, copy) NSArray *groupOrderList;
//订单详情
@property (nonatomic, readonly, copy) GroupOrder *groupOrderBO;
//服务列表
@property (nonatomic, readonly, copy) NSArray *groupGoodsBOs;
@end

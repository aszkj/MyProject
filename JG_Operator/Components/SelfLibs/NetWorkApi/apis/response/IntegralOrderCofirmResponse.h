//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "OrderBO.h"
#import "IntegralOrderDetails.h"
#import "OrderListBO.h"
#import "IntegralGoodsDetails.h"
#import "IntegralListBO.h"
#import "ComputeOrderBO.h"
#import "AddressListBO.h"

@interface IntegralOrderCofirmResponse :  AbstractResponse
//返回订单所需的积分与费用等相关信息
@property (nonatomic, readonly, copy) ComputeOrderBO *computeOrderBO;
//积分订单详情
@property (nonatomic, readonly, copy) OrderBO *orderBO;
//收货地址集合
@property (nonatomic, readonly, copy) NSArray *addressList;
//积分兑换订单集合
@property (nonatomic, readonly, copy) NSArray *orderList;
//积分兑换商品集合
@property (nonatomic, readonly, copy) NSArray *integralList;
//总记录数
@property (nonatomic, readonly, copy) NSNumber *totalCount;
//积分商品详情
@property (nonatomic, readonly, copy) IntegralGoodsDetails *integralDetails;
//立即兑换状态|0成功 1已过期  2等级不够  3积分不够  4库存不足  5超出限制兑换数  6未登录
@property (nonatomic, readonly, copy) NSNumber *exchangeStatus;
//订单详情
@property (nonatomic, readonly, copy) IntegralOrderDetails *details;
//商品库存列表
@property (nonatomic, readonly, copy) NSArray *integralGoodsList;
@end

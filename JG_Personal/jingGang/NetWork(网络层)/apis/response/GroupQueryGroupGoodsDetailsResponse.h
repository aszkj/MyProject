//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "StoreApplyInfo.h"
#import "StoreIndex.h"
#import "GroupClass.h"
#import "GroupOrder.h"
#import "StoreAlbum.h"
#import "Rebate.h"
#import "GroupEvaluates.h"
#import "UPrepositLog.h"
#import "GroupArea.h"
#import "GroupGoods.h"
#import "StoreCustomer.h"
#import "OrderDetails.h"

@interface GroupQueryGroupGoodsDetailsResponse :  AbstractResponse
//商户首页
@property (nonatomic, readonly, copy) StoreIndex *merchant;
//订单列表
@property (nonatomic, readonly, copy) NSArray *groupOrderList;
//订单详情
@property (nonatomic, readonly, copy) GroupOrder *groupOrderBO;
//服务列表
@property (nonatomic, readonly, copy) NSArray *groupGoodsBOs;
//服务详情
@property (nonatomic, readonly, copy) GroupGoods *groupGoodsDetails;
//商户申请
@property (nonatomic, readonly, copy) StoreApplyInfo *applyInfo;
//评论列表
@property (nonatomic, readonly, copy) NSArray *evaluateList;
//消费分润
@property (nonatomic, readonly, copy) Rebate *rebateBO;
//当年消费分润统计
@property (nonatomic, readonly, copy) NSArray *rebateList;
//线上线下收入总额
@property (nonatomic, readonly, copy) NSNumber *totalPrice;
//当年线上线下收入统计
@property (nonatomic, readonly, copy) NSArray *orderTotalPriceList;
//线上线下收入明细
@property (nonatomic, readonly, copy) NSArray *orderDetailsList;
//店铺会员列表
@property (nonatomic, readonly, copy) NSArray *storeCustomerList;
//商户环境相册
@property (nonatomic, readonly, copy) NSArray *storeAlbumList;
//tradeNo
@property (nonatomic, readonly, copy) NSString *tradeNo;
//提现记录
@property (nonatomic, readonly, copy) NSArray *preCashList;
//店铺主营类目
@property (nonatomic, readonly, copy) NSArray *groupClassList;
//areaBOs
@property (nonatomic, readonly, copy) NSArray *areaBOs;
@end

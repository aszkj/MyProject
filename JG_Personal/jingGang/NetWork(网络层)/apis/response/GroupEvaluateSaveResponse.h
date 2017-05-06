//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "StoreAlbum.h"
#import "UPrepositLog.h"
#import "StoreAppInfo.h"
#import "GroupArea.h"
#import "StoreCustomer.h"
#import "OrderDetails.h"
#import "StoreIndex.h"
#import "StoreApplyInfo.h"
#import "GroupOrder.h"
#import "GroupClass.h"
#import "Rebate.h"
#import "GroupEvaluates.h"
#import "GroupGoods.h"
#import "GoodsRefund.h"

@interface GroupEvaluateSaveResponse :  AbstractResponse
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
//线下收入月统计
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
//地区
@property (nonatomic, readonly, copy) NSArray *areaBOs;
//详细类目
@property (nonatomic, readonly, copy) NSArray *classDetails;
//评论总数
@property (nonatomic, readonly, copy) NSNumber *evaluateTotal;
//会员总数
@property (nonatomic, readonly, copy) NSNumber *customerTotal;
//线上服务退款列表
@property (nonatomic, readonly, copy) NSArray *refundBOs;
//订单状态|订单状态，0为订单取消，10为已提交待付款，20为已付款，30为买家已使用，全部使用后更新该值,50买家评价完毕 ,60卖家已评价,65订单不可评价
@property (nonatomic, readonly, copy) NSNumber *orderStatus;
//订单id
@property (nonatomic, readonly, copy) NSNumber *orderId;
//商户信息
@property (nonatomic, readonly, copy) StoreAppInfo *storeAppInfoBo;
//商家入驻
@property (nonatomic, readonly, copy) NSNumber *storeCheckIn;
@end

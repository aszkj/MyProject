//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "PayCartLineDetails.h"
#import "VoucherDetails.h"
#import "Member.h"
#import "ConsumeStatis.h"
#import "Voucher.h"
#import "OrderOnLine.h"

@interface OConsumeStatisListResponse :  AbstractResponse
//会员列表
@property (nonatomic, readonly, copy) NSArray *memberList;
//在线订单列表
@property (nonatomic, readonly, copy) NSArray *orderOnlineList;
//现金券列表
@property (nonatomic, readonly, copy) NSArray *voucherList;
//消费券详情
@property (nonatomic, readonly, copy) VoucherDetails *voucherDetails;
//消费分润统计
@property (nonatomic, readonly, copy) ConsumeStatis *consumeStatis;
//线下刷卡明细
@property (nonatomic, readonly, copy) NSArray *payCartLineList;
@end

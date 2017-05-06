//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "ReturnGoodsLog.h"

@interface ShopTradeReturnListResponse :  AbstractResponse
//主订单对象
@property (nonatomic, readonly, copy) NSArray *list;
//当前页
@property (nonatomic, readonly, copy) NSNumber *currentPage;
//总页数
@property (nonatomic, readonly, copy) NSNumber *totalPage;
//总记录数
@property (nonatomic, readonly, copy) NSNumber *totalRecord;
@end

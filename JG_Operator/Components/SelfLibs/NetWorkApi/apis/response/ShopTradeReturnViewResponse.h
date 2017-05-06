//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "ReturnGoodsLog.h"

@interface ShopTradeReturnViewResponse :  AbstractResponse
//退货信息
@property (nonatomic, readonly, copy) ReturnGoodsLog *returnGoodsLog;
@end

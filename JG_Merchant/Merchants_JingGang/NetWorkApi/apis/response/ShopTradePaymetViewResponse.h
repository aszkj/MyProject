//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "OrderForm.h"

@interface ShopTradePaymetViewResponse :  AbstractResponse
//主订单对象
@property (nonatomic, readonly, copy) OrderForm *order;
//订单总价
@property (nonatomic, readonly, copy) NSNumber *totalPrice;
@end

//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "ShopUserAddress.h"
#import "ShopGoodsCart.h"
#import "ShopOrderListDetail.h"

@interface DeleteAddressResponse :  AbstractResponse
//购物车列表
@property (nonatomic, readonly, copy) NSArray *cartList;
//购物车商品id
@property (nonatomic, readonly, copy) NSNumber *gcId;
//商品总价
@property (nonatomic, readonly, copy) NSNumber *totalPrice;
//订单列表
@property (nonatomic, readonly, copy) ShopOrderListDetail *orderList;
//用户所有收货地址列表
@property (nonatomic, readonly, copy) NSArray *userAddressAll;
@end

//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "Goods.h"

@interface ShopGoodsCart : MTLModel <MTLJSONSerializing>

	//购物车id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//商品小计
	@property (nonatomic, readonly, copy) NSNumber *subtotalPrice;
	//商铺名称
	@property (nonatomic, readonly, copy) NSString *storeSecondDomain;
	//商品规格
	@property (nonatomic, readonly, copy) NSString *specInfo;
	//商品列表
	@property (nonatomic, readonly, copy) Goods *goods;
	//数量
	@property (nonatomic, readonly, copy) NSNumber *count;
	//单价
	@property (nonatomic, readonly, copy) NSNumber *price;
	//是否选中了赠品 默认为0 未选择 1为已选择 
	@property (nonatomic, readonly, copy) NSNumber *whetherChooseGift;
	//兑换积分值，如果是0的话表示不设置积分兑购
	@property (nonatomic, readonly, copy) NSNumber *exchangeIntegral;
	//商品积分兑换后的价格，无兑换显示原价
	@property (nonatomic, readonly, copy) NSNumber *goodsIntegralPrice;
	//手机专享价，如果不设置手机专享价则留空
	@property (nonatomic, readonly, copy) NSNumber *goodsMobilePrice;
	//自营增加价格
	@property (nonatomic, readonly, copy) NSNumber *selfAddPrice;
	//所属店铺
	@property (nonatomic, readonly, copy) NSNumber *goodsStoreId;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	
@end

//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface ShopSearchGoods : MTLModel <MTLJSONSerializing>

	//商品id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//商品名称
	@property (nonatomic, readonly, copy) NSString *goodsName;
	//商品主图片
	@property (nonatomic, readonly, copy) NSString *goodsMainPhotoPath;
	//是否有积分兑换价格
	@property (nonatomic, readonly, copy) NSNumber *hasExchangeIntegral;
	//商品积分兑换后的价格，无兑换显示原价
	@property (nonatomic, readonly, copy) NSNumber *goodsIntegralPrice;
	//是否有手机专享价
	@property (nonatomic, readonly, copy) NSNumber *hasMobilePrice;
	//手机专享价，如果不设置手机专享价则留空
	@property (nonatomic, readonly, copy) NSNumber *goodsMobilePrice;
	//商品当前价格
	@property (nonatomic, readonly, copy) NSNumber *goodsCurrentPrice;
	//兑换积分值
	@property (nonatomic, readonly, copy) NSNumber *exchangeIntegral;
	//商品显示价格
	@property (nonatomic, readonly, copy) NSNumber *goodsShowPrice;
	//手机专享价
	@property (nonatomic, readonly, copy) NSNumber *mobilePrice;
	
@end

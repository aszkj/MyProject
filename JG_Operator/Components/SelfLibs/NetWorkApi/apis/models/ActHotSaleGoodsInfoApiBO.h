//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ActHotSaleGoodsInfoApiBO : MTLModel <MTLJSONSerializing>

	//商品id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//手机专享价
	@property (nonatomic, readonly, copy) NSNumber *goodsMobilePrice;
	//商品当前价格
	@property (nonatomic, readonly, copy) NSNumber *goodsCurrentPrice;
	//商品价格
	@property (nonatomic, readonly, copy) NSNumber *goodsPrice;
	//活动促销商品广告名称
	@property (nonatomic, readonly, copy) NSString *adTitle;
	//商品广告图片地址
	@property (nonatomic, readonly, copy) NSString *adImgPath;
	//热销商品的销量
	@property (nonatomic, readonly, copy) NSNumber *goodsSalenum;
	//热销商品的库存
	@property (nonatomic, readonly, copy) NSNumber *goodsInventory;
	
@end

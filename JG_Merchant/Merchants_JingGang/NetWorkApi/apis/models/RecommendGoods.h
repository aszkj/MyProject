//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface RecommendGoods : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSString *apiId;
	//主图片
	@property (nonatomic, readonly, copy) NSString *mainPhotoUrl;
	//图片
	@property (nonatomic, readonly, copy) NSString *photosUrl;
	//商品标题
	@property (nonatomic, readonly, copy) NSString *title;
	//content
	@property (nonatomic, readonly, copy) NSString *content;
	//type
	@property (nonatomic, readonly, copy) NSString *type;
	//goods_salenum
	@property (nonatomic, readonly, copy) NSNumber *goodsSalenum;
	//goods_collect
	@property (nonatomic, readonly, copy) NSNumber *goodsCollect;
	//well_evaluate
	@property (nonatomic, readonly, copy) NSNumber *wellEvaluate;
	//店铺价格
	@property (nonatomic, readonly, copy) NSNumber *storePrice;
	//goods_inventory
	@property (nonatomic, readonly, copy) NSNumber *goodsInventory;
	//商品类型
	@property (nonatomic, readonly, copy) NSString *goodsType;
	//goods_evas
	@property (nonatomic, readonly, copy) NSString *goodsEvas;
	//brandname图
	@property (nonatomic, readonly, copy) NSString *goodsBrandname;
	//goods_cod
	@property (nonatomic, readonly, copy) NSString *goodsCod;
	//goods_transfee
	@property (nonatomic, readonly, copy) NSString *goodsTransfee;
	//是否有手机价
	@property (nonatomic, readonly, copy) NSNumber *hasMobilePrice;
	//是否有积分价
	@property (nonatomic, readonly, copy) NSNumber *hasExchangeIntegral;
	//手机价
	@property (nonatomic, readonly, copy) NSNumber *mobilePrice;
	
@end

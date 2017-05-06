//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ShopLuceneResult : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//商品标题
	@property (nonatomic, readonly, copy) NSString *title;
	//商品主图片
	@property (nonatomic, readonly, copy) NSString *mainPhotoUrl;
	//商品小图片
	@property (nonatomic, readonly, copy) NSString *photosUrl;
	//店铺价格
	@property (nonatomic, readonly, copy) NSNumber *storePrice;
	//成本价
	@property (nonatomic, readonly, copy) NSNumber *costPrice;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeUsername;
	//是否有积分价
	@property (nonatomic, readonly, copy) NSNumber *hasExchangeIntegral;
	//是否有手机价
	@property (nonatomic, readonly, copy) NSNumber *hasMobilePrice;
	//手机专享价
	@property (nonatomic, readonly, copy) NSNumber *mobilePrice;
	
@end

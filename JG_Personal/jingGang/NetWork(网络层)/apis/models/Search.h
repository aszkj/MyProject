//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"
#import "ShopGoodsClass.h"
#import "ShopSearchGoods.h"
#import "ShopGoodsTypeProperty.h"

@interface Search : MTLModel <MTLJSONSerializing>

	//商品列表
	@property (nonatomic, readonly, copy) NSArray *searchGoodsList;
	//商品分类|品牌
	@property (nonatomic, readonly, copy) ShopGoodsClass *classBO;
	//商品属性
	@property (nonatomic, readonly, copy) NSArray *shopgoodsProperty;
	
@end

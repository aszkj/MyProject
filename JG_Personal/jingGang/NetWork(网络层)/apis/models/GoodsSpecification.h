//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"
#import "GoodsSpecProperty.h"

@interface GoodsSpecification : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//
	@property (nonatomic, readonly, copy) NSString *name;
	//规格类型，0为平台自营规格，1为商家规格，商家规格时需要有对应的店铺
	@property (nonatomic, readonly, copy) NSNumber *specType;
	//规格类型(文字或图片)
	@property (nonatomic, readonly, copy) NSString *type;
	//规格对应的主营商品分类,该分类为平台二级商品分类（level=1）
	@property (nonatomic, readonly, copy) NSNumber *goodsClassId;
	//当规格类型为商家规格时对应的店铺
	@property (nonatomic, readonly, copy) NSNumber *storeId;
	//商品规格属性1
	@property (nonatomic, readonly, copy) NSArray *specProperties;
	//商品规格属性
	@property (nonatomic, readonly, copy) NSArray *properties;
	
@end

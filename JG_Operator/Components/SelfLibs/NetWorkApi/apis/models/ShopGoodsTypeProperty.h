//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ShopGoodsTypeProperty : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//属性可见性
	@property (nonatomic, readonly, copy) NSNumber *display;
	//属性名称
	@property (nonatomic, readonly, copy) NSString *name;
	//sequence
	@property (nonatomic, readonly, copy) NSNumber *sequence;
	//商品类型
	@property (nonatomic, readonly, copy) NSNumber *goodsTypeId;
	//互斥属性值
	@property (nonatomic, readonly, copy) NSString *hcValue;
	//值
	@property (nonatomic, readonly, copy) NSString *value;
	
@end

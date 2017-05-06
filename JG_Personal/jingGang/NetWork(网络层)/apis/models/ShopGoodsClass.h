//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"
#import "ShopGoodsType.h"

@interface ShopGoodsClass : MTLModel <MTLJSONSerializing>

	//商品类型
	@property (nonatomic, readonly, copy) ShopGoodsType *goodsType;
	
@end

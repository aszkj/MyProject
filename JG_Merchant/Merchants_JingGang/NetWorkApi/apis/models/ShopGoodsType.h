//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "ShopGoodsBrand.h"

@interface ShopGoodsType : MTLModel <MTLJSONSerializing>

	//商品品牌
	@property (nonatomic, readonly, copy) NSArray *goodBrandList;
	
@end

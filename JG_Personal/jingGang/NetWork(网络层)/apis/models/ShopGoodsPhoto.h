//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"
#import "ShopAccessory.h"

@interface ShopGoodsPhoto : MTLModel <MTLJSONSerializing>

	//图片对象
	@property (nonatomic, readonly, copy) ShopAccessory *accessory;
	
@end

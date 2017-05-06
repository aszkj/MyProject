//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface ShopTransPort : MTLModel <MTLJSONSerializing>

	//运送方式名称
	@property (nonatomic, readonly, copy) NSString *key;
	//运送方式价格
	@property (nonatomic, readonly, copy) NSNumber *value;
	
@end

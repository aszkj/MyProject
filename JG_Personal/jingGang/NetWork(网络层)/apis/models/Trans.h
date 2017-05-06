//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"
#import "ShopTransPort.h"

@interface Trans : MTLModel <MTLJSONSerializing>

	//店铺id
	@property (nonatomic, readonly, copy) NSNumber *storeId;
	//运送方式
	@property (nonatomic, readonly, copy) NSArray *trans;
	
@end

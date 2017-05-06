//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface GoodsProperty : MTLModel <MTLJSONSerializing>

	//属性值
	@property (nonatomic, readonly, copy) NSString *val;
	//属性名称
	@property (nonatomic, readonly, copy) NSString *name;
	//属性id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	
@end

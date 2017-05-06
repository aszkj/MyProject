//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface FoodClass : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//食物名称
	@property (nonatomic, readonly, copy) NSString *name;
	//热量，单位为100克
	@property (nonatomic, readonly, copy) NSNumber *calories;
	
@end

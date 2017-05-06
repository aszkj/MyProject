//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface User : MTLModel <MTLJSONSerializing>

	//用户Id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//用户Id
	@property (nonatomic, readonly, copy) NSNumber *testId;
	
@end

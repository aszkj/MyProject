//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface CheckQuestion : MTLModel <MTLJSONSerializing>

	//帖子id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	
@end

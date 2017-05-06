//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface PhysicalTypeApiBO : MTLModel <MTLJSONSerializing>

	//类别简介
	@property (nonatomic, readonly, copy) NSString *profile;
	//详细内容
	@property (nonatomic, readonly, copy) NSString *memo;
	
@end

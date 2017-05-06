//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "Trans.h"

@interface SysTrans : MTLModel <MTLJSONSerializing>

	//运送方式
	@property (nonatomic, readonly, copy) NSArray *tanBos;
	
@end

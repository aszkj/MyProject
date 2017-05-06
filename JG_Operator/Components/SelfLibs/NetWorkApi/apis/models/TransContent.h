//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TransContent : MTLModel <MTLJSONSerializing>

	//快递处理时间
	@property (nonatomic, readonly, copy) NSString *time;
	//快递处理的详细信息
	@property (nonatomic, readonly, copy) NSString *context;
	
@end

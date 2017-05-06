//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface GoodsFCode : MTLModel <MTLJSONSerializing>

	//状态
	@property (nonatomic, readonly, copy) NSString *status;
	//code
	@property (nonatomic, readonly, copy) NSString *code;
	
@end

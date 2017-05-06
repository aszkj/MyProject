//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface GoodsType : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//name
	@property (nonatomic, readonly, copy) NSString *name;
	//sequence
	@property (nonatomic, readonly, copy) NSNumber *sequence;
	
@end

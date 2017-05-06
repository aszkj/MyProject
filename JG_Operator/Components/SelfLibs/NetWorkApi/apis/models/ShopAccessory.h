//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ShopAccessory : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//图片
	@property (nonatomic, readonly, copy) NSString *info;
	//图片名称
	@property (nonatomic, readonly, copy) NSString *name;
	//图片路径
	@property (nonatomic, readonly, copy) NSString *path;
	
@end

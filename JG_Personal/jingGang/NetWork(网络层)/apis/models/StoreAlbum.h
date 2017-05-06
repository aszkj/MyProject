//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface StoreAlbum : MTLModel <MTLJSONSerializing>

	//图片路径
	@property (nonatomic, readonly, copy) NSString *path;
	//图片名称
	@property (nonatomic, readonly, copy) NSString *name;
	
@end

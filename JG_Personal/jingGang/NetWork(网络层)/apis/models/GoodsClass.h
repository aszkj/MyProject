//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface GoodsClass : MTLModel <MTLJSONSerializing>

	//分类id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//分类名称
	@property (nonatomic, readonly, copy) NSString *className;
	//图标
	@property (nonatomic, readonly, copy) NSString *appIcon;
	//移动端上传图标
	@property (nonatomic, readonly, copy) NSString *mobileIcon;
	
@end

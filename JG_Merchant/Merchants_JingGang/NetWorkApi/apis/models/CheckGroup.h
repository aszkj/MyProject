//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CheckGroup : MTLModel <MTLJSONSerializing>

	//自测题套题Id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//缩略图
	@property (nonatomic, readonly, copy) NSString *thumbnail;
	//标题
	@property (nonatomic, readonly, copy) NSString *groupTitle;
	//概述
	@property (nonatomic, readonly, copy) NSString *summary;
	//内容
	@property (nonatomic, readonly, copy) NSString *content;
	
@end

//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface CheckGroup : MTLModel <MTLJSONSerializing>

	//自测题套题Id
	@property (nonatomic, copy) NSNumber *apiId;
	//缩略图
	@property (nonatomic, copy) NSString *thumbnail;
	//标题
	@property (nonatomic, copy) NSString *groupTitle;
	//概述
	@property (nonatomic, copy) NSString *summary;
	//内容
	@property (nonatomic, copy) NSString *content;
	
@end

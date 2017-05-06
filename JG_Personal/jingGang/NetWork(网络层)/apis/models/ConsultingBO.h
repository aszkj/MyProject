//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface ConsultingBO : MTLModel <MTLJSONSerializing>

	//提问id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//专家用户id
	@property (nonatomic, readonly, copy) NSNumber *expertsUserId;
	//提问用户id
	@property (nonatomic, readonly, copy) NSNumber *userId;
	//提问标题
	@property (nonatomic, readonly, copy) NSString *title;
	//提问图片
	@property (nonatomic, readonly, copy) NSString *images;
	//提问内容
	@property (nonatomic, readonly, copy) NSString *content;
	
@end

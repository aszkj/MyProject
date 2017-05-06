//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface InvitationClassBO : MTLModel <MTLJSONSerializing>

	//帖子分类id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//分类名称
	@property (nonatomic, readonly, copy) NSString *name;
	
@end

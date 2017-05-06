//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ResultGroup : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//体检分类
	@property (nonatomic, readonly, copy) NSString *groupName;
	//创建时间
	@property (nonatomic, readonly, copy) NSDate *createTime;
	
@end

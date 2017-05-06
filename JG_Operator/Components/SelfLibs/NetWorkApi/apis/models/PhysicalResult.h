//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PhysicalResult : MTLModel <MTLJSONSerializing>

	//用户id
	@property (nonatomic, readonly, copy) NSString *uid;
	//体检最小值|视力检查
	@property (nonatomic, readonly, copy) NSNumber *minValue;
	//体检最大值|如果只有一个值或者体检最大值|色盲测试
	@property (nonatomic, readonly, copy) NSNumber *maxValue;
	//体检时间
	@property (nonatomic, readonly, copy) NSString *time;
	//体检项目编号
	@property (nonatomic, readonly, copy) NSString *itemCode;
	//散光测试
	@property (nonatomic, readonly, copy) NSNumber *middleValue;
	
@end

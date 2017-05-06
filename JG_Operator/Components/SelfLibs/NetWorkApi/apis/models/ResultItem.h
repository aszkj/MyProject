//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ResultItem : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//体检项目名称
	@property (nonatomic, readonly, copy) NSString *itemName;
	//创建时间 
	@property (nonatomic, readonly, copy) NSDate *createTime;
	//分类id 
	@property (nonatomic, readonly, copy) NSNumber *groupId;
	//0数值型（录入）、1选项型（阴、阳值）
	@property (nonatomic, readonly, copy) NSNumber *type;
	//0常用、1取消常用
	@property (nonatomic, readonly, copy) NSNumber *usingItem;
	//参考最小值
	@property (nonatomic, readonly, copy) NSString *minValue;
	//参考最大值
	@property (nonatomic, readonly, copy) NSString *maxValue;
	//单位 
	@property (nonatomic, readonly, copy) NSString *unit;
	//阴阳参考值0阴1阳 
	@property (nonatomic, readonly, copy) NSNumber *referenceValue;
	//参考值
	@property (nonatomic, readonly, copy) NSString *value;
	
@end

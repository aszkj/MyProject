//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ResultDetails : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//体检项目
	@property (nonatomic, readonly, copy) NSString *physicalName;
	//最小值
	@property (nonatomic, readonly, copy) NSString *minVale;
	//最大值
	@property (nonatomic, readonly, copy) NSString *maxValue;
	//实际值 
	@property (nonatomic, readonly, copy) NSString *referenceValue;
	//阴阳参考值0阴1阳阳性
	@property (nonatomic, readonly, copy) NSString *positive;
	//单位
	@property (nonatomic, readonly, copy) NSString *unit;
	//结果|0正常、1超标
	@property (nonatomic, readonly, copy) NSString *result;
	//结果|输入型参考值
	@property (nonatomic, readonly, copy) NSString *value;
	//结果|0数值型（录入）、1选项型（阴、阳值）
	@property (nonatomic, readonly, copy) NSNumber *type;
	
@end

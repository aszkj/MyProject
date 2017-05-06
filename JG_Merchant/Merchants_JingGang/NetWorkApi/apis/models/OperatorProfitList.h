//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface OperatorProfitList : MTLModel <MTLJSONSerializing>

	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//返润金额
	@property (nonatomic, readonly, copy) NSNumber *rebateAmount;
	//返利类型
	@property (nonatomic, readonly, copy) NSString *rebateType;
	//创建时间
	@property (nonatomic, readonly, copy) NSDate *createTime;
	//收益类型名称
	@property (nonatomic, readonly, copy) NSString *rebateTypeName;
	
@end

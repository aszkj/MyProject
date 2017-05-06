//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface OperatorManagement : MTLModel <MTLJSONSerializing>

	//店铺名称 
	@property (nonatomic, readonly, copy) NSString *storeName;
	//店铺电话号码 
	@property (nonatomic, readonly, copy) NSString *storeTelephone;
	//商户返润 
	@property (nonatomic, readonly, copy) NSNumber *rebateConsumeAmount;
	//手续费返润 
	@property (nonatomic, readonly, copy) NSNumber *rebateFeeAmount;
	//返润总额
	@property (nonatomic, readonly, copy) NSNumber *rebateTotal;
	//交易总额
	@property (nonatomic, readonly, copy) NSNumber *tradingTotal;
	//商户id
	@property (nonatomic, readonly, copy) NSNumber *storeId;
	
@end

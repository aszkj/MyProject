//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface OperatorBank : MTLModel <MTLJSONSerializing>

	//银行
	@property (nonatomic, readonly, copy) NSString *bankName;
	//支行
	@property (nonatomic, readonly, copy) NSString *subBankName;
	//卡号
	@property (nonatomic, readonly, copy) NSString *bankNo;
	//姓名
	@property (nonatomic, readonly, copy) NSString *userName;
	
@end

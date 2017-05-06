//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface StoreBank : MTLModel <MTLJSONSerializing>

	//银行开户名
	@property (nonatomic, readonly, copy) NSString *bankAccountName;
	//公司银行账号
	@property (nonatomic, readonly, copy) NSString *bankCAccount;
	//开户行支行名称 
	@property (nonatomic, readonly, copy) NSString *bankName;
	
@end

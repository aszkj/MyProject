//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface AlipayPaymet : MTLModel <MTLJSONSerializing>

	//安全验证号
	@property (nonatomic, readonly, copy) NSString *safeKey;
	//支付宝账号
	@property (nonatomic, readonly, copy) NSString *sellerEmail;
	//合作者身份Id
	@property (nonatomic, readonly, copy) NSString *partner;
	//私钥
	@property (nonatomic, readonly, copy) NSString *appPrivateKey;
	//公钥
	@property (nonatomic, readonly, copy) NSString *appPublicKey;
	
@end

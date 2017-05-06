//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface WeiXinPaymet : MTLModel <MTLJSONSerializing>

	//公众账号ID
	@property (nonatomic, readonly, copy) NSString *appid;
	//随机字符串
	@property (nonatomic, readonly, copy) NSString *noncestr;
	//扩展字段
	@property (nonatomic, readonly, copy) NSString *package1;
	//商户号
	@property (nonatomic, readonly, copy) NSString *partnerid;
	//预支付交易会话ID
	@property (nonatomic, readonly, copy) NSString *prepayid;
	//时间戳
	@property (nonatomic, readonly, copy) NSString *timestamp;
	//微信支付paysignkey
	@property (nonatomic, readonly, copy) NSString *sign;
	
@end

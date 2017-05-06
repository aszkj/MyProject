//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ApplyInfo : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//店铺状态|商户审核进度|0商户提交入住申请,61运营商审核，62云E生平台审核，63第三方支付公司审核，15入驻成功
	@property (nonatomic, readonly, copy) NSNumber *storeStatus;
	//是否安装刷卡机
	@property (nonatomic, readonly, copy) NSNumber *isEepay;
	//商户申请失败原因
	@property (nonatomic, readonly, copy) NSString *failReseaon;
	
@end

//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface StoreApplyInfo : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//店铺状态，0为提交开店申请，1运营商审批,2运营商审批失败 5平台审核,6平台审核失败,10第三方支付审核,11第三方支付审批失败,15为正常营业（审核成功）,20违规关闭 , 25到期关闭,26,到期后申请续费'
	@property (nonatomic, readonly, copy) NSNumber *storeStatus;
	//是否安装刷卡机
	@property (nonatomic, readonly, copy) NSNumber *isEepay;
	//商户申请失败原因
	@property (nonatomic, readonly, copy) NSString *failReseaon;
	
@end

//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface StoreIndex : MTLModel <MTLJSONSerializing>

	//商户id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//邀请码
	@property (nonatomic, readonly, copy) NSString *invitationCode;
	//销售总额
	@property (nonatomic, readonly, copy) NSNumber *totalPayAmount;
	//劵收益总额
	@property (nonatomic, readonly, copy) NSNumber *couponPayAmount;
	//刷卡收益售额
	@property (nonatomic, readonly, copy) NSNumber *chargePayAmount;
	//返润总额
	@property (nonatomic, readonly, copy) NSNumber *rebateAmount;
	//收益总额
	@property (nonatomic, readonly, copy) NSNumber *profitAmount;
	//商户binner
	@property (nonatomic, readonly, copy) NSString *storeBannerPath;
	//店铺logo
	@property (nonatomic, readonly, copy) NSString *storeLogoPath;
	//商户封面
	@property (nonatomic, readonly, copy) NSString *coverPath;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//图片总数
	@property (nonatomic, readonly, copy) NSNumber *totalPhoto;
	//店铺电话号码
	@property (nonatomic, readonly, copy) NSString *storeTelephone;
	//地区
	@property (nonatomic, readonly, copy) NSString *area;
	//店铺详细地址
	@property (nonatomic, readonly, copy) NSString *storeAddress;
	//店铺类型
	@property (nonatomic, readonly, copy) NSNumber *isO2o;
	
@end

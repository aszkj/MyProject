//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface Merchant : MTLModel <MTLJSONSerializing>

	//商户id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//所属行业
	@property (nonatomic, readonly, copy) NSString *industry;
	//经营范围
	@property (nonatomic, readonly, copy) NSString *licenseBusinessScope;
	//店铺详细地址
	@property (nonatomic, readonly, copy) NSString *storeAddress;
	//店铺电话号码
	@property (nonatomic, readonly, copy) NSString *storeTelephone;
	//店铺手机号
	@property (nonatomic, readonly, copy) NSString *licenseCMobile;
	//所属身份和编号
	@property (nonatomic, readonly, copy) NSString *storeOwerCard;
	//返润比例
	@property (nonatomic, readonly, copy) NSNumber *commissionRebate;
	//结算账户名
	@property (nonatomic, readonly, copy) NSString *bankAccountName;
	//结算账户
	@property (nonatomic, readonly, copy) NSString *bankCAccount;
	//开户行
	@property (nonatomic, readonly, copy) NSString *bankName;
	//法人身份正面照
	@property (nonatomic, readonly, copy) NSString *licenseLegalIdCardFrontPath;
	//法人身份反面照 
	@property (nonatomic, readonly, copy) NSString *licenseLegalIdCardBackPath;
	//经营场所证明
	@property (nonatomic, readonly, copy) NSString *businessPlacePhotoPath;
	//其他证明
	@property (nonatomic, readonly, copy) NSString *otherPhotoPath;
	//邀请码
	@property (nonatomic, readonly, copy) NSString *invitationCode;
	//劵销售总额
	@property (nonatomic, readonly, copy) NSNumber *couponPayAmount;
	//刷卡销售额
	@property (nonatomic, readonly, copy) NSNumber *chargePayAmount;
	//消费返润总额
	@property (nonatomic, readonly, copy) NSNumber *rebateAmount;
	//商户图片
	@property (nonatomic, readonly, copy) NSString *storeBannerPath;
	//店铺logo
	@property (nonatomic, readonly, copy) NSString *storeLogoPath;
	
@end

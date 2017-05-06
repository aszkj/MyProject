//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface StoreAppInfo : MTLModel <MTLJSONSerializing>

	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//主营类目
	@property (nonatomic, readonly, copy) NSString *category;
	//所属行业
	@property (nonatomic, readonly, copy) NSString *industry;
	//经营范围
	@property (nonatomic, readonly, copy) NSString *licenseBusinessScope;
	//公司简介
	@property (nonatomic, readonly, copy) NSString *licenseCDesc;
	//服务详细类目 |以逗号隔开|青菜,个、黄瓜.....
	@property (nonatomic, readonly, copy) NSString *groupDetailInfo;
	//详细类目|名称
	@property (nonatomic, readonly, copy) NSString *detailsInfos;
	//店铺详细地址
	@property (nonatomic, readonly, copy) NSString *storeAddress;
	//店铺电话号码
	@property (nonatomic, readonly, copy) NSString *storeTelephone;
	//公司紧急联系人手机
	@property (nonatomic, readonly, copy) NSString *licenseCMobile;
	//法人身份证号
	@property (nonatomic, readonly, copy) NSString *licenseLegalIdCard;
	//返润比例
	@property (nonatomic, readonly, copy) NSNumber *commissionRebate;
	//银行开户名
	@property (nonatomic, readonly, copy) NSString *bankAccountName;
	//公司银行账号 
	@property (nonatomic, readonly, copy) NSString *bankCAccount;
	//开户行支行名称
	@property (nonatomic, readonly, copy) NSString *bankName;
	//是否安装刷卡机
	@property (nonatomic, readonly, copy) NSNumber *isEepay;
	//法人身份正面照
	@property (nonatomic, readonly, copy) NSString *licenseLegalIdCardFrontPath;
	//法人身份反面照
	@property (nonatomic, readonly, copy) NSString *licenseLegalIdCardBackPath;
	//经营场所证明
	@property (nonatomic, readonly, copy) NSString *businessPlacePhotoPath;
	//其他证明
	@property (nonatomic, readonly, copy) NSString *otherPhotoPath;
	//法人身份证手拿照
	@property (nonatomic, readonly, copy) NSString *licenseLegalIdCardReachPath;
	//银行卡正面照
	@property (nonatomic, readonly, copy) NSString *bankCardFrontPath;
	//银行卡反面照 
	@property (nonatomic, readonly, copy) NSString *bankCardBackPath;
	//营业执照副本电子版
	@property (nonatomic, readonly, copy) NSString *licenseImagePath;
	//运营商编号
	@property (nonatomic, readonly, copy) NSString *operateNumber;
	//经度
	@property (nonatomic, readonly, copy) NSNumber *storeLat;
	//纬度
	@property (nonatomic, readonly, copy) NSNumber *storeLon;
	//商户所在地
	@property (nonatomic, readonly, copy) NSString *area;
	//店铺id
	@property (nonatomic, readonly, copy) NSNumber *storeId;
	//地区id,第三级
	@property (nonatomic, readonly, copy) NSNumber *areaId;
	//主营类目
	@property (nonatomic, readonly, copy) NSNumber *groupMainId;
	//所属编号
	@property (nonatomic, readonly, copy) NSString *inviterNumber;
	//折扣
	@property (nonatomic, readonly, copy) NSNumber *groupDiscount;
	//开户行所在地id
	@property (nonatomic, readonly, copy) NSNumber *bankAreaId;
	//开户行所在地名称
	@property (nonatomic, readonly, copy) NSString *bankAreaName;
	//身份证号码
	@property (nonatomic, readonly, copy) NSString *cartCode;
	//营业执照上公司名称
	@property (nonatomic, readonly, copy) NSString *licensecName;
	
@end

//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GroupCheckInSaveResponse.h"

@interface GroupCheckInSaveRequest : AbstractRequest
/** 
 * 店铺名称
 */
@property (nonatomic, readwrite, copy) NSString *api_storeName;
/** 
 * 所属行业
 */
@property (nonatomic, readwrite, copy) NSString *api_industry;
/** 
 * 经营范围 
 */
@property (nonatomic, readwrite, copy) NSString *api_licenseBusinessScope;
/** 
 * 公司简介 
 */
@property (nonatomic, readwrite, copy) NSString *api_licenseCDesc;
/** 
 * 主营类目
 */
@property (nonatomic, readwrite, copy) NSNumber *api_gcMainId;
/** 
 * 服务详细类目|以逗号隔开|青菜,个、黄瓜.....
 */
@property (nonatomic, readwrite, copy) NSString *api_groupDetailInfo;
/** 
 * 店铺地址，这里保存的是最底层地址
 */
@property (nonatomic, readwrite, copy) NSNumber *api_areaId;
/** 
 * 店铺详细地址
 */
@property (nonatomic, readwrite, copy) NSString *api_storeAddress;
/** 
 * 店铺电话号码
 */
@property (nonatomic, readwrite, copy) NSString *api_storeTelephone;
/** 
 * 公司紧急联系人手机
 */
@property (nonatomic, readwrite, copy) NSString *api_licenseCMobile;
/** 
 * 返润比例
 */
@property (nonatomic, readwrite, copy) NSNumber *api_commissionRebate;
/** 
 * 银行开户名
 */
@property (nonatomic, readwrite, copy) NSString *api_bankAccountName;
/** 
 * 公司银行账号
 */
@property (nonatomic, readwrite, copy) NSString *api_bankCAccount;
/** 
 * 开户行支行名称
 */
@property (nonatomic, readwrite, copy) NSString *api_bankName;
/** 
 * 是否安装刷卡机
 */
@property (nonatomic, readwrite, copy) NSNumber *api_isEepay;
/** 
 * 法人身份正面照
 */
@property (nonatomic, readwrite, copy) NSString *api_licenseLegalIdCardFrontPath;
/** 
 * 法人身份反面照
 */
@property (nonatomic, readwrite, copy) NSString *api_licenseLegalIdCardBackPath;
/** 
 * 经营场所证明
 */
@property (nonatomic, readwrite, copy) NSString *api_businessPlacePhotoPath;
/** 
 * 其他证明
 */
@property (nonatomic, readwrite, copy) NSString *api_otherPhotoPath;
/** 
 * 法人身份证手拿照
 */
@property (nonatomic, readwrite, copy) NSString *api_licenseLegalIdCardReachPath;
/** 
 * 银行卡正面照
 */
@property (nonatomic, readwrite, copy) NSString *api_bankCardFrontPath;
/** 
 * 银行卡反面照 
 */
@property (nonatomic, readwrite, copy) NSString *api_bankCardBackPath;
/** 
 * 营业执照
 */
@property (nonatomic, readwrite, copy) NSString *api_licenseImagePath;
/** 
 * 运营商编号
 */
@property (nonatomic, readwrite, copy) NSString *api_operateNumber;
/** 
 * 经度
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeLat;
/** 
 * 纬度 
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeLon;
/** 
 * 服务折扣
 */
@property (nonatomic, readwrite, copy) NSNumber *api_groupDiscount;
/** 
 * 身份证号码
 */
@property (nonatomic, readwrite, copy) NSString *api_cardCode;
/** 
 * bankAreaId
 */
@property (nonatomic, readwrite, copy) NSNumber *api_bankAreaId;
/** 
 * 商户全称
 */
@property (nonatomic, readwrite, copy) NSString *api_licenseCName;
@end

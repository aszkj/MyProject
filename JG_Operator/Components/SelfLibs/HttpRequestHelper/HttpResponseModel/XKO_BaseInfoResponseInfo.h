//
//  XKO_BaseInfoResponseInfo.h
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_BaseHttpResponseModel.h"

@interface XKO_BaseInfoResponseInfo : XKO_BaseHttpResponseModel

//id
@property (nonatomic, readonly, copy) NSNumber *apiId;
//姓名
@property (nonatomic, readonly, copy) NSString *userName;
//性别：1男，2女
@property (nonatomic, readonly, copy) NSString *sex;
//手机
@property (nonatomic, readonly, copy) NSString *phone;
//联系地址
@property (nonatomic, readonly, copy) NSString *address;
//身份证号
@property (nonatomic, readonly, copy) NSString *idCard;
//民族
@property (nonatomic, readonly, copy) NSString *nation;
//运营商级别：1市，2区，3区域
@property (nonatomic, readonly, copy) NSString *level;
//营运商地区
@property (nonatomic, readonly, copy) NSString *area;
//营运商地区
@property (nonatomic, readonly, copy) NSString *operatorAreaId;
//营运商名称
@property (nonatomic, readonly, copy) NSString *operatorName;
//推荐人
@property (nonatomic, readonly, copy) NSString *refereeName;
//开户行
@property (nonatomic, readonly, copy) NSString *bankName;
//支行
@property (nonatomic, readonly, copy) NSString *subBankName;
//帐号
@property (nonatomic, readonly, copy) NSString *bankNo;
//组织机构代码
@property (nonatomic, readonly, copy) NSString *organizationNo;
//组织机构代码证图片
@property (nonatomic, readonly, copy) NSString *organizationPath;
//营业执照图片
@property (nonatomic, readonly, copy) NSString *registrationPath;
//税务登记证图片地址
@property (nonatomic, readonly, copy) NSString *taxPath;
//营业执照号
@property (nonatomic, readonly, copy) NSString *registrationNo;
//税务登记证号
@property (nonatomic, readonly, copy) NSString *taxNo;
//运营商编码
@property (nonatomic, readonly, copy) NSString *operatorCode;
//邀请码
@property (nonatomic, readonly, copy) NSString *invitationCode;


@end

//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "UserSign.h"
#import "UserCustomer.h"
#import "OpNotices.h"
#import "OperatorBank.h"
#import "ArticleBO.h"
#import "UserDocument.h"
#import "StoreBank.h"
#import "Relation.h"
#import "UserIntegral.h"

@interface UsersIntegralGetByUidResponse :  AbstractResponse
//用户信息 
@property (nonatomic, readonly, copy) UserCustomer *customer;
//用户积分信息
@property (nonatomic, readonly, copy) UserIntegral *integral;
//用户云币
@property (nonatomic, readonly, copy) NSNumber *availableBalance;
//用户财富
@property (nonatomic, readonly, copy) NSNumber *balance;
//商户银行信息
@property (nonatomic, readonly, copy) StoreBank *storeBankInfo;
//商营运商银行信息
@property (nonatomic, readonly, copy) OperatorBank *operatorBankInfo;
//用户签到对象
@property (nonatomic, readonly, copy) UserSign *userSign;
//第三方平台是否绑定平台帐号
@property (nonatomic, readonly, copy) NSString *bindingMobile;
//第三方平台是否绑定标志
@property (nonatomic, readonly, copy) NSNumber *isBinding;
//第三方平台是否绑定平台id
@property (nonatomic, readonly, copy) NSString *bindingOpenId;
//系统帮助
@property (nonatomic, readonly, copy) UserDocument *documet;
//平台发给商户公告
@property (nonatomic, readonly, copy) NSArray *articleList;
//营运发给商户公告
@property (nonatomic, readonly, copy) NSArray *opNoticesBOs;
//营运商公告和商户平台公告明细
@property (nonatomic, readonly, copy) ArticleBO *articleBO;
//营运商发给商户的公告明细
@property (nonatomic, readonly, copy) OpNotices *noticesBO;
//文章列表
@property (nonatomic, readonly, copy) NSArray *articMarkleList;
//公告详情
@property (nonatomic, readonly, copy) ArticleBO *articMarkleDetails;
//邀请人明细
@property (nonatomic, readonly, copy) NSArray *ralationList;
//邀请人总数
@property (nonatomic, readonly, copy) NSNumber *relationCount;
//是否设置了云币密码
@property (nonatomic, readonly, copy) NSNumber *isCloudPassword;
//手机号码
@property (nonatomic, readonly, copy) NSString *mobile;
@end

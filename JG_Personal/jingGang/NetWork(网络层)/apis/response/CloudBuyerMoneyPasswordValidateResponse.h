//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "CloudForm.h"

@interface CloudBuyerMoneyPasswordValidateResponse :  AbstractResponse
//提现对象
@property (nonatomic, readonly, copy) CloudForm *cloudPredepositCash;
//登陆帐号
@property (nonatomic, readonly, copy) NSString *loginName;
//云币验证
@property (nonatomic, readonly, copy) NSNumber *ret;
@end

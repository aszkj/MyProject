//
//  ThirdPaltFormLoginHelper.h
//  jingGang
//
//  Created by 张康健 on 15/10/22.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#define NotPlatUser @"NotPlatUser"
typedef void(^Sucess)(NSDictionary *sucessDic);
typedef void(^Failed)(NSString *failedStr);

@interface ThirdPaltFormLoginHelper : NSObject

//发送验证码之前验证手机号码
-(NSString *)veryfyPhoneNumberBeforeSendVeryCode:(NSString *)phoneNumber;

-(NSString *)tieThirdInfoInputVeryFyForPhoneNumber:(NSString *)phoneNumber veryCode:(NSString *)veryCode;

//发送验证码请求
-(void)requestVeryCodeForTieThirdPlatformfailed:(Failed)failed success:(Sucess)success;


@property (nonatomic, strong)UIButton *veryfyButton;


//登录名
@property (nonatomic, copy)NSString *loginName;


//手机号码,外部提供的
@property (nonatomic, copy)NSString *outPhoneNumber;

//第三方平台ID
@property (nonatomic, copy)NSString *thirdPlatFormId;

//unionId
@property (copy , nonatomic) NSString *unionId;


//第三方平台类型number
@property (nonatomic, strong)NSNumber *thirdPlatFormNumber;

@property (nonatomic, strong)NSString *thirdPlatToken;


@property (nonatomic, strong)MBProgressHUD *hub;



//补全信息输入验证，返回错误信息，如果错误信息为nil，说明输入验证成功
- (NSString *)repareInfoMationForNickName:(NSString *)nickName passwd:(NSString *)passwd againPasswd:(NSString *)againPasswd invitationCode:(NSString *)invitationCode;


#pragma mark - 开始登录操作
- (void)beginLoginWithSuccess:(Sucess)sucess failed:(Failed)failed;


#pragma mark - 绑定第三方平台
-(void)tieThirdPlatFormSuccess:(Sucess)sucess failed:(Failed)failed;


#pragma mark - 补全信息
-(void)repareiInfoSuccess:(Sucess)sucess failed:(Failed)failed;


@end

//
//  LoginRegisterHelper.h
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^Sucess)(NSString *sucessToken);
typedef void(^Failed)(NSString *failedStr);
typedef void(^VerycodeSecondsBlock)(NSInteger veryCodeSeconds);

@interface LoginRegisterHelper : NSObject

//登录输入验证,返回错误信息，如果错误信息为nil，说明输入验证成功
- (NSString *)loginInputVeriryForUserName:(NSString *)phoneNum passwd:(NSString *)passwd;

//注册输入验证，返回错误信息，如果错误信息为nil，说明输入验证成功
- (NSString *)registerInputVeriryForNickName:(NSString *)nickName UserName:(NSString *)phoneNum passwd:(NSString *)passwd againPasswd:(NSString *)againPasswd veryCode:(NSString *)veryCode;

//注册验证注册邀请码,这是后来加的，，本身应该放在上面方法参数里，，后来改发现改动太大
-(NSString *)regisertVeryfyInputInvitationCode:(NSString *)invitationCode;


//找回密码输入验证，返回错误信息，如果错误信息为nil，说明输入验证成功
- (NSString *)findPasswdInputVeriryForUserName:(NSString *)phoneNum passwd:(NSString *)passwd againPasswd:(NSString *)againPasswd  veryCode:(NSString *)veryCode;

//开始登录操作
- (void)beginLoginWithSuccess:(Sucess)sucess failed:(Failed)failed;


//开始注册
- (void)beginRegisterWithSuccess:(Sucess)sucess failed:(Failed)failed;

//找回密码
- (void)beginFindPasswdWithSuccess:(Sucess)sucess failed:(Failed)failed;

//发送验证码之前验证手机号码
-(NSString *)veryfyPhoneNumberBeforeSendVeryCode:(NSString *)phoneNumber;

//发送验证码请求
-(void)requestVeryCodeForRegister:(BOOL)isForRegister failed:(Failed)failed success:(Sucess)success;

//重置验证码
-(void)resetVeryCode;

//注册邀请码
@property (nonatomic, copy)NSString *invitationCode;


@property (nonatomic, strong)UIButton *veryfyButton;

//获取验证码时剩余时间
@property (nonatomic, assign)NSInteger veryCodeSeconds;

@property (nonatomic, copy)VerycodeSecondsBlock verycodeSecondsBlock;



@end

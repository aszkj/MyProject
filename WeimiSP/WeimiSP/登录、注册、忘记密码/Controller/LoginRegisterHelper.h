//
//  LoginRegisterHelper.h
//  weimi
//
//  Created by 张康健 on 16/1/18.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface LoginRegisterHelper : NSObject

typedef void(^Sucess)(NSString *sucessToken);
typedef void(^Failed)(NSString *failedStr);
typedef void(^VerycodeSecondsBlock)(NSInteger veryCodeSeconds);

@property (nonatomic, strong)RACSignal *loginButtonEabledSignal;
@property (nonatomic, strong)RACSignal *registerForgetPasswdButtonEabledSignal;
@property (nonatomic, strong)RACSignal *registerSecondButtonEabledSignal;


//开始登录操作
- (void)beginLoginWithAccoutName:(NSString *)accountName
                          passwd:(NSString *)passwd
                         success:(Sucess)sucess
                          failed:(Failed)failed;

//开始注册操作
- (void)beginRisterWithNickName:(NSString *)nickName
                    phoneNumber:(NSString *)phoneNumber
                       veryCode:(NSString *)veryCode
                          passwd:(NSString *)passwd
                         success:(Sucess)sucess
                          failed:(Failed)failed;

//忘记密码
- (void)beginForgetPasswdWithphoneNumber:(NSString *)phoneNumber
                       veryCode:(NSString *)veryCode
                         passwd:(NSString *)passwd
                        success:(Sucess)sucess
                         failed:(Failed)failed;

//注册输入验证
- (NSString *)registerInputVaryFy:(NSString *)nickName phoneNum:(NSString *)phoneNumber veryCode:(NSString *)veryCode passwd:(NSString *)passwd againPasswd:(NSString *)againPasswd;

//忘记密码输入验证
- (NSString *)forgetPasswdInputVaryFyphoneNum:(NSString *)phoneNumber veryCode:(NSString *)veryCode passwd:(NSString *)passwd againPasswd:(NSString *)againPasswd;

//验证手机号
-(NSString *)veryFyPhoneNumber:(NSString *)phoneNum;

//发送验证码请求
-(void)requestVeryCodeForRegister:(BOOL)isForRegister failed:(Failed)failed success:(Sucess)success;
@property (nonatomic, strong)UIButton *veryfyButton;

//获取验证码时剩余时间
@property (nonatomic, assign)NSInteger veryCodeSeconds;

@property (nonatomic, copy)VerycodeSecondsBlock verycodeSecondsBlock;

#pragma mark - 1.3版修改的-------------------------注册输入验证
//注册第一步输入验证手机号、验证码
-(NSString *)regisiterFirstStepVaryfyPhoneNumber:(NSString *)phoneNumber veryCode:(NSString *)veryCode;

//注册第二步输入验证昵称、密码、再次输入密码
-(NSString *)registerSecondStepVaryfyNickName:(NSString *)nickName passwd:(NSString *)passwd againPasswd:(NSString *)againPasswd;




@end

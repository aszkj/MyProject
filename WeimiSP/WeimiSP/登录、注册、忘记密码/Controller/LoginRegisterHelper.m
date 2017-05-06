//
//  LoginRegisterHelper.m
//  weimi
//
//  Created by 张康健 on 16/1/18.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "LoginRegisterHelper.h"
#import "WEMEUsercontrollerApi.h"
#import "AppDelegate.h"

@interface LoginRegisterHelper(){

    NSString *_phoneNumber;
    NSString *_userName;
    NSString *_userPasswd;
    
    NSTimer  *_getVeryCodeTimer;
    
}

//发送验证码请求失败回调
@property (nonatomic, copy)Failed sendVeryCodeFailedBlock;
//发送验证码成功回调
@property (nonatomic, copy)Sucess sendVeryCodeSuccessBlock;


@end

@implementation LoginRegisterHelper

#pragma mark - 开始登录操作
- (void)beginLoginWithAccoutName:(NSString *)accountName
                          passwd:(NSString *)passwd
                         success:(Sucess)sucess
                          failed:(Failed)failed
{
    NSURL *baseURL = [NSURL URLWithString:authUrl];
    AFOAuth2Manager *OAuth2Manager =
    [[AFOAuth2Manager alloc] initWithBaseURL:baseURL
                                    clientID:KClientID
                                      secret:KSecret];
    [OAuth2Manager authenticateUsingOAuthWithURLString:@"/oauth/token" username:accountName password:passwd scope:@"" success:^(AFOAuthCredential *credential) {
        
        NSLog(@"登录成功获取Token: %@", credential.accessToken);
        
        if (!IsEmpty(credential.accessToken)) {

            WEMEConfiguration *config = [WEMEConfiguration sharedConfig];
            config.credential = credential;
            if (credential.accessToken) {
                sucess(credential.accessToken);
                [kUserDefaults setObject:credential.accessToken forKey:Token];
                [kUserDefaults synchronize];
            }
        }

    } failure:^(NSError *error) {
        [NSError errorStrWithError:error];
        failed(error.localizedDescription);
        
    }];
}

#pragma mark - 开始注册操作
- (void)beginRisterWithNickName:(NSString *)nickName
                    phoneNumber:(NSString *)phoneNumber
                       veryCode:(NSString *)veryCode
                         passwd:(NSString *)passwd
                        success:(Sucess)sucess
                         failed:(Failed)failed
{
    [[WEMEUsercontrollerApi sharedAPI] regsiterUsingPOSTWithCompletionBlock:phoneNumber password:passwd nickname:nickName idcode:veryCode completionHandler:^(WEMESimpleResponse *output, NSError *error) {
        if (output.success.integerValue == 1 && !output.error) {
            NSLog(@"注册成功");
            sucess(@"");
        }else {
            if (output.error) {
                failed(output.errorDescription);
            }
            if (error) {
                failed(error.localizedDescription);
            }
        }
    }];
}


#pragma mark - 忘记密码
- (void)beginForgetPasswdWithphoneNumber:(NSString *)phoneNumber
                                veryCode:(NSString *)veryCode
                                  passwd:(NSString *)passwd
                                 success:(Sucess)sucess
                                  failed:(Failed)failed
{

   [[WEMEUsercontrollerApi sharedAPI] forgetPasswordUsingPOSTWithCompletionBlock:phoneNumber password:passwd idcode:veryCode completionHandler:^(WEMESimpleResponse *output, NSError *error) {
       if (output.success.integerValue == 1) {
           sucess(@"");
       }else {
           if (output.error) {
               failed(output.errorDescription);
           }
           if (error) {
               failed(error.localizedDescription);
           }
       }
   }];
}


#pragma mark - 1.3版修改的-------------------------注册输入验证-------------------------
//注册第一步输入验证手机号、验证码
-(NSString *)regisiterFirstStepVaryfyPhoneNumber:(NSString *)phoneNumber veryCode:(NSString *)veryCode
{
    NSString *errorStr = nil;
    errorStr = [self veryFyPhoneNumber:phoneNumber];
    if (errorStr) {
        return errorStr;
    }
    
    if (IsEmpty(veryCode)) {
        return @"验证码不能为空";
    }
    return nil;
}

//注册第二步输入验证昵称、密码、再次输入密码
-(NSString *)registerSecondStepVaryfyNickName:(NSString *)nickName passwd:(NSString *)passwd againPasswd:(NSString *)againPasswd
{

    NSString *errorStr = nil;
    if (IsEmpty(nickName)) {
        return @"昵称不能为空";
    }
    
    errorStr = [self veryFyPasswd:passwd againPasswd:againPasswd];
    if (errorStr) {
        return errorStr;
    }
    
    return nil;
}


- (NSString *)forgetPasswdInputVaryFyphoneNum:(NSString *)phoneNumber veryCode:(NSString *)veryCode passwd:(NSString *)passwd againPasswd:(NSString *)againPasswd
{

    return [self verfyPhoneNumber:phoneNumber passwd:passwd againPasswd:againPasswd];

}

- (NSString *)registerInputVaryFy:(NSString *)nickName phoneNum:(NSString *)phoneNumber veryCode:(NSString *)veryCode passwd:(NSString *)passwd againPasswd:(NSString *)againPasswd
{
   
    return [self verfyPhoneNumber:phoneNumber passwd:passwd againPasswd:againPasswd];

}


-(NSString *)verfyPhoneNumber:(NSString *)phoneNumber passwd:(NSString *)passwd againPasswd:(NSString *)againPasswd {

    NSString *errorStr = nil;
    errorStr = [self veryFyPhoneNumber:phoneNumber];
    if (errorStr) {
        return errorStr;
    }
    
    errorStr = [self veryFyPasswd:passwd againPasswd:againPasswd];
    if (errorStr) {
        return errorStr;
    }
    
    return errorStr;
}

-(NSString *)veryFyPhoneNumber:(NSString *)phoneNum{

    if (IsEmpty(phoneNum)) {
        return @"手机号码不能为空";
    }
    if ([Util isValidateMobile:phoneNum]) {
        _phoneNumber = phoneNum;
        return nil;
    }else{
        return @"请你输入正确的手机号";
    }
}



-(NSString *)veryFyPasswd:(NSString *)passwd againPasswd:(NSString *)againPasswd {

    if (passwd.length < 6) {
        return @"密码长度少于6个字符";
    }
    if (![passwd isEqualToString:againPasswd]) {
        return @"两次密码输入不一致，请重新输入";
    }
    
    return nil;
}

#pragma mark ----------------------- 获取验证码部分 Method -----------------------
-(void)requestVeryCodeForRegister:(BOOL)isForRegister failed:(Failed)failed success:(Sucess)success{
    
    _sendVeryCodeFailedBlock = failed;
    _sendVeryCodeSuccessBlock = success;
    //开启定时器
    if (isForRegister) {//注册验证码请求
        [self registerGetVeryCodeRequest];
    }else {
        [self findPasswdGetVeryCodeRequest];
    }
}


//注册获取验证码请求
-(void)registerGetVeryCodeRequest {
    
    
    [[WEMEUsercontrollerApi sharedAPI] verifycodeUsingGETWithCompletionBlock:_phoneNumber completionHandler:^(WEMESimpleResponse *output, NSError *error) {
        
        NSLog(@"注册发送验证码output %@",output);
        if (output.success.integerValue == 1) {
            if (self.sendVeryCodeSuccessBlock) {
                self.sendVeryCodeSuccessBlock(@"验证码已发送，有效期为20分钟");
                //请求成功之后，再开始定时器
                [self _beginVeryCodeTimer];
            }
        }else {
            if (self.sendVeryCodeFailedBlock) {
                if (!IsEmpty(output.errorDescription)) {
                    self.sendVeryCodeFailedBlock(output.errorDescription);
                }
                //重置验证码
                [self resetVeryCode];
            }
        }
        
    }];
}



//找回密码获取验证码请求
-(void)findPasswdGetVeryCodeRequest {
    //请求
    [[WEMEUsercontrollerApi sharedAPI] forgetpasswordverifycodeUsingGETWithCompletionBlock:_phoneNumber completionHandler:^(WEMESimpleResponse *output, NSError *error) {
        NSLog(@"忘记密码发送验证码output %@",output);
        if (output.success.integerValue == 1) {
            if (self.sendVeryCodeSuccessBlock) {
                self.sendVeryCodeSuccessBlock(@"验证码已发送，有效期为20分钟");
                //请求成功之后，再开始定时器
                [self _beginVeryCodeTimer];
            }
        }else {
            NSString *errorMessage;
            if (IsEmpty(error)) {
                errorMessage = output.errorDescription;
            }
            else
            {
                errorMessage = @"获取验证码失败，请检查网络...";
            }
            if (self.sendVeryCodeFailedBlock) {
                self.sendVeryCodeFailedBlock(errorMessage);
                //重置验证码
                [self resetVeryCode];
            }
        }
    }];
    
}

-(void)_beginVeryCodeTimer {
    
    _getVeryCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(subVeryCodeSeconds) userInfo:nil repeats:YES];
    _veryCodeSeconds = 60;
}


-(void)subVeryCodeSeconds {
    
    _veryCodeSeconds -- ;
    
    //设置button的秒数
    [self _setVerycodeButtonSeconds];
}

-(void)_setVerycodeButtonSeconds {
    
    NSString *title = nil;
    if (!_veryCodeSeconds) {
        title = @"重新发送";
    }else {
        title = [NSString stringWithFormat:@"重新发送(%lds)",_veryCodeSeconds];
    }
    self.veryfyButton.titleLabel.text = title;
    [self.veryfyButton setTitle:title forState:UIControlStateDisabled];
    if (!_veryCodeSeconds) {
        //重置验证码
        [self resetVeryCode];
    }
}

-(void)resetVeryCode
{
    
    self.veryfyButton.enabled = YES;
    [self.veryfyButton setTitle:@"重新发送" forState:UIControlStateNormal];
    
    [_getVeryCodeTimer invalidate];
    _getVeryCodeTimer = nil;
}


-(void)setVeryfyButton:(UIButton *)veryfyButton {
    _veryfyButton = veryfyButton;
    _veryfyButton.enabled = NO;
}






@end

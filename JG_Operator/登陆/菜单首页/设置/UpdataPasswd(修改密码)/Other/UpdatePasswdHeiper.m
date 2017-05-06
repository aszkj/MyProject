//
//  UpdatePasswdHeiper.m
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "UpdatePasswdHeiper.h"

@interface UpdatePasswdHeiper() {
    
    NSString *_oldPasswd;
    NSString *_newPasswd;
    
    NSString *_phoneNum;
    NSString *_veryCode;
    
    NSTimer  *_getVeryCodeTimer;
}
//发送验证码请求失败回调
@property (nonatomic, copy)Failed sendVeryCodeFailedBlock;

@end

@implementation UpdatePasswdHeiper

#pragma mark ----------------------- 输入验证 -----------------------

//修改密码输入验证，返回错误信息，如果错误信息为nil，说明输入验证成功
- (NSString *)updatePasswdInputVeriryForOldPasswd:(NSString *)oldPasswd newPasswd:(NSString *)newPasswd againPasswd:(NSString *)againPasswd
{
    
    NSString *varifyStr = nil;
    if (IsEmpty(oldPasswd)) {//用户名为空
        varifyStr = @"原登录密码不能为空，密码至少6位！";
        return varifyStr;
    }
    
    //验证成功赋值
    _oldPasswd = oldPasswd;
    
    //验证两次密码输入
//    varifyStr = [self _veryfyTwoTimesPasswdInput:newPasswd againPasswd:againPasswd];
    varifyStr = [self _veryfyTwoTimesPasswdInput:newPasswd againPasswd:againPasswd alertPasswdName:@"登录"];
    if (varifyStr) {
        return varifyStr;
    }
    
    return varifyStr;
}



//修改提现密码输入验证，返回错误信息，如果错误信息为nil，说明输入验证成功
- (NSString *)updateDrawCashPasswdInputVeriryForPhoneNum:(NSString *)phoneNum veryCode:(NSString *)veryCode newPasswd:(NSString *)newPasswd againPasswd:(NSString *)againPasswd
{
    NSString *varifyStr = nil;
    //验证手机号码
//    varifyStr = [self veryfyPhoneNumberBeforeSendVeryCode:phoneNum];
//    if (!varifyStr) {
//        return varifyStr;
//    }
    _phoneNum = phoneNum;
    //验证码
    if (IsEmpty(veryCode)) {
        varifyStr = @"验证码不能为空";
        return varifyStr;
    }
    _veryCode = veryCode;
    //验证两次密码输入
//    varifyStr = [self _veryfyTwoTimesPasswdInput:newPasswd againPasswd:againPasswd];
    varifyStr = [self _veryfyTwoTimesPasswdInput:newPasswd againPasswd:againPasswd alertPasswdName:@"提现"];
    if (varifyStr) {
        return varifyStr;
    }
    
    return varifyStr;

}

//验证手机号码，
-(NSString *)veryfyPhoneNumberBeforeSendVeryCode:(NSString *)phoneNumber {
    
    NSString *varifyStr = nil;
    if (IsEmpty(phoneNumber)) {//用户名为空
        varifyStr = @"手机号为空";
        return varifyStr;
    }else{//不为空
        //验证是否为手机号
        if (![Util isValidateMobile:phoneNumber]) {
            varifyStr = @"手机号码格式无效";
            return varifyStr;
        }
    }
    _phoneNum = phoneNumber;
    return varifyStr;
}



//验证两次密码输入
-(NSString *)_veryfyTwoTimesPasswdInput:(NSString *)newPasswd againPasswd:(NSString *)againPasswd alertPasswdName:(NSString *)alertPasswdName
{
    
    NSString *varifyStr = nil;
    if (IsEmpty(newPasswd)) {
        
//        varifyStr = @"新登录密码不能为空，密码至少6位！";
        varifyStr = [NSString stringWithFormat:@"新%@密码不能为空，密码至少6位！",alertPasswdName];
        return varifyStr;
    }
    
    if (newPasswd.length < 6) {
//        varifyStr = @"新登录密码长度至少为6位";
         varifyStr = [NSString stringWithFormat:@"新%@密码长度至少为6位！",alertPasswdName];
        return varifyStr;
    }
    
    if (IsEmpty(againPasswd)) {
//        varifyStr = @"确认新登录密码不能为空，密码至少6位！";
        varifyStr = [NSString stringWithFormat:@"确认新%@密码不能为空，密码至少6位！",alertPasswdName];
        return varifyStr;
    }
    

    if (![newPasswd isEqualToString:againPasswd]) {
//        varifyStr = @"新登录密码与确认新密码不一致！";
        varifyStr = [NSString stringWithFormat:@"新%@密码与确认新密码不一致！",alertPasswdName];
        return varifyStr;
    }
    
    //如果是修改登录密码，
    if ([alertPasswdName isEqualToString:@"登录"]) {
        if ([_oldPasswd isEqualToString:_newPasswd]) {//原密码与登录密码一样
            varifyStr = @"原登录密码与新登录密码一样！";
            return varifyStr;
        }
    }
    
    _newPasswd = againPasswd;
    
    return varifyStr;
}

#pragma mark ----------------------------  验证码 -----------------------
-(void)requestVeryCodefailed:(Failed)failed{
    
    _sendVeryCodeFailedBlock = failed;
    //开启定时器
    [self _beginVeryCodeTimer];

    [self getVeryCodeRequest];
    
}


//获取验证码请求
-(void)getVeryCodeRequest {
    //请求，
    VApiManager *vapManager = [[VApiManager alloc] init];
    //提现密码验证码请求
    OperCodeSendRequest *request = [[OperCodeSendRequest alloc] init:GetToken];
    request.api_mobile = _phoneNum;
    [vapManager operCodeSend:request success:^(AFHTTPRequestOperation *operation, OperCodeSendResponse *response) {
        
        if (response.errorCode) {
            if (self.sendVeryCodeFailedBlock) {
                self.sendVeryCodeFailedBlock(response.subMsg);
                [self resetVeryCode];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        if (self.sendVeryCodeFailedBlock) {
            self.sendVeryCodeFailedBlock(error.localizedDescription);
            [self resetVeryCode];
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

-(void)resetVeryCode
{
    self.veryfyButton.enabled = YES;
    [self.veryfyButton setTitle:@"重新发送" forState:UIControlStateNormal];
    
    [_getVeryCodeTimer invalidate];
    _getVeryCodeTimer = nil;
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
        [self resetVeryCode];
    }
}

-(void)setVeryfyButton:(UIButton *)veryfyButton {
    _veryfyButton = veryfyButton;
    _veryfyButton.enabled = NO;
}


#pragma mark ----------------------- 开始请求 -----------------------
//开始修改密码请求
- (void)beginUpdatePasswdSuccess:(Success)sucess failed:(Failed)failed
{
    VApiManager *vapManager = [[VApiManager alloc] init];
    UsersPasswordUpdateRequest *request = [[UsersPasswordUpdateRequest alloc] init:GetToken];
    request.api_odlPassword = _oldPasswd;
    request.api_newPassword = _newPasswd;
    [vapManager usersPasswordUpdate:request success:^(AFHTTPRequestOperation *operation, UsersPasswordUpdateResponse *response) {
        if (!response.errorCode) {
            sucess();
        }else {
            failed(response.subMsg);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failed(error.localizedDescription);
        
    }];
}

//开始提现修改密码请求
- (void)beginDrawCashUpdatePasswdSuccess:(Success)sucess failed:(Failed)failed
{
    VApiManager *vapManager = [[VApiManager alloc] init];
    UsersOperaterMoneypassUpdateRequest *request = [[UsersOperaterMoneypassUpdateRequest alloc] init:GetToken];
    request.api_code = _veryCode;
    request.api_mobile = _phoneNum;
    request.api_password = _newPasswd;
    [vapManager usersOperaterMoneypassUpdate:request success:^(AFHTTPRequestOperation *operation, UsersOperaterMoneypassUpdateResponse *response) {
        if (!response.errorCode) {
            sucess();
        }else {
            failed(response.subMsg);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failed(error.localizedDescription);
        
    }];
}



@end

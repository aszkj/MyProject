//
//  UpdatePasswdHeiper.h
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Success)(void);
typedef void(^Failed)(NSString *errorStr);

@interface UpdatePasswdHeiper : NSObject

//修改密码输入验证，返回错误信息，如果错误信息为nil，说明输入验证成功
- (NSString *)updatePasswdInputVeriryForOldPasswd:(NSString *)oldPasswd newPasswd:(NSString *)newPasswd againPasswd:(NSString *)againPasswd;

//修改提现密码输入验证，返回错误信息，如果错误信息为nil，说明输入验证成功
- (NSString *)updateDrawCashPasswdInputVeriryForPhoneNum:(NSString *)phoneNum veryCode:(NSString *)veryCode newPasswd:(NSString *)newPasswd againPasswd:(NSString *)againPasswd;


//开始修改密码请求
- (void)beginUpdatePasswdSuccess:(Success)sucess failed:(Failed)failed;

//开始提现修改密码请求
- (void)beginDrawCashUpdatePasswdSuccess:(Success)sucess failed:(Failed)failed;

//发送验证码之前验证手机号码
-(NSString *)veryfyPhoneNumberBeforeSendVeryCode:(NSString *)phoneNumber;


//发送验证码请求
-(void)requestVeryCodefailed:(Failed)failed;


@property (nonatomic, strong)UIButton *veryfyButton;

//获取验证码时剩余时间
@property (nonatomic, assign)NSInteger veryCodeSeconds;




@end

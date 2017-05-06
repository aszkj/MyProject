
//
//  WIntegralView.m
//  jingGang
//
//  Created by thinker on 15/8/22.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WIntegralView.h"
#import "GlobeObject.h"
#import "PublicInfo.h"
#import "VApiManager.h"

@interface WIntegralView ()<UITextFieldDelegate>
{
    NSString *_phone;//手机号码
    NSInteger _time;//计时器计数
    NSTimer *_timer;
    VApiManager *_vapiManager;
}

@property (nonatomic, strong) UIButton    *yanzhengBtn;//获取验证码按钮
@property (nonatomic, strong) UILabel     *yanzhengLabel;
@property (nonatomic, strong) UITextField *yanzhenText;
@property (nonatomic, strong) UITextField *passwordText1;
@property (nonatomic, strong) UITextField *passwordText2;

@end

@implementation WIntegralView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        _time = -1;
    }
    return self;
}
//确定修改
- (void)certainAlter
{
    [self hiddenKey];
    if (self.passwordText1.text.length == 0 || self.passwordText2.text.length == 0)
    {
        [self showAlertMessage:@"密码不能为空"];
        return;
    }
    if (self.yanzhenText.text.length == 0)
    {
        [self showAlertMessage:@"验证码不能为空"];
        return;
    }
    if (![self.passwordText2.text isEqualToString:self.passwordText1.text])
    {
        [self showAlertMessage:@"两次密码输入不对，请重新输入"];
        self.passwordText1.text = nil;
        self.passwordText2.text = nil;
        return;
    }
    UsersPayPasswordUpdateRequest *passwordRequest = [[UsersPayPasswordUpdateRequest alloc] init:GetToken];
    passwordRequest.api_mobile = _phone;
    passwordRequest.api_code = self.yanzhenText.text;
    passwordRequest.api_password = self.passwordText1.text;
    WEAK_SELF
    [_vapiManager usersPayPasswordUpdate:passwordRequest success:^(AFHTTPRequestOperation *operation, UsersPayPasswordUpdateResponse *response) {
        if (!response.errorCode) {
            [weak_self showAlertMessage:@"修改云币密码成功"];
        }
        else
        {
            [weak_self showAlertMessage:@"修改云币密码失败"];
            weak_self.passwordText1.text = nil;
            weak_self.passwordText2.text = nil;
        }
        NSLog(@"cheshi ---- %@",response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weak_self showAlertMessage:@"修改云币密码失败"];
        weak_self.passwordText1.text = nil;
        weak_self.passwordText2.text = nil;
    }];
}
- (void)showAlertMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

- (void) createUI
{
    _vapiManager = [[VApiManager alloc] init];
    self.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.1];
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults]objectForKey:@"arr_list"];
    _phone = [dict objectForKey:@"mobile"];
    //手机号码
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 54, self.frame.size.width, 44)];
    view1.backgroundColor = [UIColor whiteColor];
    UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 62, 44)];
    phone.text = @"手机号码:";
    phone.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    phone.font = [UIFont systemFontOfSize:14];
    UITextField *PhText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phone.frame) +6, 0, 150, 44)];
    PhText.text = [dict objectForKey:@"mobile"];
    PhText.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    PhText.enabled = NO;
    PhText.font = [UIFont systemFontOfSize:14];
    
    self.yanzhengBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.yanzhengBtn.frame = CGRectMake(__MainScreen_Width - 100, 0, 100, 44);
    self.yanzhengBtn.backgroundColor = status_color;
    [self.yanzhengBtn setTitle:@"" forState:UIControlStateNormal];
    [self.yanzhengBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.yanzhengBtn addTarget:self action:@selector(yanzhengAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.yanzhengLabel = [[UILabel alloc] initWithFrame:self.yanzhengBtn.frame];
    self.yanzhengLabel.textColor = [UIColor whiteColor];
    self.yanzhengLabel.text = @"发送验证码";
    self.yanzhengLabel.textAlignment = NSTextAlignmentCenter;
    self.yanzhengLabel.font = [UIFont systemFontOfSize:15];
    
    [view1 addSubview:phone];
    [view1 addSubview:PhText];
    [view1 addSubview:self.yanzhengBtn];
    [view1 addSubview:self.yanzhengLabel];
    [self addSubview:view1];
    
    //验证码
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0,99, self.frame.size.width, 44)];
    view2.backgroundColor = [UIColor whiteColor];
    UILabel *yanzhen = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 85, 44)];
    yanzhen.text = @"手机验证码：";
    yanzhen.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    yanzhen.font = [UIFont systemFontOfSize:14];
    self.yanzhenText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yanzhen.frame) +6, 0, 150, 44)];
    self.yanzhenText.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    self.yanzhenText.placeholder = @"请输入验证码";
    self.yanzhenText.keyboardType = UIKeyboardTypeNumberPad;
    self.yanzhenText.font = [UIFont systemFontOfSize:14];
    [view2 addSubview:yanzhen];
    [view2 addSubview:self.yanzhenText];
    [self addSubview:view2];
    
    
    //新密码
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 153, self.frame.size.width, 44)];
    view3.backgroundColor = [UIColor whiteColor];
    UILabel *passwordLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 44)];
    passwordLabel1.text = @"新密码：";
    passwordLabel1.textAlignment = NSTextAlignmentRight;
    passwordLabel1.textColor = [UIColor blackColor];
    passwordLabel1.font = [UIFont systemFontOfSize:14];
    self.passwordText1 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(passwordLabel1.frame) +6, 0, 150, 44)];
    self.passwordText1.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    self.passwordText1.font = [UIFont systemFontOfSize:14];
    self.passwordText1.delegate = self;
    self.passwordText1.placeholder = @"请输入新密码";
    self.passwordText1.secureTextEntry = YES;
    [view3 addSubview:passwordLabel1];
    [view3 addSubview:self.passwordText1];
    [self addSubview:view3];
 
    
    //重复密码
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(0, 198, self.frame.size.width, 44)];
    view4.backgroundColor = [UIColor whiteColor];
    UILabel *passwordLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 44)];
    passwordLabel2.text = @"重复密码：";
    passwordLabel2.textAlignment = NSTextAlignmentRight;
    passwordLabel2.textColor = [UIColor blackColor];
    passwordLabel2.font = [UIFont systemFontOfSize:14];
    self.passwordText2 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(passwordLabel1.frame) +6, 0, 150, 44)];
    self.passwordText2.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    self.passwordText2.font = [UIFont systemFontOfSize:14];
    self.passwordText2.placeholder = @"请输入新密码";
    self.passwordText2.secureTextEntry = YES;
    self.passwordText2.delegate = self;
    [view4 addSubview:passwordLabel2];
    [view4 addSubview:self.passwordText2];
    [self addSubview:view4];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKey)];
    [self addGestureRecognizer:tap];
}
- (void) yanzhengAction:(UIButton *)btn
{
    if (_time == -1)
    {
        _time = 60;
        VerifyForgetcodeSendRequest *request = [[VerifyForgetcodeSendRequest alloc] init:GetToken];
        request.api_mobile = _phone;
        [_vapiManager verifyForgetcodeSend:request success:^(AFHTTPRequestOperation *operation, VerifyForgetcodeSendResponse *response) {
            NSLog(@"验证码发送 ---- %@",response);
            self.yanzhengLabel.text = @"重新发送(60s)";
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(jishiqi) userInfo:nil repeats:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self showAlertMessage:@"验证码发送失败，请检查网络"];
        }];
    }
}
- (void)jishiqi
{
    -- _time;
    if (_time >= 0)
    {
        self.yanzhengLabel.text = [NSString stringWithFormat:@"重新发送(%02lds)",_time];
    }
    else
    {
        [_timer invalidate];
        self.yanzhengLabel.text = @"发送验证码";
        _time = -1;
    }
    
}
- (void) hiddenKey
{
    [self endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    return YES;
}

@end

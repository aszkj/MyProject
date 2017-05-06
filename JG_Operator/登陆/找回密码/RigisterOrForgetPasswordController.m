//
//  RigisterOrForgetPasswordController.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/1.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "RigisterOrForgetPasswordController.h"
#import "LoginRegisterHelper.h"
#import "KeyboardNextActionHander.h"

@interface RigisterOrForgetPasswordController () {

    LoginRegisterHelper *_registerHelper;
    MBProgressHUD       *_hub;
    KeyboardNextActionHander *_keyBoardNextHander;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneNumberTopContraint;
@property (nonatomic, strong)LoginRegisterHelper *registerHelper;
@property (weak, nonatomic) IBOutlet UIButton *registerFindPasswdButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *veryCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *againPasswdTextField;
@property (weak, nonatomic) IBOutlet UIButton *veryCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;

@end

@implementation RigisterOrForgetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
}

#pragma mark ----------------------- private Method -----------------------
-(void)_init {
    
    NSString *title = @"";
    if (self.registerPageType == RegisterType) {
        title = @"注册";
    }else {
        title = @"重置密码";
    }
    _registerHelper = [[LoginRegisterHelper alloc] init];
    self.phoneNumberTopContraint.constant = 10;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [Util setNavTitleWithTitle:title ofVC:self];
    [self.registerFindPasswdButton setTitle:title forState:UIControlStateNormal];
    self.navigationController.navigationBar.barTintColor = status_color;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    _keyBoardNextHander = [[KeyboardNextActionHander alloc] initWithBodyView:self.view goNextByType:GoNextByPosition];
    WEAK_SELF;
    _keyBoardNextHander.lastNextBlock = ^{
    
        [weak_self _findPasswdLogic];
        
    };
}


#pragma mark ----------------------- Action Method -----------------------
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 获取验证码
- (IBAction)getVeryCodeAction:(id)sender {
    
    //发送验证码请求之前先验证手机号码
    NSString *veryfyPhoneNumStr = [_registerHelper veryfyPhoneNumberBeforeSendVeryCode:self.phoneNumTextField.text];
    if (veryfyPhoneNumStr) {
        [Util ShowAlertWithOnlyMessage:veryfyPhoneNumStr];
        return;
    }
    
    BOOL isRegister = YES;
    if (self.registerPageType == ForgetPasswordType) {
        isRegister = NO;
    }
    //把验证码button交给helper处理
    _registerHelper.veryfyButton = self.veryCodeButton;
    //验证码请求
    [_registerHelper requestVeryCodeForRegister:isRegister failed:^(NSString *failedStr) {
        //发送验证码请求失败，
        [Util ShowAlertWithOnlyMessage:failedStr];
    }];
}

- (IBAction)registerFindPasswdAction:(id)sender {
    
    [self _findPasswdLogic];
    
}

#pragma mark - 找回密码逻辑
-(void)_findPasswdLogic {
    
    NSString *verifyStr = nil;
    verifyStr = [_registerHelper findPasswdInputVeriryForUserName:self.phoneNumTextField.text passwd:self.passwdTextField.text againPasswd:self.againPasswdTextField.text veryCode:self.veryCodeTextField.text];
    if (verifyStr) {//说明忘记密码信息输入有错误
        [Util ShowAlertWithOnlyMessage:verifyStr];
    }else{
        _hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hub.labelText = @"正在修改密码..";
        [_registerHelper beginFindPasswdWithSuccess:^(NSString *sucessToken) {
            _hub.labelText = @"修改密码成功";
            [_hub hide:YES afterDelay:0.5];
            [self performSelector:@selector(back) withObject:nil afterDelay:1.0];
        } failed:^(NSString *failedStr) {
            _hub.labelText = @"修改密码失败";
            [_hub hide:YES afterDelay:0.3];
            [Util ShowAlertWithOnlyMessage:failedStr];
        }];
    }
}



@end

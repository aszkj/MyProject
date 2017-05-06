//
//  KJLoginController.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/1.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "KJLoginController.h"
#import "JGShareView.h"
#import "LoginRegisterHelper.h"
#import "Util.h"
#import "RigisterOrForgetPasswordController.h"
#import "UIViewController+MBHud.h"
#import "MerchantManagerViewController.h"
#import "MainViewController.h"
#import "XKO_BaseNavigationController.h"
#import "XKUpdatePasswdController.h"
#import  <IQKeyboardManager/IQKeyboardManager.h>
@interface KJLoginController () <UITextFieldDelegate>{

    LoginRegisterHelper *_loginHelper;
    MBProgressHUD *hub;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeightConstraint;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *userNameTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *userPasswdTextField;

@end



@implementation KJLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.userNameTextField setValue:kGetColor(166, 251, 252) forKeyPath:@"_placeholderLabel.textColor"];
    [self.userPasswdTextField setValue:kGetColor(166, 251, 252) forKeyPath:@"_placeholderLabel.textColor"];
    _loginHelper = [[LoginRegisterHelper alloc] init];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.topHeightConstraint.constant = (198.0 / iPhone6_Height) * kScreenHeight;

    NSString *cachedAccountName = [kUserDefaults objectForKey:KAcountNameKey];
    if (cachedAccountName) {
//        self.userNameTextField.text = cachedAccountName;
    }
    _userNameTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
//    [self performSelector:@selector(_hiddenNavBar) withObject:nil afterDelay:0.3];
}

- (void)_hiddenNavBar {
    self.navigationController.navigationBar.hidden = YES;
}



-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = NO;

}


#pragma mark ----------------------- Action Method -----------------------
#pragma mark - 登录
- (IBAction)loginAction:(id)sender {
    
    [self _beginLoginLogic];
}


- (void)_beginLoginLogic {
    
    NSString *verifyStr = [_loginHelper loginInputVeriryForUserName:self.userNameTextField.text passwd:self.userPasswdTextField.text];
    if (verifyStr) {//说明输入有错误
        [Util ShowAlertWithOnlyMessage:verifyStr];
    }else{
        [self loadHud:self.view];
        hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hub.labelText = @"正在登录..";
        //登录请求
        [_loginHelper beginLoginWithSuccess:^(NSString *sucessStr) {
            //登录成功，跳转
            if (sucessStr) {
                [hub hide:YES];
                hub.labelText = @"登录成功";
                //缓存用户名
                [kUserDefaults setObject:self.userNameTextField.text forKey:KAcountNameKey];
                [kUserDefaults synchronize];
                [self enterRootView];
            }
        } failed:^(NSString *failedStr) {
            [Util ShowAlertWithOnlyMessage:failedStr];
            [hub hide:YES];
            hub.labelText = @"登录失败";
        }];
    }
}

#pragma mark - 进入主界面
- (void)enterRootView
{
    MainViewController *root = [[MainViewController alloc] init];
    XKO_BaseNavigationController *nav = [[XKO_BaseNavigationController alloc] initWithRootViewController:root];
    self.view.window.rootViewController = nav;
}

#pragma mark - 忘记密码
- (IBAction)forgetPasswdAction:(id)sender {
    RigisterOrForgetPasswordController *fogetPasswdVC = [[RigisterOrForgetPasswordController alloc] init];
    fogetPasswdVC.registerPageType = ForgetPasswordType;
    [self.navigationController pushViewController:fogetPasswdVC animated:YES];
    
}

- (IBAction)textChangedAction:(UITextField *)sender {

    [self performSelector:@selector(_upUserName) withObject:nil afterDelay:0.3];
    
}

-(void)_upUserName {

    self.userNameTextField.text = [self.userNameTextField.text uppercaseString];

}


#pragma mark ----------------------- text Field delegate -----------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 1) {
        [self.userPasswdTextField becomeFirstResponder];
    }else if (textField.tag == 2) {
        [textField resignFirstResponder];
        [self _beginLoginLogic];
    }
    return YES;
}

@end

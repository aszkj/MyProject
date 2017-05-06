//
//  RigisterOrForgetPasswordController.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/1.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "RigisterOrForgetPasswordController.h"
#import "LoginRegisterHelper.h"
#import "XKJHShopEnterInfoViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <IQKeyboardManager/IQKeyboardReturnKeyHandler.h>
#import "KeyboardNextActionHander.h"
#import "DownToUpAlertView.h"

@interface RigisterOrForgetPasswordController () {

    LoginRegisterHelper *_registerHelper;
    MBProgressHUD       *_hub;
    KeyboardNextActionHander *_keyBoardNextHander;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneNumTopHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *nickNameView;
@property (weak, nonatomic) IBOutlet UIView *againInputPasswdBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *againInputBgViewToTopEdges;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *againPasswdHeightConstraint;

@property (nonatomic, strong)LoginRegisterHelper *registerHelper;
@property (weak, nonatomic) IBOutlet UIButton *registerFindPasswdButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *veryCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *againPasswdTextField;
@property (weak, nonatomic) IBOutlet UIButton *veryCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *registerInvitationCodeTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *invitationViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registerButtonToTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *invitationCodeView;

@property (weak, nonatomic) IBOutlet UIButton *displayPasswdBtn;

@property (nonatomic, strong) IQKeyboardReturnKeyHandler    *returnKeyHandler;

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
        self.againInputPasswdBgView.hidden = YES;
        self.againInputBgViewToTopEdges.constant = 0;
        self.againPasswdHeightConstraint.constant = 0;
    }else {
        title = @"重置密码";
        //没有邀请码view
        self.invitationViewHeightConstraint.constant = 0;
        self.registerButtonToTopConstraint.constant = 10;
//        //没有昵称view
//        self.phoneNumTopHeightConstraint.constant = 13;
//        self.nickNameView.hidden = YES;
    }
    //没有昵称view
    self.phoneNumTopHeightConstraint.constant = 13;
    self.nickNameView.hidden = YES;
    
    _registerHelper = [[LoginRegisterHelper alloc] init];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [Util setNavTitleWithTitle:title ofVC:self];
    [self.registerFindPasswdButton setTitle:title forState:UIControlStateNormal];
    self.navigationController.navigationBar.barTintColor = status_color;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
    
    [[self.displayPasswdBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
        btn.selected = !btn.selected;
//        UIKeyboardType passwdKeyBoardType = btn.selected ?
        self.passwdTextField.secureTextEntry = !btn.selected;
    }];
    
    //配置键盘
//    [self _configureKeyBoard];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    _keyBoardNextHander = [[KeyboardNextActionHander alloc] initWithBodyView:self.view goNextByType:GoNextByPosition];
    WEAK_SELF
    _keyBoardNextHander.lastNextBlock = ^{
    
        [weak_self _beginRegisterFindPasswdLogic];
        
    };
}


-(void)_configureKeyBoard {
    _returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
   [_returnKeyHandler setLastTextFieldReturnKeyType:UIReturnKeyDone];
    _returnKeyHandler.toolbarManageBehaviour = IQAutoToolbarBySubviews;
}

#pragma mark - 进入商家入驻信息填写页
-(void)_comToMerchantInfoPage {
    XKJHShopEnterInfoViewController *merchantInfoVC = [[XKJHShopEnterInfoViewController alloc] init];
    [self.navigationController pushViewController:merchantInfoVC animated:YES];
    
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
    [self.phoneNumTextField resignFirstResponder];
    //验证码请求
    [_registerHelper requestVeryCodeForRegister:isRegister failed:^(NSString *failedStr) {
//        [Util ShowAlertWithOnlyMessage:failedStr];
        [DownToUpAlertView showAlertTitle:failedStr inContentView:self.view];
    } success:^(NSString *sucessStr) {
//        [Util ShowAlertWithOnlyMessage:sucessStr];
        [DownToUpAlertView showAlertTitle:sucessStr inContentView:self.view];
    }];
}


- (IBAction)registerFindPasswdAction:(id)sender {
    
    [self _beginRegisterFindPasswdLogic];
}

#pragma mark - 开始注册、找回密码逻辑
- (void)_beginRegisterFindPasswdLogic {
    
    NSString *verifyStr = nil;
    if (self.registerPageType == RegisterType) {//注册
        verifyStr = [_registerHelper registerInputVeriryForNickName:self.nickNameTextField.text UserName:self.phoneNumTextField.text passwd:self.passwdTextField.text againPasswd:self.againPasswdTextField.text veryCode:self.veryCodeTextField.text];
        if (verifyStr) {//说明注册信息输入有错误
            [Util ShowAlertWithOnlyMessage:verifyStr];
        }else{
            //赋值注册邀请码
            _registerHelper.invitationCode = _registerInvitationCodeTextField.text;
            _hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [_registerHelper beginRegisterWithSuccess:^(NSString *sucessStr) {
                _hub.labelText = @"注册成功,正在验证..";
                //调用登录接口，存储token
                [_registerHelper beginLoginWithSuccess:^(NSString *sucessToken) {
                    //验证成功，进入商家入驻信息填写界面
                    _hub.labelText = @"验证成功";
                    [_hub hide:YES afterDelay:0.5];
                    [self performSelector:@selector(_comToMerchantInfoPage) withObject:nil afterDelay:1.0];
                } failed:^(NSString *failedStr) {
                    [Util ShowAlertWithOnlyMessage:failedStr];
                }];

            } failed:^(NSString *failedStr) {
                _hub.labelText = @"注册失败";
                [_hub hide:YES afterDelay:0.3];
                [Util ShowAlertWithOnlyMessage:failedStr];
            }];
        }
    }else {//找回密码
        verifyStr = [_registerHelper findPasswdInputVeriryForUserName:self.phoneNumTextField.text passwd:self.passwdTextField.text againPasswd:self.againPasswdTextField.text veryCode:self.veryCodeTextField.text];
        if (verifyStr) {//说明忘记密码信息输入有错误
            [Util ShowAlertWithOnlyMessage:verifyStr];
        }else{
            _hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
}


@end

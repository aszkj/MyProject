//
//  LoginController.m
//  weimi
//
//  Created by 张康健 on 16/1/18.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "LoginController.h"
#import "UIButton+Block.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LoginRegisterHelper.h"
#import "RigisterForgetPasswdController.h"
#import "BaseTabBarController.h"
#import "AppDelegate.h"
#import "XKJHNavRootController.h"
#import "UIImage+SizeAndTintColor.h"
//#import "RegisterViewController.h"
#import "WEMEModelExtension.h"
#import "AcceptOrdeController.h"
#import "WEMEProgressHUD.h"
#import "RemoteNotificationManage.h"

#define UserAccountCache @"UserAccountCache"

#define kLineColor      UIColorFromRGB(0xe3e3e3)

@interface LoginController ()<UITextFieldDelegate>

@property (nonatomic,strong)UIImageView *logImgView;
@property (nonatomic,strong)UIButton *fogetPasswdButton;
//账户textField
@property (nonatomic,strong)UITextField *accountTextField;
//密码textField
@property (nonatomic,strong)UITextField *passwTextField;
/**
 *  注册button
 */
@property (nonatomic,strong)UIButton *quickRegisterButton;
//登录button
@property (nonatomic,strong)UIButton *loginButton;
@property (nonatomic,strong)LoginRegisterHelper *loginHelper;

#define TextFeildHeight     40.0

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _creatUI];
    
    [self _setViewConstraint];
    
    [self _init];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [kUserDefaults setObject:textField.text forKey:UserAccountCache];
    [kUserDefaults synchronize];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}


#pragma mark ----------------------- CreatUI  Method -----------------------------
- (void)_creatUI{
    
    self.logImgView = [XKO_CreateUIViewHelper createUIImageViewWithImageName:@"登陆_03"];
    [self.view addSubview:self.logImgView];
    
    _accountTextField = [UITextField new];
    _accountTextField.font = [UIFont CustomFontOfSize:13.0];
    _accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    _accountTextField.placeholder = @"请输入您的手机号";
    _accountTextField.text = [kUserDefaults objectForKey:UserAccountCache];
    _accountTextField.delegate = self;
    _accountTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, TextFeildHeight)];
    accountLabel.text = @"账号";
    accountLabel.font = [UIFont CustomFontOfSize:13.0];
    _accountTextField.leftView = accountLabel;
    [self.view addSubview:self.accountTextField];
    
    UIButton *clearAccountButton = [XKO_CreateUIViewHelper createUIButtonWithNormalStateImageName:@"登陆-键盘-切换_03" selectedStateImgName:nil];
    clearAccountButton.frame = CGRectMake(0, (TextFeildHeight-21)/2.0, 15, 15);
    _accountTextField.rightView = clearAccountButton;
    _accountTextField.rightViewMode = UITextFieldViewModeWhileEditing;
    //点击清除
    WEAK_SELF;
    [clearAccountButton addActionHandler:^(NSInteger tag) {
        
        weak_self.accountTextField.text = nil;
        [weak_self.accountTextField becomeFirstResponder];
    }];
    
    UIButton *exchangeKeyBoardTypeButton = [XKO_CreateUIViewHelper createUIButtonWithNormalStateImageName:@"登陆-键盘-切换_06" selectedStateImgName:@"keyboardShowed"];
    exchangeKeyBoardTypeButton.frame = CGRectMake(0, (TextFeildHeight-19)/2.0, 19, 10.5);
    //点击切换键盘
    __block UIButton *weakButton = exchangeKeyBoardTypeButton;
    [exchangeKeyBoardTypeButton addActionHandler:^(NSInteger tag) {
        weak_self.passwTextField.secureTextEntry = !weak_self.passwTextField.secureTextEntry;
        weakButton.selected = !weakButton.isSelected;
    }];
    UILabel *passwLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, TextFeildHeight)];
    passwLabel.text = @"密码";
    passwLabel.font = [UIFont CustomFontOfSize:13.0];
    
    self.passwTextField = [UITextField new];
    _passwTextField.font = KSmallFont;
    self.passwTextField.placeholder = @"请输入您的密码";
    self.passwTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.passwTextField.secureTextEntry = YES;
    _passwTextField.leftViewMode = UITextFieldViewModeAlways;
    _passwTextField.leftView = passwLabel;
    _passwTextField.rightView = exchangeKeyBoardTypeButton;
    _passwTextField.rightViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.passwTextField];
    
    UIView *line1 = [XKO_CreateUIViewHelper lineViewWith:kLineColor];
    UIView *line2 = [XKO_CreateUIViewHelper lineViewWith:kLineColor];
    [_accountTextField addSubview:line1];
    [_passwTextField addSubview:line2];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@[@(line1.frame.size.height),line2]);
        make.bottom.equalTo(_accountTextField);
        make.left.equalTo(_accountTextField);
        make.right.equalTo(_accountTextField);
    }];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_passwTextField);
        make.right.equalTo(_passwTextField);
        make.bottom.equalTo(_passwTextField);
    }];
    
    //登录按钮
    self.loginButton= [XKO_CreateUIViewHelper createUIButtonWithTitle:@"登录" titleColor:kWhiteColor titleFont:[UIFont CustomFontOfSize:15.0] backgroundColor:UIColorFromRGB(0x54b4ef) hasRadius:YES targetSelector:@selector(beginLogin) target:self];
    self.loginButton.layer.cornerRadius = 5;
    [self.view addSubview:self.loginButton];
    
    
    //快速注册，忘记密码
    self.quickRegisterButton= [XKO_CreateUIViewHelper createUIButtonWithTitle:@"新用户?立即注册" titleColor:UIColorFromRGB(0x12b7f5) titleFont:[UIFont CustomFontOfSize:14.0] backgroundColor:[UIColor whiteColor] hasRadius:YES targetSelector:@selector(quickRegister) target:self];
    self.quickRegisterButton.hidden = YES;
    [self.view addSubview:self.quickRegisterButton];
    
    self.fogetPasswdButton = [XKO_CreateUIViewHelper createUIButtonWithTitle:@"忘记密码?" titleColor:UIColorFromRGB(0x5c75a7) titleFont:kSystemFontWithSize(14) backgroundColor:kClearColor hasRadius:NO targetSelector:@selector(forgetPasswd) target:self];
    [self.view addSubview:self.fogetPasswdButton];
    
}

#pragma mark ----------------------- SetViewConstraint Method -----------------------
- (void)_setViewConstraint {
    
    UIView *superview = self.view;
    [self.logImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(superview).with.offset(55);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    
    
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superview).with.offset(15);
        make.right.mas_equalTo(superview).with.offset(-20);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.logImgView.mas_bottom).with.offset(50);;
    }];
    
    [self.passwTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.accountTextField);
        make.top.mas_equalTo(self.accountTextField.mas_bottom).with.offset(8);
        make.height.mas_equalTo(TextFeildHeight);
        make.right.mas_equalTo(self.accountTextField);
    }];
    
    //登录、快速注册、忘记密码按钮
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwTextField.mas_bottom).with.offset(27);
        make.left.right.mas_equalTo(self.passwTextField);
        make.height.mas_equalTo(38);
    }];
    
    [self.quickRegisterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(superview).with.offset(-10);
        make.left.right.mas_equalTo(self.loginButton);
        make.height.mas_equalTo(@45);
        
    }];
    
    [self.fogetPasswdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.mas_bottom).with.offset(24);
        make.size.mas_equalTo(CGSizeMake(70, 35));
        make.centerX.equalTo(self.loginButton);
    }];
}

#pragma mark ----------------------- Private Method -----------------------
- (void)_init {
    
    self.loginHelper.loginButtonEabledSignal = [RACSignal combineLatest:@[self.accountTextField.rac_textSignal,self.passwTextField.rac_textSignal] reduce:^id(NSString *accountStr,NSString *passwdStr){
        if (!IsEmpty(accountStr) && !IsEmpty(passwdStr)) {
            return @1;
        }{
            return @0;
        }
    }];
    
    [self.loginHelper.loginButtonEabledSignal subscribeNext:^(NSNumber* value) {
        if (value.integerValue) {
            self.loginButton.alpha = 1.0;
        }else{
            self.loginButton.alpha = 0.5;
        }
    }];
    
    RAC(self.loginButton,enabled) = self.loginHelper.loginButtonEabledSignal;
    
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"";
    [temporaryBarButtonItem setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
}

-(void)_beginLoginLogic {
    
    if (![Util isValidateMobile:self.accountTextField.text]) {
        [Util ShowAlertWithOnlyMessage:@"不是有效的手机号码"];
    }else {
        //开始登录
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hub.labelText = @"正在登陆..";
        [WEMEProgressHUD showHUDAddedTo:self.view];
        WEAK_SELF;
        [self.loginHelper beginLoginWithAccoutName:self.accountTextField.text passwd:self.passwTextField.text success:^(NSString *sucessToken) {
            [WEMESimpleUser updateSelfSimpleUser];
            [weak_self _enterMainPage];
            [WEMEProgressHUD hideHUDForView:weak_self.view];
            
        } failed:^(NSString *failedStr) {
            [hub hide:YES];
            [WEMEProgressHUD hideHUDForView:weak_self.view];
        }];
    }
    
}

- (void)_enterMainPage {
    
    AcceptOrdeController *mainPage = [[AcceptOrdeController alloc] init];
    kAppDelegate.mainController = mainPage;
    UINavigationController *naviMain = [[XKJHNavRootController alloc] initWithRootViewController:mainPage];
    [UIApplication sharedApplication].keyWindow.rootViewController = naviMain;
    //注册远程通知
    [[RemoteNotificationManage sharedRemoteNotificationManage] registerNotification];
}

-(void)_comRisterForgetPasswdPage:(BOOL)isForgetPasswd {
    
    RigisterForgetPasswdController *registerVC = [[RigisterForgetPasswdController alloc] init];
    registerVC.isForgetPasswd = isForgetPasswd;
    if (isForgetPasswd) {
        registerVC.phoneNumberString = self.accountTextField.text;
        WEAK_SELF;
        registerVC.forgetPasswdBackBlock = ^(NSString *phoneNumber,NSString *passwd) {
            weak_self.accountTextField.text = phoneNumber;
            weak_self.passwTextField.text = passwd;
            weak_self.loginButton.enabled = YES;
            weak_self.loginButton.alpha = 1.0;
        };
    }
    [self.navigationController pushViewController:registerVC animated:YES];
}




#pragma mark ----------------------- Action Method -----------------------
- (void)beginLogin {
    
    [self _beginLoginLogic];
    
}

- (void)quickRegister {
    //    [self _comRisterForgetPasswdPage:NO];
//    [self.navigationController pushViewController:[[RegisterViewController alloc] init] animated:YES];
}

- (void)forgetPasswd {
    [self _comRisterForgetPasswdPage:YES];
}



#pragma mark ----------------------- getter Method -----------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(LoginRegisterHelper *)loginHelper {
    
    if (!_loginHelper) {
        _loginHelper = [[LoginRegisterHelper alloc] init];
    }
    return _loginHelper;
}


#pragma mark - dyci debug operation
- (void)updateOnClassInjection {
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self _creatUI];
    [self _setViewConstraint];
}

@end

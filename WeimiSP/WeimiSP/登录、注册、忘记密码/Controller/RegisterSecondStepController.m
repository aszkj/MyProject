//
//  RegisterSecondStepController.m
//  weimi
//
//  Created by 张康健 on 16/2/18.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "RegisterSecondStepController.h"
#import "LoginRegisterHelper.h"
#import "AcceptOrdeController.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "XKJHNavRootController.h"

@interface RegisterSecondStepController ()

@property (nonatomic,strong)UITextField *phoneNumberTextField;
@property (nonatomic,strong)UITextField *nickNameTextField;
@property (nonatomic,strong)UITextField *veryCodeTextField;
@property (nonatomic,strong)UITextField *passwdTextField;
@property (nonatomic,strong)UITextField *againPasswdTextField;

@property (nonatomic,strong)UIButton *registerButton;
@property (nonatomic,strong)UIButton *getVeryCodeButton;

@property (nonatomic,strong)UIButton *readButton;


@property (nonatomic,strong)LoginRegisterHelper *reigsterForgetPasswdHelper;



@end

@implementation RegisterSecondStepController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createUI];
    
    [self _init];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.passwdTextField.secureTextEntry = YES;
    self.againPasswdTextField.secureTextEntry = YES;
}

- (void)_init {
    
    NSString *title = @"注册";
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x65c577);
    [Util setNavTitleWithTitle:title ofVC:self];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"登陆-键盘_03" target:self action:@selector(back) width:10 height:19];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSArray *signalArr = nil;
    signalArr = @[self.nickNameTextField.rac_textSignal,self.passwdTextField.rac_textSignal,self.againPasswdTextField.rac_textSignal];
    self.reigsterForgetPasswdHelper.registerSecondButtonEabledSignal = [RACSignal combineLatest:signalArr reduce:^id(NSString *nickName,NSString *passwd,NSString *againPasswd){
        if (!IsEmpty(nickName) && !IsEmpty(passwd)&& !IsEmpty(againPasswd)) {
            return @1;
        }{
            return @0;
        }
    }];
    
    [self.reigsterForgetPasswdHelper.registerSecondButtonEabledSignal subscribeNext:^(NSNumber* value) {
        if (value.integerValue) {
            self.registerButton.alpha = 1.0;
        }else{
            self.registerButton.alpha = 0.5;
        }
    }];
    
    RAC(self.registerButton,enabled) = self.reigsterForgetPasswdHelper.registerSecondButtonEabledSignal;
}



-(void)_registerOrForgetPasswdLogic {
    

        NSString *inputVaryFyStr = nil;
        inputVaryFyStr = [self.reigsterForgetPasswdHelper registerSecondStepVaryfyNickName:self.nickNameTextField.text passwd:self.passwdTextField.text againPasswd:self.againPasswdTextField.text];
        if (inputVaryFyStr) {//输入错误
            [Util ShowAlertWithOnlyMessage:inputVaryFyStr];
        }else {
            MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hub.labelText = @"正在注册。。";
            
            [self.reigsterForgetPasswdHelper beginRisterWithNickName:self.nickNameTextField.text phoneNumber:self.phoneNumber veryCode:self.varyCode passwd:self.passwdTextField.text success:^(NSString *sucessToken) {
                hub.labelText = @"注册成功,正在登录。。";
                //调登录接口
                [self.reigsterForgetPasswdHelper beginLoginWithAccoutName:self.phoneNumber passwd:self.passwdTextField.text success:^(NSString *sucessToken) {
                    [hub hide:YES];
                    [self _enterMainPage];

                } failed:^(NSString *failedStr) {
                    [hub hide:YES];
                    [Util ShowAlertWithOnlyMessage:failedStr];
                }];

            } failed:^(NSString *failedStr) {
                [hub hide:YES];
                if (!failedStr) {
                    failedStr = @"注册失败";
                }
                [Util ShowAlertWithOnlyMessage:failedStr];

            }];
            
        }

}

-(void)_enterMainPage {
    
    AcceptOrdeController *mainPage = [[AcceptOrdeController alloc] init];
    XKJHNavRootController *rootNavi = [[XKJHNavRootController alloc] initWithRootViewController:mainPage];
    [UIApplication sharedApplication].keyWindow.rootViewController = rootNavi;
}

- (void)_createUI {
    
    NSArray *imgNameArr = nil;
    NSArray *textArr = nil;
    imgNameArr = @[@"nickNameIcon",@"忘记密码_12",@"忘记密码_12"];
    textArr = @[@"请输入您的昵称",@"请输入密码",@"请再次输入密码"];
    UIView *topView = self.view;
    for (NSInteger i=0; i<textArr.count; i++) {
        UIView *bgView = [UIView new];
        [self.view addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            if (i==0) {
                make.top.mas_equalTo(topView);
            }else{
                make.top.mas_equalTo(topView.mas_bottom);
            }
            make.height.mas_equalTo(59);
        }];
        
        //左边imgView
        UIImageView *leftImgView = [XKO_CreateUIViewHelper createUIImageViewWithImageName:imgNameArr[i]];
        [bgView addSubview:leftImgView];
        [leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 25));
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(bgView);
        }];
        
        //输入框
        UITextField *inputTextField = [UITextField new];
        [bgView addSubview:inputTextField];
        [inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftImgView.mas_right).with.offset(40);
            make.size.mas_equalTo(CGSizeMake(200, 40));
            make.centerY.mas_equalTo(bgView);
        }];
        inputTextField.placeholder = textArr[i];
        
        UIView *seperateView = [UIView new];
        seperateView.backgroundColor = kGetColor(239, 239, 239);
        [bgView addSubview:seperateView];
        [seperateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.right.bottom.mas_equalTo(bgView);
            
        }];
        
        if ([textArr[i] isEqualToString:@"请输入密码"]) {
            self.passwdTextField = inputTextField;
        }else if ([textArr[i] isEqualToString:@"请再次输入密码"]){
            self.againPasswdTextField = inputTextField;
        }else if ([textArr[i] isEqualToString:@"请输入您的昵称"]){
            self.nickNameTextField = inputTextField;
        }
        topView = bgView;
    }
    
    NSString *title = @"注册";
    self.registerButton= [XKO_CreateUIViewHelper createUIButtonWithTitle:title titleColor:kWhiteColor titleFont:[UIFont CustomFontOfSize:15.0] backgroundColor:kGetColor(152, 215, 168) hasRadius:YES targetSelector:@selector(beginRegister:) target:self];
    [self.registerButton setBackgroundImage:IMAGE(@"登陆_13") forState:UIControlStateNormal];
    self.registerButton.layer.cornerRadius = 20.0;
    [self.view addSubview:self.registerButton];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).with.offset(35);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
    }];
}

#pragma mark ----------------------- Action Method -----------------------
#pragma mark - 注册或忘记密码
-(void)beginRegister:(UIButton *)button {
    
    [self _registerOrForgetPasswdLogic];
}

-(LoginRegisterHelper *)reigsterForgetPasswdHelper {
    
    if (!_reigsterForgetPasswdHelper) {
        _reigsterForgetPasswdHelper = [[LoginRegisterHelper alloc] init];
    }
    return _reigsterForgetPasswdHelper;
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end

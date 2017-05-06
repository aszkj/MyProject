//
//  RigisterForgetPasswdController.m
//  weimi
//
//  Created by 张康健 on 16/1/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "RigisterForgetPasswdController.h"
#import "LoginRegisterHelper.h"
#import "ChatViewController.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "RegisterSecondStepController.h"
#import "UIImage+SizeAndTintColor.h"

@interface RigisterForgetPasswdController ()

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

@implementation RigisterForgetPasswdController

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
    
    if (!IsEmpty(self.phoneNumberString)) {
        self.phoneNumberTextField.text = self.phoneNumberString;
    }
    
    NSString *title = nil;
    if (self.isForgetPasswd) {
        title = @"忘记密码";
    }else{
        title = @"注册";
    }
    self.navigationController.navigationBar.barTintColor = chatStatus_Color;
//    UIImage *orignalImage = [UIImage imageNamed:@"登陆-键盘_03"];
//    orignalImage =  [orignalImage stretchableImageWithLeftCapWidth:30 topCapHeight:10];
    
//    [self.navigationController.navigationBar setBackgroundImage:orignalImage forBarMetrics:0];
    [Util setNavTitleWithTitle:title ofVC:self];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"navigation_back" target:self action:@selector(back) width:10 height:19];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSArray *signalArr = nil;
    if (self.isForgetPasswd) {
        signalArr = @[self.phoneNumberTextField.rac_textSignal,self.veryCodeTextField.rac_textSignal,self.passwdTextField.rac_textSignal,self.againPasswdTextField.rac_textSignal];
        self.reigsterForgetPasswdHelper.registerForgetPasswdButtonEabledSignal = [RACSignal combineLatest:signalArr reduce:^id(NSString *phoneNumber,NSString *veryCode,NSString *passwd,NSString *againPasswd){
            if (!IsEmpty(phoneNumber) && !IsEmpty(veryCode)&&!IsEmpty(passwd) && !IsEmpty(againPasswd) ) {
                return @1;
            }{
                return @0;
            }
        }];
        
    }else{
        signalArr = @[self.phoneNumberTextField.rac_textSignal,self.veryCodeTextField.rac_textSignal];
        self.reigsterForgetPasswdHelper.registerForgetPasswdButtonEabledSignal = [RACSignal combineLatest:signalArr reduce:^id(NSString *phoneNumber,NSString *veryCode){
            if (!IsEmpty(phoneNumber) && !IsEmpty(veryCode)) {
                return @1;
            }{
                return @0;
            }
        }];


    }
    
    [self.reigsterForgetPasswdHelper.registerForgetPasswdButtonEabledSignal subscribeNext:^(NSNumber* value) {
        if (value.integerValue) {
            self.registerButton.alpha = 1.0;
        }else{
            self.registerButton.alpha = 0.5;
        }
    }];
    
    RAC(self.registerButton,enabled) = self.reigsterForgetPasswdHelper.registerForgetPasswdButtonEabledSignal;
}



-(void)_registerOrForgetPasswdLogic {

    if (!self.isForgetPasswd) {
        NSString *inputVaryFyStr = nil;
        inputVaryFyStr = [self.reigsterForgetPasswdHelper regisiterFirstStepVaryfyPhoneNumber:self.phoneNumberTextField.text veryCode:self.veryCodeTextField.text];
        if (inputVaryFyStr) {//输入错误
            [Util ShowAlertWithOnlyMessage:inputVaryFyStr];
        }else {
            //进入第二步注册
            RegisterSecondStepController *registerSecondVC = [[RegisterSecondStepController alloc] init];
            registerSecondVC.phoneNumber = self.phoneNumberTextField.text;
            registerSecondVC.varyCode = self.veryCodeTextField.text;
            [self.navigationController pushViewController:registerSecondVC animated:YES];
        }
    
    }else {//找回密码
        NSString *inputVaryFyStr = nil;
        inputVaryFyStr = [self.reigsterForgetPasswdHelper forgetPasswdInputVaryFyphoneNum:self.phoneNumberTextField.text veryCode:self.veryCodeTextField.text passwd:self.passwdTextField.text againPasswd:self.againPasswdTextField.text];
        if (inputVaryFyStr) {//输入错误
            [Util ShowAlertWithOnlyMessage:inputVaryFyStr];
        }else {
            MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hub.labelText = @"正在找回密码。。";
            [self.reigsterForgetPasswdHelper beginForgetPasswdWithphoneNumber:self.phoneNumberTextField.text veryCode:self.veryCodeTextField.text passwd:self.passwdTextField.text success:^(NSString *sucessToken) {
                hub.labelText = @"找回密码成功";
                [hub hide:YES];
                if (self.forgetPasswdBackBlock) {
                    self.forgetPasswdBackBlock(self.phoneNumberTextField.text,self.passwdTextField.text);
                }
                [self.navigationController popViewControllerAnimated:YES];
            } failed:^(NSString *failedStr) {
                [hub hide:YES];
//                [Util ShowAlertWithOnlyMessage:failedStr];
            }];
            
        }
        
        
    }

}

-(void)_enterMainPage {

    ChatViewController *mainVC = [[ChatViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
}


- (void)_createUI {
    
    NSArray *imgNameArr = nil;
    NSArray *textArr = nil;
    if (self.isForgetPasswd) {
        imgNameArr = @[@"忘记密码_03",@"忘记密码_09",@"忘记密码_12",@"忘记密码_12"];
        textArr = @[@"请输入您的手机号码",@"请输入验证码",@"请输入密码",@"请再次输入密码"];
    }else{
        imgNameArr = @[@"忘记密码_03",@"忘记密码_09",@"忘记密码_12",@"忘记密码_12",@"nickNameIcon"];
        textArr = @[@"请输入您的手机号码",@"请输入验证码"];
    }
    
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
            make.size.mas_equalTo(CGSizeMake(0, 0));
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(bgView);
        }];
        
        //输入框
        UITextField *inputTextField = [UITextField new];
        inputTextField.font = [UIFont customFontOfSize:14.0];
        [bgView addSubview:inputTextField];
        [inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftImgView.mas_right);
            make.right.mas_equalTo(bgView);
            make.height.equalTo(@40);
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
        
        if ([textArr[i] isEqualToString:@"请输入验证码"]) {

            //添加获取验证码button
            UIButton *getVeryCodeButton = [XKO_CreateUIViewHelper createUIButtonWithTitle:@"获取验证码" titleColor:kGetColor(217, 217, 221) titleFont:[UIFont customFontOfSize:11] backgroundColor:kClearColor hasRadius:YES targetSelector:@selector(getVeryCode:) target:self];
            getVeryCodeButton.layer.borderColor = kGetColor(217, 217, 221).CGColor;
            getVeryCodeButton.layer.borderWidth = 1.0;
            getVeryCodeButton.layer.cornerRadius = 15.0;
            [bgView addSubview:getVeryCodeButton];
            self.getVeryCodeButton = getVeryCodeButton;
            self.veryCodeTextField = inputTextField;
            
            [getVeryCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(78, 29));
                make.right.mas_equalTo(-10);
                make.centerY.mas_equalTo(bgView);
            }];
        }
        if ([textArr[i] isEqualToString:@"请输入密码"]) {
            self.passwdTextField = inputTextField;
        }else if ([textArr[i] isEqualToString:@"请再次输入密码"]){
            self.againPasswdTextField = inputTextField;
        }else if ([textArr[i] isEqualToString:@"请输入您的手机号码"]){
            self.phoneNumberTextField = inputTextField;
        }
//        else {
//            self.nickNameTextField = inputTextField;
//        }

        topView = bgView;
    }
    
    NSString *title = @"下一步";
    if (self.isForgetPasswd) {
        title = @"保存";
    }
    self.registerButton= [XKO_CreateUIViewHelper createUIButtonWithTitle:title titleColor:kWhiteColor titleFont:[UIFont customFontOfSize:15.0] backgroundColor:kGetColor(152, 215, 168) hasRadius:YES targetSelector:@selector(beginRegister:) target:self];
    self.registerButton.layer.cornerRadius = 20.0;
    self.registerButton.backgroundColor = chatStatus_Color;
    [self.view addSubview:self.registerButton];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).with.offset(35);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
    }];
    //没有那个什么同意条款按钮
    /*
     
     //    if (!self.isForgetPasswd) {
     //        UILabel *bottonLabel = [XKO_CreateUIViewHelper createLabelWithFont:kSystemFontWithSize(15) fontColor:kGetColor(136, 179, 248) text:@"已阅读并同意<<用户注册协议>>"];
     //        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"已阅读并同意<<用户注册协议>>"];
     //        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(6, content.length-6)];
     //
     //        bottonLabel.attributedText = content;
     //        [self.view addSubview:bottonLabel];
     //        [bottonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
     //            make.top.mas_equalTo(self.registerButton.mas_bottom).with.offset(20);
     //            make.height.mas_equalTo(35);
     //            make.centerX.mas_equalTo(self.view);
     //        }];
     //
     //        self.readButton = [XKO_CreateUIViewHelper createUIButtonWithNormalStateImageName:@"默认-无勾选" selectedStateImgName:@"注册-30s_03"];
     //        [self.view addSubview:self.readButton];
     //        [self.readButton mas_makeConstraints:^(MASConstraintMaker *make) {
     //            make.size.mas_equalTo(CGSizeMake(15, 15));
     //            make.centerY.mas_equalTo(bottonLabel);
     //            make.right.mas_equalTo(bottonLabel.mas_left).with.offset(-2);
     //        }];
     //
     //        WEAK_SELF
     //        [self.readButton addActionHandler:^(NSInteger tag) {
     //            weak_self.readButton.selected = !weak_self.readButton.selected;
     //        }];
     //        
     //    }
     */
    
}

#pragma mark ----------------------- Action Method -----------------------
#pragma mark - 获取验证码
-(void)getVeryCode:(UIButton *)veryCodeButton {

    //发送验证码请求之前先验证手机号码
    NSString *varyPhoneNumberErrorStr = nil;
    varyPhoneNumberErrorStr = [self.reigsterForgetPasswdHelper veryFyPhoneNumber:self.phoneNumberTextField.text];
    if (varyPhoneNumberErrorStr) {
        [Util ShowAlertWithOnlyMessage:varyPhoneNumberErrorStr];
        return;
    }
    
    BOOL isRegister = YES;
    if (self.isForgetPasswd ) {
        isRegister = NO;
    }
    //把验证码button交给helper处理
    self.reigsterForgetPasswdHelper.veryfyButton = self.getVeryCodeButton;
    [self.phoneNumberTextField resignFirstResponder];
    [self.reigsterForgetPasswdHelper requestVeryCodeForRegister:isRegister failed:^(NSString *failedStr) {
        
        if (failedStr) {
//
            [Util ShowAlertWithOnlyMessage:failedStr];
        }
    } success:^(NSString *sucessMessage) {
        
        [Util ShowAlertWithOnlyMessage:sucessMessage];

    }];
}

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end

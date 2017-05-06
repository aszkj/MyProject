//
//  RigisterViewController.m
//  weimi
//
//  Created by ray on 16/2/24.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIView+Design.h"
#import "NSString+Teshuzifu.h"
#import "LoginRegisterHelper.h"
#import "ChatViewController.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *verifyCode;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic) LoginRegisterHelper *reigsterForgetPasswdHelper;

@end

@implementation RegisterViewController

static const CGFloat TextFieldHeight = 41.0f;


- (void)viewDidLoad {
    [super viewDidLoad];

    _reigsterForgetPasswdHelper = [[LoginRegisterHelper alloc] init];
    [self initUI];
    [self setMASContrains];
    [self controlLogic];
}

- (void)controlLogic {
    
    @weakify(self);
    RACSignal *combineSignal =  [RACSignal combineLatest:@[self.nameTextField.rac_textSignal,self.phoneNumber.rac_textSignal,self.verifyCode.rac_textSignal,self.passwordTextField.rac_textSignal] reduce:^id(
                                 NSString * name, NSString *phoneNumber, NSString *verifyCode, NSString *password){
        return @(name.length > 0 && phoneNumber.length > 0 && verifyCode.length > 0 && password.length > 0);
    }];
    RAC(self.registerButton, enabled) = combineSignal;
    [RACObserve(self.registerButton, enabled) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if ([x boolValue]) { self.registerButton.alpha = 1.0; }
        else { self.registerButton.alpha = 0.5; }
    }];
}

#pragma mark - set UI

- (void)setMASContrains {
    for (int i = 0; i < 4; i++) {
        UIView *lineView = [XKO_CreateUIViewHelper lineViewWith:UIColorFromRGB(0xe3e3e3)];
        [self.view addSubview:lineView];
        UIView *referenceView = self.nameTextField;
        switch (i) {
            case 0:
                referenceView = self.nameTextField;
                break;
            case 1:
                referenceView = self.phoneNumber;
                break;
            case 2:
                referenceView = self.verifyCode;
                break;
            case 3:
                referenceView = self.passwordTextField;
                break;
            default:
                break;
        }
        [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@(1/[UIScreen mainScreen].scale));
            make.width.equalTo(self.nameTextField);
            make.bottom.equalTo(referenceView);
            make.left.equalTo(referenceView);
        }];
    }
}

- (void)initUI {
    self.title = @"注册";
    self.navigationController.navigationBar.barTintColor = chatStatus_Color;
    [self setLeftTitles:@[@"呢称",@"手机号码",@"验证码",@"登录密码"] withFields:@[self.nameTextField,self.phoneNumber,self.verifyCode,self.passwordTextField]];
    
    UIButton *exchangeKeyBoardTypeButton = [XKO_CreateUIViewHelper createUIButtonWithNormalStateImageName:@"登陆-键盘-切换_06" selectedStateImgName:@"keyboardShowed"];
    exchangeKeyBoardTypeButton.frame = CGRectMake(0, (TextFieldHeight-19)/2.0, 19, 10.5);
    //点击切换键盘
    __block UIButton *weakButton = exchangeKeyBoardTypeButton;
    WEAK_SELF;
    [exchangeKeyBoardTypeButton addActionHandler:^(NSInteger tag) {
        weak_self.passwordTextField.secureTextEntry = !weak_self.passwordTextField.secureTextEntry;
        weakButton.selected = !weakButton.isSelected;
    }];
    self.passwordTextField.rightView = exchangeKeyBoardTypeButton;
    self.passwordTextField.rightViewMode = UITextFieldViewModeAlways;

    //添加获取验证码button
    UIButton *getVeryCodeButton = [XKO_CreateUIViewHelper createUIButtonWithTitle:@"发送验证码" titleColor:[UIColor whiteColor] titleFont:[UIFont customFontOfSize:12] backgroundColor:UIColorFromRGB(0xfc5814) hasRadius:YES targetSelector:@selector(getVeryCode:) target:self];
    getVeryCodeButton.layer.cornerRadius = 4.0;
    getVeryCodeButton.width = 84;
    getVeryCodeButton.height = 30;
    self.verifyCode.rightViewMode = UITextFieldViewModeAlways;
    self.verifyCode.rightView = getVeryCodeButton;
}

- (void)setLeftTitles:(NSArray<NSString *>*)titleArray withFields:(NSArray<UITextField *> *)fieldArray
{
    __block CGFloat maxWidth = 0.0;
    [titleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat width = [obj sizeForFont:fieldArray.firstObject.font size:CGSizeMake(1000, 1000) mode:NSLineBreakByWordWrapping].width;
        if (maxWidth < width) maxWidth = width;
    }];
    
    [fieldArray enumerateObjectsUsingBlock:^(UITextField * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *leftLabel = [self setLeftTitle:titleArray[idx] withTextField:obj];
        leftLabel.height = TextFieldHeight;
        leftLabel.width = maxWidth + 19;
    }];
}

- (UILabel *)setLeftTitle:(NSString *)title withTextField:(UITextField *)textField {
    UILabel *leftLabel = [XKO_CreateUIViewHelper createLabelWithFont:textField.font fontColor:[UIColor blackColor] text:title];
    [leftLabel sizeToFit];
    textField.leftView = leftLabel;
    textField.leftViewMode = UITextFieldViewModeAlways;
    return leftLabel;
}

#pragma mark - event action

#pragma mark 获取验证码
-(void)getVeryCode:(UIButton *)veryCodeButton {
    
    //发送验证码请求之前先验证手机号码
    NSString *varyPhoneNumberErrorStr = nil;
    varyPhoneNumberErrorStr = [self.reigsterForgetPasswdHelper veryFyPhoneNumber:self.phoneNumber.text];
    if (varyPhoneNumberErrorStr) {
        [Util ShowAlertWithOnlyMessage:varyPhoneNumberErrorStr];
        return;
    }
    
    BOOL isRegister = YES;
    //把验证码button交给helper处理
    self.reigsterForgetPasswdHelper.veryfyButton = veryCodeButton;
    [self.view resignFirstResponder];
    [self.reigsterForgetPasswdHelper requestVeryCodeForRegister:isRegister failed:^(NSString *failedStr) {
        
        if (failedStr) {
            //
            [Util ShowAlertWithOnlyMessage:failedStr];
        }
    } success:^(NSString *sucessMessage) {
        
        [Util ShowAlertWithOnlyMessage:sucessMessage];
        
    }];
}

- (IBAction)registerAction:(id)sender {
    
    NSString *inputVaryFyStr = [self.reigsterForgetPasswdHelper veryFyPhoneNumber:self.phoneNumber.text];
    if (inputVaryFyStr) {
        [Util ShowAlertWithOnlyMessage:inputVaryFyStr];
        return;
    }
    
    inputVaryFyStr = [self.reigsterForgetPasswdHelper registerSecondStepVaryfyNickName:self.nameTextField.text passwd:self.passwordTextField.text againPasswd:self.passwordTextField.text];
    if (inputVaryFyStr) {//输入错误
        [Util ShowAlertWithOnlyMessage:inputVaryFyStr];
    }else {
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hub.labelText = @"正在注册。。";
        
        [self.reigsterForgetPasswdHelper beginRisterWithNickName:self.nameTextField.text phoneNumber:self.phoneNumber.text veryCode:self.verifyCode.text passwd:self.passwordTextField.text success:^(NSString *sucessToken) {
            hub.labelText = @"注册成功,正在登录。。";
            //调登录接口
            [self.reigsterForgetPasswdHelper beginLoginWithAccoutName:self.phoneNumber.text passwd:self.passwordTextField.text success:^(NSString *sucessToken) {
                [hub hide:YES];
                [self _enterMainPage];
                
            } failed:^(NSString *failedStr) {
                [hub hide:YES];
            }];
            
        } failed:^(NSString *failedStr) {
            [hub hide:YES];
            if (!failedStr) {
                failedStr = @"注册失败";
            }            
        }];
        
    }
    
}

-(void)_enterMainPage {
    
    ChatViewController *mainVC = [[ChatViewController alloc] init];
    UINavigationController *naviMain = [[UINavigationController alloc ]initWithRootViewController:mainVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = naviMain;
}

#pragma mark - dyci debug operation
- (void)updateOnClassInjection {
    [self initUI];
    [self setMASContrains];
}

@end

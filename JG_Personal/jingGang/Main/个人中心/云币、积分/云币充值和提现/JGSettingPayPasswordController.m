//
//  JGSettingPayPasswordController.m
//  jingGang
//
//  Created by dengxf on 16/1/11.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import "JGSettingPayPasswordController.h"
#import "GlobeObject.h"
#import "IQKeyboardManager.h"
#import "JGCloudAndValueManager.h"
#import "UIAlertView+Extension.h"
#import "UITextField+Blocks.h"

NSInteger const CountdownSeconds = 60;

@interface JGSettingPayPasswordController ()<UITextFieldDelegate>
/**
 *  手机号码 */
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

/**
 *  验证码输入框 */
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;

/**
 *  新密码输入框 */
@property (weak, nonatomic) IBOutlet UITextField *firstPasswordTextField;

/**
 *  确认密码输入框 */
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

@end

@implementation JGSettingPayPasswordController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    WeakSelf;
    [JGCloudAndValueManager inquiryUserCurrentLoginPhoneNumber:^(NSString *loginName) {
        StrongSelf;
        JGLog(@"login:%@",loginName);
        strongSelf.phoneNumberTextField.text = loginName;
        
    } error:^(NSError *error) {
        JGLog(@"error:%@",error.domain);
    }];
}

- (instancetype)initWithTitile:(NSString *)title {
    if (self = [super init]) {
        [self setupNavBarTitleViewWithText:title];
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化界面
    [self configContent];
}

- (void)configContent {
    // 添加返回键
    [self setupNavBarPopButton];
    self.view.backgroundColor = JGColor(247, 247, 247, 1);
    self.phoneNumberTextField.enabled = NO;
    self.firstPasswordTextField.delegate = self;
    self.firstPasswordTextField.shouldChangeCharactersInRangeBlock = ^(UITextField *textField,NSRange range,NSString *string) {
        //限制输入长度
        NSUInteger loc = range.location;
        if(loc < 6) {
            return YES;
        }else {
            return NO;
        }
    };
    self.confirmPasswordTextField.shouldChangeCharactersInRangeBlock= ^(UITextField *textField,NSRange range,NSString *string) {
        //限制输入长度
        NSUInteger loc = range.location;
        if(loc < 6) {
            return YES;
        }else {
            return NO;
        }
    };
}

// 发送验证码
- (IBAction)sendVerificationCodeAction:(id)sender {
    if ([self validateNumberWithPhoneNumber:self.phoneNumberTextField.text]) {
        [JGCloudAndValueManager sendMsmToPhoneValidateWithPhoneNumber:self.phoneNumberTextField.text success:^(NSString *msg) {
            [sender startTime:CountdownSeconds title:@"重新发送" waitTittle:@"s"];
            [UIAlertView xf_showWithTitle:@"提示" message:msg delay:0.75 onDismiss:^{
            }];
        } fail:^{
            [UIAlertView xf_showWithTitle:@"提示" message:@"短信发送失败" delay:0.75 onDismiss:^{
            }];
        }];
    }
}


/**
 *  确认设置密码
 */
- (IBAction)sureSettingPasswordAction:(id)sender {
    BOOL ret = [self validateTextfieldEquitable];
    if (ret) {
        // 调用设置云币提现密码接口
        WeakSelf;
        [JGCloudAndValueManager st_userCashPayPasswordWithPswd:self.firstPasswordTextField.text valiteCode:self.verifyCodeTextField.text success:^(CloudBuyerMoneyPasswordSaveResponse *response) {
            [UIAlertView xf_showWithTitle:response.subMsg message:nil delay:1.5 onDismiss:^{
                [bself.navigationController popViewControllerAnimated:YES];
            }];
        } error:^(NSError *error) {
            [UIAlertView xf_showWithTitle:error.domain message:nil delay:1.5 onDismiss:^{
                
            }];
        }];
    }else {
        JGLog(@"信息不完整");
    }
}

/**
 *  确认信息是否填写完整 */
- (BOOL)validateTextfieldEquitable {
    if (self.verifyCodeTextField.text.length <= 0 || self.firstPasswordTextField.text.length <= 0 || self.confirmPasswordTextField.text.length <= 0 ) {
        return NO;
    }
    if ([self.firstPasswordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
        return YES;
    }
    return NO;
}


@end

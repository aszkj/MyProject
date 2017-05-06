//
//  ChangYunbiPasswordViewController.m
//  Merchants_JingGang
//
//  Created by ray on 15/9/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "ChangYunbiPasswordViewController.h"
#import "ChangePasswordViewModel.h"

@interface ChangYunbiPasswordViewController ()<UIAlertViewDelegate>

@property (nonatomic) ChangePasswordViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIButton *verificationButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *verrificationCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordAgainTextField;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic) UIButton *confirmButton;

@end

@implementation ChangYunbiPasswordViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.confirmButton];
    [self.viewModel.usrInfoCommand execute:nil];
}

- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self);
    RAC(self.phoneNumberTextField,text) = RACObserve(self.viewModel, phoneNumber);
    RAC(self.viewModel,varificationCode) = self.verrificationCodeTextField.rac_textSignal;
    RAC(self.viewModel,password) = self.passwordTextField.rac_textSignal;
    RAC(self.viewModel,passwordAgain) = self.passwordAgainTextField.rac_textSignal;
    RAC(self.countLabel,text) = RACObserve(self.viewModel, sendCodeString);
    RAC(self.countLabel,hidden) = [RACObserve(self.viewModel, sendCodeString) map:^id(NSString *string) {
        return @(!string.length > 0);
    }];
    
    RAC(self.submitButton,hidden) = [RACObserve(self,isComfromPayPage) map:^id(NSNumber* value) {
        return (value.integerValue) ? @(NO):@(YES);
    }];
    self.verificationButton.rac_command = self.viewModel.varifyCommand;
    [[self.viewModel.varifyCommand.executionSignals switchToLatest] subscribeNext:^(id x) {
        @strongify(self)
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"发送验证码成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterView show];
    }];
    [[self.viewModel.changePasswordCommand.executionSignals switchToLatest] subscribeNext:^(id x) {
        @strongify(self)
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"修改支付密码成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alterView.tag = 1000;
        [alterView show];
    }];
}

-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - event response
- (void)changeAction {
    [self.viewModel.changePasswordCommand execute:nil];
}
- (IBAction)submitAction:(id)sender {
    [self.view endEditing:YES];
    [self changeAction];
    
}

#pragma mark - AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (!buttonIndex && alertView.tag == 1000 ) {
        [self.view endEditing:YES];
        if (self.changeYunbiPasswdSuccess) {
            self.changeYunbiPasswdSuccess();
            [self performSelector:@selector(back) withObject:nil afterDelay:1.2f];
        }
    }
    
}

#pragma mark - CustomDelegate


#pragma mark - private methods
- (void)setUIAppearance {
    [super setUIAppearance];
    self.verrificationCodeTextField.keyboardType = UIKeyboardTypePhonePad;
}

#pragma mark - getters and settters
- (ChangePasswordViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[ChangePasswordViewModel alloc] init];
    }
    return _viewModel;
}
/**
 *  重写返回方法，因为返回的时候不知道为什么设置页面整体会下降需要代理通知设置回来
 */
- (void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    if([self.delegate respondsToSelector:@selector(nofiticationPopChangYunbiPasswordView)]){
        [self.delegate nofiticationPopChangYunbiPasswordView];
    }
}
#pragma mark - debug operation
- (void)updateOnClassInjection {
    
}
#pragma mark - getters and settters

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.frame = CGRectMake(0, 0, 40, 35);
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(changeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


@end

//
//  ChangYunbiPasswordViewController.m
//  Merchants_JingGang
//
//  Created by ray on 15/9/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "ChangYunbiPasswordViewController.h"
#import "ChangePasswordViewModel.h"

@interface ChangYunbiPasswordViewController ()

@property (nonatomic) ChangePasswordViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *verificationButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *verrificationCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordAgainTextField;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation ChangYunbiPasswordViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewsMASConstraint];
    [self.viewModel.usrInfoCommand execute:nil];
}

- (void)bindViewModel {
    [super bindViewModel];
//    @weakify(self);
    RAC(self.phoneNumberTextField,text) = RACObserve(self.viewModel, phoneNumber);
    RAC(self.viewModel,varificationCode) = self.verrificationCodeTextField.rac_textSignal;
    RAC(self.viewModel,password) = self.passwordTextField.rac_textSignal;
    RAC(self.viewModel,passwordAgain) = self.passwordAgainTextField.rac_textSignal;
    RAC(self.countLabel,text) = RACObserve(self.viewModel, sendCodeString);
    RAC(self.countLabel,hidden) = [RACObserve(self.viewModel, sendCodeString) map:^id(NSString *string) {
        return @(!string.length > 0);
    }];
    self.verificationButton.rac_command = self.viewModel.varifyCommand;
    self.saveButton.rac_command = self.viewModel.changePasswordCommand;
    [[self.viewModel.varifyCommand.executionSignals switchToLatest] subscribeNext:^(id x) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"发送验证码成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterView show];
    }];
    [[self.viewModel.changePasswordCommand.executionSignals switchToLatest] subscribeNext:^(id x) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"修改支付密码成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterView show];
    }];
}

#pragma mark - event response


#pragma mark - CustomDelegate


#pragma mark - private methods
- (void)setUIAppearance {
    [super setUIAppearance];
    self.verrificationCodeTextField.keyboardType = UIKeyboardTypePhonePad;
}

- (void)setViewsMASConstraint {
    
}

#pragma mark - getters and settters
- (ChangePasswordViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[ChangePasswordViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - debug operation
- (void)updateOnClassInjection {
    
}


@end

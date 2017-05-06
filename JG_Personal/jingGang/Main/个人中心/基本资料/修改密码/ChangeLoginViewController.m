//
//  ChangeLoginViewController.m
//  jingGang
//
//  Created by ray on 15/11/24.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "ChangeLoginViewController.h"
#import "changeLoginViewModel.h"
#import "APIManager+Helper.h"

@interface ChangeLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UITextField *updatePassword;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
@property (nonatomic) UIButton *confirmButton;
//@property (nonatomic) changeLoginViewModel *viewModel;

@end

@implementation ChangeLoginViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.confirmButton];
    self.navigationItem.title = @"修改密码";
}

//- (void)bindViewModel {
//    [super bindViewModel];
//    @weakify(self)
//    RAC(self.viewModel, oldPassword) = self.oldPassword.rac_textSignal;
//    RAC(self.viewModel, updatePassword) = self.updatePassword.rac_textSignal;
//    RAC(self.viewModel, confirmPassword) = self.confirmPassword.rac_textSignal;
//    [[[[self.viewModel updatePasswordCommand] executionSignals] switchToLatest] subscribeNext:^(id x) {
//        @strongify(self)
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改密码成功" message:nil delegate:self cancelButtonTitle:Nil otherButtonTitles:@"确定", nil];
//        [alertView show];
//    }];
//}

//- (changeLoginViewModel *)viewModel {
//    if (_viewModel == nil) {
//        _viewModel = [[changeLoginViewModel alloc] init];
//    }
//    return _viewModel;
//}

static inline BOOL isNewEmpty(id thing) {
    
    return thing == nil || [thing isEqual:[NSNull null]]
    
    || ([thing respondsToSelector:@selector(length)]
        
        && [(NSData *)thing length] == 0)
    
    || ([thing respondsToSelector:@selector(count)]
        
        && [(NSArray *)thing count] == 0);
    
}


#pragma mark - event response
- (void)changeActions {

    [self.view endEditing:YES];
    if(self.oldPassword.text.length == 0){
        [MBProgressHUD showSuccess:@"请输入原密码" toView:self.view delay:1];
        return;
    }else if (self.updatePassword.text.length == 0){
        [MBProgressHUD showSuccess:@"请输入新密码" toView:self.view delay:1];
        return;
    }else if (self.confirmPassword.text.length == 0){
        [MBProgressHUD showSuccess:@"请输入确认新密码" toView:self.view delay:1];
        return;
    }else if (self.updatePassword.text.length < 6){
        [MBProgressHUD showSuccess:@"密码不能小于6位" toView:self.view delay:1];
        return;
    }else if (![self.updatePassword.text isEqualToString:self.confirmPassword.text]){
        [MBProgressHUD showSuccess:@"新密码与确认密码不一致" toView:self.view delay:1];
        return;
    }
    [self updataUserPassWordRequest];
}

- (void)updataUserPassWordRequest
{
    WEAK_SELF
    UsersPasswordUpdateRequest *request = [[UsersPasswordUpdateRequest alloc] init:GetToken];
    request.api_newPassword = self.updatePassword.text;
    request.api_odlPassword = self.oldPassword.text;
    [self.vapiManager usersPasswordUpdate:request success:^(AFHTTPRequestOperation *operation, UsersPasswordUpdateResponse *response) {
        
        if (isNewEmpty(response.errorCode)) {
            // 修改成功
            [MBProgressHUD showSuccess:@"修改成功" toView:weak_self.view delay:1];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                if([weak_self.delegate respondsToSelector:@selector(nofiticationPopChangeLoginView)]){
                    [weak_self.delegate nofiticationPopChangeLoginView];
                }
            });
        }else {
            [MBProgressHUD showSuccess:response.subMsg toView:weak_self.view delay:1];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误,请检查网络" toView:weak_self.view delay:1];
    }];
}
            
            

#pragma mark - CustomDelegate


#pragma mark - private methods


- (void)setUIAppearance {
    [super setUIAppearance];
}

- (void)setViewsMASConstraint {
    
}

#pragma mark - getters and settters



#pragma mark - debug operation
- (void)updateOnClassInjection {
    self.oldPassword.text = @"123456789123";
    self.oldPassword.secureTextEntry = NO;
}

/**
 *  重写返回方法，因为返回的时候不知道为什么设置页面整体会下降需要代理通知设置回来
 */
- (void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    if([self.delegate respondsToSelector:@selector(nofiticationPopChangeLoginView)]){
        [self.delegate nofiticationPopChangeLoginView];
    }
}
- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.frame = CGRectMake(0, 0, 40, 35);
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(changeActions) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}




@end

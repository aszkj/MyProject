//
//  DLChangePasswordVC.m
//  YilidiBuyer
//
//  Created by yld on 16/6/2.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLChangePasswordVC.h"
#import "Util.h"
#import "DLRequestUrl.h"
@interface DLChangePasswordVC ()
@property (weak, nonatomic) IBOutlet UITextField *oldPassWord;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassWord;

@end

@implementation DLChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"修改密码";
    [self _init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------------Init---------------------------------
- (void)_init {

    [_oldPassWord addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_passWord addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_confirmPassWord addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}
#pragma mark ------------------------Private-------------------------
- (void)_textFieldDidChange:(UITextField *)textField
{
    if (textField == self.oldPassWord||textField == self.passWord||textField == self.confirmPassWord) {
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
}


#pragma mark ------------------------Api----------------------------------
- (void)requestData {
    
    
    NSDictionary *parameters = @{@"oldPassword":self.oldPassWord.text,@"password":self.passWord.text};
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:parameters subUrl:kUrl_Changepassword block:^(NSDictionary *resultDic, NSError *error) {
        if (error.code!=1) {
            [self hideLoadingHub];
        }else{
        
            [self hideHubForText:@"修改成功"];
            [self performSelector:@selector(_back) withObject:nil afterDelay:1.0f];
        }
    }];
    
}

#pragma mark ------------------------Page Navigate---------------------------
- (void)_back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ------------------------View Event---------------------------
- (IBAction)changePassWordClick:(id)sender {
    if (_oldPassWord.text.length==0) {
        [self showSimplyAlertWithTitle:@"提示" message:@"请输入旧密码" sureAction:^(UIAlertAction *action) {
            
        }];
        return;
    }
    if (_passWord.text.length==0) {
    
        [self showSimplyAlertWithTitle:@"提示" message:@"请输入新密码" sureAction:^(UIAlertAction *action) {
            
        }];
        return;
    }
    if (_confirmPassWord.text.length==0) {
        
        [self showSimplyAlertWithTitle:@"提示" message:@"请再次输入新密码" sureAction:^(UIAlertAction *action) {
            
        }];
        return;
    }
    
    if (![_passWord.text isEqualToString:_confirmPassWord.text]){
        [self showSimplyAlertWithTitle:@"提示" message:@"两次密码输入不一致" sureAction:^(UIAlertAction *action) {
            
        }];
        return;
    }
    
    
    if (![Util isNull:_passWord.text]||![Util isNull:_confirmPassWord.text]) {
        
        [Util ShowAlertWithOnlyMessage:@"输入的密码不能包含空格"];
        return;
    }
    
//    if (![Util  checkPassWord:_oldPassWord.text]&&![Util  checkPassWord:_passWord.text]&&![Util  checkPassWord:_oldPassWord.text]) {
//        [self showSimplyAlertWithTitle:@"提示" message:@"密码由6-16位字母,数字或符号组成" sureAction:^(UIAlertAction *action) {
//            
//        }];
//        return;
//    }else if (![_passWord.text isEqualToString:_confirmPassWord.text]){
//        [self showSimplyAlertWithTitle:@"提示" message:@"两次密码输入不一致" sureAction:^(UIAlertAction *action) {
//            
//        }];
//        return;
//    }else{
    
    
        [self requestData];
//    }
    
    
}


#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------


@end

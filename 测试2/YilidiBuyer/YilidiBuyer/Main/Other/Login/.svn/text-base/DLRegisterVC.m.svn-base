//
//  DLRegisterVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLRegisterVC.h"
#import "JKCountDownButton.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "ProjectRelativeDefineNotification.h"
#import "GlobleConst.h"
#import "ShopCartGoodsManager.h"
#import "DLRegisterVC.h"
#import "ShopCartGoodsManager+updateShopCart.h"
#import "CommunityDataManager.h"
#import "GlobleConst.h"
#import "ProjectRelativeDefineNotification.h"
#import "NSArray+SUIAdditions.h"
#import "DLShopCarVC.h"
#import "DLUserInfoModel.h"
#import "UserDataManager.h"
#import "DLMainTabBarController.h"
#import "Util.h"

@interface DLRegisterVC ()<UITextFieldDelegate>
{
    BOOL endBtn;
}
@property (weak, nonatomic) IBOutlet JKCountDownButton *verificationCodeButton;

@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (nonatomic,assign)ComeToLoginPageType comeToLoginPageType;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *recommendedCodeField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassWord;

@property (weak, nonatomic) IBOutlet UIButton *agreementButton;

@end

@implementation DLRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"手机注册";
    
    [self _init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark ------------------------Init---------------------------------
- (void)_init{

    [_phoneField addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_codeField addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_passwordField addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_confirmPassWord addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark ------------------------Private-------------------------
- (void)_textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phoneField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    if (textField == self.codeField) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
    
    if (textField == self.passwordField) {
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
    
    if (textField == self.confirmPassWord) {
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
}


- (IBAction)registerAndLoginClick:(id)sender {
    if (_phoneField.text.length ==0) {
        
        
        [Util ShowAlertWithOnlyMessage:@"请输入手机号"];
        
        return;
    }
    if (_codeField.text.length ==0) {
        
       
        [Util ShowAlertWithOnlyMessage:@"请输入验证码"];
        return;
    }
    
    if (![_passwordField.text isEqualToString:_confirmPassWord.text]) {
       
        [Util ShowAlertWithOnlyMessage:@"输入的两次密码不一致"];
        return;
    }
    
    if (![Util isNull:_passwordField.text]||![Util isNull:_confirmPassWord.text]) {
       
        [Util ShowAlertWithOnlyMessage:@"输入的密码不能包含空格"];
        return;
    }
    
    //    if (_passwordField.text.length ==0) {
    //        [self showSimplyAlertWithTitle:@"提示" message:@"请设置登录密码" sureAction:^(UIAlertAction *action) {
    //
    //        }];
    //
    //
    //        return;
    //    }
    //
    //
    //    if (![Util   isValidateMobile:_phoneField.text]) {
    //        [self showSimplyAlertWithTitle:@"提示" message:@"手机号格式错误" sureAction:^(UIAlertAction *action) {
    //
    //        }];
    //
    //        return;
    //    }
    //
    //    if (![Util  checkPassWord:_passwordField.text]) {
    //        [self showSimplyAlertWithTitle:@"提示" message:@"密码由6-16位字母,数字或符号组成" sureAction:^(UIAlertAction *action) {
    //
    //        }];
    //        return;
    //    }
    
//    if (_agreementButton.selected==NO) {
//        [self showSimplyAlertWithTitle:@"提示" message:@"请阅读并勾选协议" sureAction:^(UIAlertAction *action) {
//            
//        }];
//        return;
//    }
    
    
    
    [self _postData];
}


#pragma mark ------------------------Api----------------------------------
//获取验证码
- (void)getVerification {
  
    
    [self showLoadingHub];
    
    [AFNHttpRequestOPManager requestVaryCodeForPhoneNumber:self.phoneField.text varyCodeType:KTypeLoginPassword block:^(id result, NSError *error) {
        if (error.code!=1) {
            [self hideLoadingHub];
            
//            [_verificationCodeButton startWithSecond:CountDown];
            
            return;
        }
        
        [self hideLoadingHub];
    }];
    
  
    

    
}

- (void)_requestLogin {
    [self showLoadingHubWithText:@"注册成功，正在登录.."];
    [self.phoneField resignFirstResponder];
    [self.codeField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.recommendedCodeField resignFirstResponder];
    [self.confirmPassWord resignFirstResponder];
    WEAK_SELF
    [AFNHttpRequestOPManager loginWithAcount:self.phoneField.text passwd:self.passwordField.text block:^(id result, NSError *error) {
       
        if (error.code==1) {
            [weak_self hideHubForText:@"登录成功"];
            
            JLog(@"rrsult%@",result[@"entity"]);
            
            if (isEmpty(result[EntityKey])) {
                return ;
            }else{
                NSString *vipExpireDate;
                if (isEmpty(result[EntityKey][@"vipExpireDate"])) {
                    JLog(@".....");
                    vipExpireDate = @"";
                }else{
                    vipExpireDate = result[EntityKey][@"vipExpireDate"];
                    
                }
                NSString *nickName;
                if (isEmpty(result[EntityKey][@"nickName"])) {
                    JLog(@".....");
                    nickName = @"";
                }else{
                    nickName = result[EntityKey][@"nickName"];
                    
                }
                
                NSDictionary*dic = @{@"nickName":nickName,@"userImageUrl":result[EntityKey][@"userImageUrl"],@"userName":result[EntityKey][@"userName"],@"vipExpireDate":vipExpireDate,@"memberType":result[EntityKey][@"memberType"],@"userId":result[EntityKey][@"userId"]};
                
                [kUserDefaults setObject:dic forKey:KUserInfoKey];
                [kUserDefaults synchronize];
                
                [kNotification postNotificationName:KNofiticationLogIn object:nil];

                [weak_self _leaveLoginPage];
            }
            
        }else{
            
            [weak_self hideLoadingHub];
        }
       
    }];
    
}





- (void)_leaveLoginPage {
    

    [self performSelector:@selector(_enterMain) withObject:nil afterDelay:1.0f];
   
    
}

- (void)_enterMain {
    DLMainTabBarController *mainVC = [[DLMainTabBarController alloc]init];
    [mainVC setTabIndex:0];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
}
#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------
- (IBAction)getVerificationCode:(JKCountDownButton *)sender {
    BOOL phone = [Util   isValidateMobile:_phoneField.text];
    if (_phoneField.text.length ==0) {
        
        [self showSimplyAlertWithTitle:@"提示" message:@"请输入手机号" sureAction:^(UIAlertAction *action) {
            
        }];
       
        
    }else {
        if (!phone) {
            [self showSimplyAlertWithTitle:@"提示" message:@"手机号格式错误" sureAction:^(UIAlertAction *action) {
                
            }];
            
            
        }else {
            sender.backgroundColor = kGetColor(171.0, 171.0, 171.0);
            sender.enabled = NO;
            
            //button type要 设置成custom 否则会闪动
            
            [self getVerification];//发送请求
            
            [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                NSString *title = [NSString stringWithFormat:@"(%d)重新获取",second];
                return title;
            }];
            [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                countDownButton.enabled = YES;
                return @"重新获取";
                
            }];
        }
    }

}



- (IBAction)agreementBtnClcik:(id)sender {
    _agreementButton.selected = !_agreementButton.selected;
}




- (void)_postData {
    [self showLoadingHub];
     NSDictionary *parameters = @{@"mobile":self.phoneField.text,@"code":self.codeField.text,@"password":self.passwordField.text,@"invitationCode":self.recommendedCodeField.text};
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:parameters subUrl:kUrl_Regist block:^(NSDictionary *resultDic, NSError *error) {
        JLog(@"sss:%@",resultDic[@"msg"]);
        
        if (error.code ==1) {
            [weak_self _requestLogin];
            
        }else{
            [weak_self hideLoadingHub];
        }
        
    }];
}

#pragma mark ------------------------Delegate-----------------------------




#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

@end

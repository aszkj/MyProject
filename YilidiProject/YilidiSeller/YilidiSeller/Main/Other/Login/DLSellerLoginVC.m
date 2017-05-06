//
//  DLBuyerLoginVC.m
//  YilidiBuyer
//
//  Created by yld on 16/4/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLSellerLoginVC.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "DLCodeLoginVC.h"
#import "DLFindPasswordVC.h"
#import "DLBaseNavController.h"
#import "GlobleConst.h"
#import "Util.h"
#import "DLRequestUrl.h"
#import "DLHomePageVC.h"
#import "ProjectStandardUIDefineConst.h"
@interface DLSellerLoginVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *paswdTextFiled;




@end

@implementation DLSellerLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _init];
   
}

#pragma mark ------------------------Init--------------------------------
-(void)_init {
    
    self.pageTitle = @"登录";
    [self _initItemButton];
   
}


#pragma mark -------------------Private---------------------
- (void)_initItemButton {

    self.navigationItem.leftBarButtonItem=nil;
    
    
    UIBarButtonItem *rightItem = [UIBarButtonItem initWithTitle:@"找回密码" titleColor:KTextColor target:self action:@selector(_rightClick)];
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem barButtonItemSpace:-12],rightItem];
    
    [_accountTextField addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_paswdTextFiled addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}
- (void)_textFieldDidChange:(UITextField *)textField
{
    if (textField == self.accountTextField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    if (textField == self.paswdTextFiled) {
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
}

- (void)_enterMain {
    DLHomePageVC *homeVC = [[DLHomePageVC alloc] init];
    DLBaseNavController *homeNav = [[DLBaseNavController alloc] initWithRootViewController:homeVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = homeNav;
    
     NSString *usertoken = [kUserDefaults objectForKey:SELLERTOKEN];
     NSString *userclientId = [kUserDefaults objectForKey:CLIENTID];
    if (usertoken!=nil && userclientId!=nil) {
    
        //同步token
        [AFNHttpRequestOPManager postWithParameters:@{@"deviceToken":usertoken,@"clientId":userclientId} subUrl:kUrl_SaveClientid block:^(NSDictionary *resultDic, NSError *error) {
            
            if (error.code==1) {
                [kUserDefaults setObject:usertoken forKey:SELLERTOKEN];
                [kUserDefaults synchronize];
                
                [kUserDefaults setObject:userclientId forKey:CLIENTID];
                [kUserDefaults synchronize];
                
            }
        }];

    }
}

- (void)_rightClick {
    DLFindPasswordVC *findVC = [[DLFindPasswordVC alloc]init];
    [self navigatePushViewController:findVC animate:YES];
    
}

#pragma mark ------------------------Api----------------------------------
- (void)requestLogin {
    
    [self showLoadingHubWithText:@"正在登录.."];
    
    [AFNHttpRequestOPManager loginWithAcount:self.accountTextField.text passwd:self.paswdTextFiled.text block:^(id result, NSError *error) {
        if (error.code==1) {
            if (isEmpty(result[EntityKey])) {
                [self hideHubForText:@"登录成功"];
                return;
                
            }else{
                
                NSString *invitationCode;
                if (isEmpty(result[EntityKey][@"invitationCode"])) {
                    invitationCode = @"";
                }else{
                    
                    invitationCode = result[EntityKey][@"invitationCode"];
                }
                
                NSString *userImageUrl;
                if (isEmpty(result[EntityKey][@"userImageUrl"])) {
                    userImageUrl = @"";
                }else{
                    
                    userImageUrl = result[EntityKey][@"userImageUrl"];
                }
                
                
                
                NSDictionary *loginDic =  @{@"beginBusinessHours":result[EntityKey][@"beginBusinessHours"],@"endBusinessHours":result[EntityKey][@"endBusinessHours"],@"storeName":result[EntityKey][@"storeName"],@"userMobile":result[EntityKey][@"userMobile"],@"userName":result[EntityKey][@"userName"],@"invitationCode":invitationCode,@"userImageUrl":userImageUrl,@"latitude":result[EntityKey][@"latitude"],@"longitude":result[EntityKey][@"longitude"],@"addressDetail":result[EntityKey][@"addressDetail"]};
                
                NSNumber *shareFlag = result[EntityKey][@"shareFlag"];
                [kUserDefaults setObject:shareFlag forKey:KShareStockKey];
                [kUserDefaults synchronize];
                
                
                [kUserDefaults setObject:loginDic forKey:HomeResponeData];
                [kUserDefaults synchronize];
                
                
                
                
                NSLog(@"result%@",result);
                [self hideHubForText:@"登录成功"];
                [self performSelector:@selector(_enterMain) withObject:nil afterDelay:1.0f];
                
               
                
                
                
            }

        }else{
        
            [self hideLoadingHub];
        }
        
        
    }];
    
}


#pragma mark ------------------------View Event---------------------------
- (IBAction)loginAction:(id)sender {
    
    [self.paswdTextFiled resignFirstResponder];
    [self.accountTextField resignFirstResponder];
    
    if (_accountTextField.text.length==0) {
       
        
        [Util ShowAlertWithOnlyMessage:@"请输入手机号"];
        
    }else if (_paswdTextFiled.text.length==0){
      
        [Util ShowAlertWithOnlyMessage:@"请输入密码"];
    }else{
//        if (![Util   isValidateMobile:_accountTextField.text]) {
//            [self showSimplyAlertWithTitle:@"提示" message:@"手机号格式错误" sureAction:^(UIAlertAction *action) {
//                
//            }];
//        }else if (![Util checkPassWord:_paswdTextFiled.text ]){
//            [self showSimplyAlertWithTitle:@"提示" message:@"密码格式错误" sureAction:^(UIAlertAction *action) {
//                
//            }];
//            
//        }else{
        
            [self requestLogin];
//        }
        
    }
    
}




- (IBAction)codeLogin:(UIButton *)sender {
    DLCodeLoginVC *codeLoginVC = [[DLCodeLoginVC alloc]init];
    [self navigatePushViewController:codeLoginVC animate:YES];
}


- (IBAction)secureTextBtnClick:(UIButton *)sender {

    if ((sender.selected =! sender.selected)) {
        self.paswdTextFiled.secureTextEntry = NO;
    }else{
        self.paswdTextFiled.secureTextEntry = YES;
    }
    
    
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------


@end

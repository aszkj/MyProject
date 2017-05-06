//
//  DLCodeLoginVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLCodeLoginVC.h"
#import "JKCountDownButton.h"
#import "GlobleConst.h"
#import "AFNHttpRequestOPManager.h"
#import "DLRequestUrl.h"
#import "Util.h"
#import "GlobeMaco.h"
#import "DLHomePageVC.h"
#import "DLBaseNavController.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
@interface DLCodeLoginVC (){

    BOOL endBtn;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet JKCountDownButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation DLCodeLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"登录";
    [self _init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ------------------------Init---------------------------------
- (void)_init{

//    _getCodeButton.layer.borderColor = [UIColor clearColor].CGColor;
    [_phoneField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(FindAction:) name:@"CodeLoginValue" object:nil];
}
#pragma mark ------------------------Private-------------------------


#pragma mark ------------------------Api----------------------------------
- (void)getVerification {
    
    [self showLoadingHub];
    WEAK_SELF
    [AFNHttpRequestOPManager requestVaryCodeForPhoneNumber:self.phoneField.text varyCodeType:KTypeLoginPassword block:^(id result, NSError *error) {
        if (error.code==1) {
            [weak_self.getCodeButton startWithSecond:[result[EntityKey][@"remainClock"]intValue]];
            
        }
            
            [weak_self hideLoadingHub];
        
        
    }];
  

    
}

- (void)requestLogin {
    
    [self.phoneField resignFirstResponder];
    [self.codeField resignFirstResponder];
    
    [self showLoadingHubWithText:@"正在登录.."];
    
    
    [AFNHttpRequestOPManager loginWithPhoneNumber:self.phoneField.text varyCode:self.codeField.text block:^(id result, NSError *error) {
        if (error.code==1) {
            
            if (isEmpty(result[EntityKey])) {
                [self hideLoadingHub];
                return ;
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

#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------
- (IBAction)countDownCode:(JKCountDownButton *)sender {
    if (!endBtn) {
       
        
        [Util ShowAlertWithOnlyMessage:@"手机号格式错误"];
        
        return;
    }
//    sender.backgroundColor = kGetColor(171.0, 171.0, 171.0);
    sender.enabled = NO;
    //button type要 设置成custom 否则会闪动
    
    [self getVerification];
    
    [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
        NSString *title = [NSString stringWithFormat:@"(%d)重新获取",second];
        return title;
    }];
    [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
//        countDownButton.backgroundColor = UIColorFromRGB(0x00c20a);
        return @"重新获取";
        
    }];
    

}


- (IBAction)loginBtnClick:(id)sender {
   
    [self.phoneField resignFirstResponder];
    [self.codeField resignFirstResponder];
    
    if (_phoneField.text.length==0) {
        
        [Util ShowAlertWithOnlyMessage:@"请输入手机号"];
        return;
    }
    if (_codeField.text.length==0){
        
        
        [Util ShowAlertWithOnlyMessage:@"请输入验证码"];
        
        return;
    }
//    else{
//        if (![Util   isValidateMobile:_phoneField.text]) {
//            [self showSimplyAlertWithTitle:@"提示" message:@"手机号格式错误" sureAction:^(UIAlertAction *action) {
//                
//            }];
//        }else{
        
            [self requestLogin];
//        }
//        
//    }
    

   
}



#pragma mark ------------------------Delegate-----------------------------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger strLength = textField.text.length - range.length + string.length;
    NSString *text = nil;
    if (textField==_phoneField) {
        _editorStatus=TextEditorPhoneFieldTag;
        //实时监听点击清除按钮时候文本内容是否为空，为空按钮颜色置灰
        [_phoneField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
        
        if (strLength >11){
            return NO;
        }
        //如果string为空，表示删除
        if (string.length > 0) {
            text = [NSString stringWithFormat:@"%@%@",textField.text,string];
            
        }else{
            text = [textField.text substringToIndex:range.location];
        }
    }else if (textField==_codeField){
        _editorStatus=TextEditorCodeFieldTag;
        [_codeField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
        if (strLength >6){
            return NO;
        }
        //如果string为空，表示删除
        if (string.length > 0) {
            text = [NSString stringWithFormat:@"%@%@",textField.text,string];
            
        }else{
            text = [textField.text substringToIndex:range.location];
        }
        
    }
    
    endBtn = [self isCheckContent:text];
    return YES;
    
}


-(BOOL)isCheckContent:(NSString *)text{
    
    if (_editorStatus==TextEditorPhoneFieldTag) {
        if (text.length == 11) {
            BOOL phone = [Util   isValidateMobile:text];
            if (phone) {
//                _getCodeButton.backgroundColor = UIColorFromRGB(0x00c20a);
//                [_getCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _editorStatus=TextEditorDefaultStatus;
                [_phoneField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
                if (_codeField.text.length==6) {
//                    _loginButton.backgroundColor = UIColorFromRGB(0xf7d809);
                }
                return YES;
            }
        }else if (text.length < 11){
//            _getCodeButton.backgroundColor = kGetColor(171.0, 171.0, 171.0);
//            _getCodeButton.layer.borderColor = [UIColor clearColor].CGColor;
//            [_getCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            return NO;
        }
    }else if (_editorStatus==TextEditorCodeFieldTag){
        if (_phoneField.text.length == 11&&text.length==6) {
//            _loginButton.backgroundColor = UIColorFromRGB(0xf7d809);
            _editorStatus=TextEditorDefaultStatus;
            return YES;
        }else{
//            _loginButton.backgroundColor = kGetColor(171.0, 171.0, 171.0);
            return NO;
        }
        
        
    }
    return NO;
    
}


#pragma mark ------------------------Notification-------------------------
- (void)FindAction:(NSNotification *)notification {

    UITextField *field = notification.object;
    if (field.text.length==0) {
        endBtn = NO;
        if (_phoneField.text.length==0) {
//            _loginButton.backgroundColor = kGetColor(171.0, 171.0, 171.0);
//            _getCodeButton.backgroundColor = kGetColor(171.0, 171.0, 171.0);
//            _getCodeButton.layer.borderColor = [UIColor clearColor].CGColor;
//            [_getCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else  if (_codeField.text.length==0) {
//            _loginButton.backgroundColor = kGetColor(171.0, 171.0, 171.0);
        }else {
//            _getCodeButton.backgroundColor = UIColorFromRGB(0x00c20a);
//            [_getCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            _loginButton.backgroundColor = UIColorFromRGB(0xf7d809);
           
        }
    }
}
-(void)valueChanged:(UITextField *)textField {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CodeLoginValue" object:textField];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark ------------------------Getter / Setter----------------------



@end

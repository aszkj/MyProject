//
//  DLAssociatedPhoneVCViewController.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/10/13.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLAssociatedPhoneVCViewController.h"
#import "ProjectRelativEmerator.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "JKCountDownButton.h"
#import "DLMainTabBarController.h"
#import "DLCodeLoginVC.h"
#import "DLFindPasswordVC.h"
#import "DLRegisterVC.h"
#import "ShopCartGoodsManager.h"
#import "ShopCartGoodsManager+updateShopCart.h"
#import "CommunityDataManager.h"
#import "GlobleConst.h"
#import "ProjectRelativeDefineNotification.h"
#import "NSArray+SUIAdditions.h"
#import "DLShopCarVC.h"
#import "DLUserInfoModel.h"
#import "ProjectRelativeKey.h"
#import "UserDataManager.h"
#import "ShopCartGoodsManager+shopCartInfo.h"
#import "NSString+Teshuzifu.h"
@interface DLAssociatedPhoneVCViewController ()<UITextFieldDelegate>
{
    
    BOOL endBtn;
}
@property (nonatomic, assign)TextEditorStatus  editorStatus;
@end

@implementation DLAssociatedPhoneVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _init];
    self.pageTitle = @"关联手机号";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------------Init---------------------------------
- (void)_init {

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(FindAction:) name:@"associatedValue" object:nil];
    self.phoneField.delegate = self;
    self.codeField.delegate = self;
    self.passWordField.delegate = self;
    [self.phoneField addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.codeField addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passWordField addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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
    
    if (textField == self.passWordField) {
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
}

#pragma mark ------------------------Api----------------------------------
- (void)getVerification {
    [self showLoadingHub];
    NSDictionary *requestParam = @{@"mobile":self.phoneField.text,
                                   @"type":KTypeBingdingPhone
                                   };
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_VerificationCode block:^(NSDictionary *result, NSError *error) {
        if (error.code==1) {
            
            [_getCodeBtn startWithSecond:[result[EntityKey][@"remainClock"]intValue]];
        }
        
        
        [weak_self hideLoadingHub];
        
        
    }];
    
    
    
}


- (void)_login{
    
    if (_codeField.text.length ==0) {
        [Util ShowAlertWithOnlyMessage:@"请输入验证码"];
        return;
    }
    
    if (_passWordField.text.length ==0) {
        [Util ShowAlertWithOnlyMessage:@"请输入密码"];
        return;
    }
    
    if (![Util isNull:_passWordField.text]) {
        
        [Util ShowAlertWithOnlyMessage:@"输入的密码不能包含空格"];
        return;
    }
    
    if (![Util validateNickname:_passWordField.text]) {
        [Util ShowAlertWithOnlyMessage:@"输入的密码不能包含特殊字符"];
        return;
    }
    
    if (![Util checkPassWord:_passWordField.text]) {
        [Util ShowAlertWithOnlyMessage:@"密码由6-16位字母、数字组成"];
        return;
    }
    
    [self.phoneField resignFirstResponder];
    [self.codeField resignFirstResponder];
    [self.passWordField resignFirstResponder];
    
    [self showLoadingHubWithText:@"正在登录.."];
    
    NSDictionary *dic = @{@"mobile":self.phoneField.text,@"code":self.codeField.text,@"password":self.passWordField.text};
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:dic subUrl:kUrl_Binding block:^(NSDictionary *result, NSError *error) {
        if (error.code==1) {
            [weak_self hideHubForText:nil];
            if (isEmpty(result[EntityKey])) {
                return ;
            }else{
                
                [weak_self hideHubForText:@"登录成功"];
                
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
                
                NSString *birthday;
                if (isEmpty(result[EntityKey][@"birthday"])) {
                    JLog(@".....");
                    birthday = @"";
                }else{
                    birthday = result[EntityKey][@"birthday"];
                    
                }
                
                NSDictionary *bindQQInfo;
                if (isEmpty(result[EntityKey][@"bindQQInfo"])) {
                    JLog(@".....");
                    bindQQInfo = @{};
                }else{
                    bindQQInfo = result[EntityKey][@"bindQQInfo"];
                }
                
                NSDictionary *bindWXInfo;
                if (isEmpty(result[EntityKey][@"bindWXInfo"])) {
                    JLog(@".....");
                    bindWXInfo = @{};
                }else{
                    bindWXInfo = result[EntityKey][@"bindWXInfo"];
                }
                
                
                NSDictionary*dic = @{@"bindWXInfo":bindWXInfo,@"bindQQInfo":bindQQInfo,@"userSex":result[EntityKey][@"userSex"],@"birthday":birthday,@"nickName":nickName,@"userImageUrl":(NSString *)[result[EntityKey][@"userImageUrl"]getOriginalImgUrl],@"userName":result[EntityKey][@"userName"],@"vipExpireDate":vipExpireDate,@"memberType":result[EntityKey][@"memberType"],@"userId":result[EntityKey][@"userId"]};
                
                [kUserDefaults setObject:dic forKey:KUserInfoKey];
                [kUserDefaults synchronize];
                

                
                [[UserDataManager sharedManager] saveUserInfo:dic];

                
                [kNotification postNotificationName:KNofiticationLogIn object:nil];
                [weak_self requestSychronizeShopCartData];
            }
            
            
        }else{
            
            [weak_self hideLoadingHub];
        }
        
    }];
    
}

- (void)requestSychronizeShopCartData {
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:0];
    NSArray *shopCartGoods = [ShopCartGoodsManager sharedManager].allGoodsIdToNumberArr;
    if (shopCartGoods.count >0) {
        [requestParam setObject:shopCartGoods forKey:@"cartInfo"];
    }
    [requestParam setObject:kCommunityStoreId forKey:KStoreIdKey];
    
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_SychronizeShopCart block:^(NSDictionary *resultDic, NSError *error) {
        JLog(@"resultDic2%@",resultDic[EntityKey]);
        if (isEmpty(resultDic[EntityKey])) {
            [self _leaveLoginPage];
            return;
        }
        NSArray *resultArr = resultDic[EntityKey];
        NSArray *transFeredArr = [resultArr sui_map:^GoodsModel *(NSDictionary* obj, NSUInteger index) {
            GoodsModel *model = [[GoodsModel alloc] initWithDefaultDataDic:obj];
            model.goodsNumber = obj[@"cartNum"];
            return model;
        }];
        [[ShopCartGoodsManager sharedManager] updateShopCartGoodsDicWithGoodsArr:transFeredArr isSychronizeShopCart:YES];
        //        [self _backNotBecauseLoginOrOut];
        [self _leaveLoginPage];
    }];
}

#pragma mark ------------------------Page Navigate---------------------------
- (void)_leaveLoginPage {
    
    
    [self performSelector:@selector(_enterMain) withObject:nil afterDelay:1.0f];
    
    
}

- (void)_enterMain {
    DLMainTabBarController *mainVC = [[DLMainTabBarController alloc]init];
    [mainVC setTabIndex:0];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
}

#pragma mark ------------------------View Event---------------------------

- (IBAction)seletedClick:(UIButton *)sender {
    if ((sender.selected =! sender.selected)) {
        self.passWordField.secureTextEntry = NO;
    }else{
        self.passWordField.secureTextEntry = YES;
    }

}


- (IBAction)getCodeBtnClick:(JKCountDownButton *)sender {
    BOOL phone = [Util   isValidateMobile:_phoneField.text];
    if (_phoneField.text.length ==0) {
        
        [Util ShowAlertWithOnlyMessage:@"请输入手机号"];
        
        
    }else {
        if (!phone) {
            
            [Util ShowAlertWithOnlyMessage:@"请输入有效的11位手机号码"];
            
            
            
            
        }else {
            
            sender.enabled = NO;
            [sender setTitleColor:KTextColor forState:UIControlStateNormal];
            //button type要 设置成custom 否则会闪动
            
            [self getVerification];//发送请求
            
            [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                NSString *title = [NSString stringWithFormat:@"(%d)重新获取",second];
                return title;
            }];
            [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                countDownButton.enabled = YES;
                [countDownButton setTitleColor:KCOLOR_PROJECT_RED forState:UIControlStateNormal];
                return @"重新获取";
                
            }];
        }
    }
    

}
- (IBAction)loginBtnClick:(id)sender {
    
    [self _login];

    
    
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
        
    }else if (textField==_passWordField){
        _editorStatus=TextEditorPassWordFieldTag;
        [_passWordField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
        
        
        if (strLength >16){
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
                
                _editorStatus=TextEditorDefaultStatus;
                
                if (_codeField.text.length==6&&_passWordField.text.length>5) {
                    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [_loginBtn setBackgroundColor:KSelectedBgColor];
                    _loginBtn.enabled = YES;
                }
                return YES;
            }
        }else if (text.length < 11){
            [_loginBtn setTitleColor:KTextColor forState:UIControlStateNormal];
            [_loginBtn setBackgroundColor:KLineColor];
            _loginBtn.enabled = NO;
            return NO;
        }
    } else if (_editorStatus==TextEditorCodeFieldTag){
        if (_phoneField.text.length == 11&&text.length==6&&_passWordField.text.length>5) {
            [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_loginBtn setBackgroundColor:KSelectedBgColor];
            _loginBtn.enabled = YES;
            _editorStatus=TextEditorDefaultStatus;
            return YES;
        }else{
            [_loginBtn setTitleColor:KTextColor forState:UIControlStateNormal];
            [_loginBtn setBackgroundColor:KLineColor];
            _loginBtn.enabled = NO;
            return NO;
        }
        
        
    }
    else if (_editorStatus==TextEditorPassWordFieldTag){
        if (text.length>5&&_phoneField.text.length == 11&&_codeField.text.length==6) {
            [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_loginBtn setBackgroundColor:KSelectedBgColor];
            _loginBtn.enabled = YES;
            _editorStatus=TextEditorDefaultStatus;
            return YES;
        }else{
            [_loginBtn setTitleColor:KTextColor forState:UIControlStateNormal];
            [_loginBtn setBackgroundColor:KLineColor];
            _loginBtn.enabled = NO;
            return NO;
        }
        
    }
    return NO;
    
}




#pragma mark ------------------------Notification-------------------------
//监听每个输入框的文本为空
- (void)FindAction:(NSNotification *)notification {
    
    UITextField *field = notification.object;
    if (field.text.length==0) {
        endBtn = NO;
        if (_phoneField.text.length==0||_codeField.text.length==0||_passWordField.text.length ==0) {
            
            [_loginBtn setTitleColor:KTextColor forState:UIControlStateNormal];
            [_loginBtn setBackgroundColor:KLineColor];
            _loginBtn.enabled = NO;
            
        }else {
            
            [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_loginBtn setBackgroundColor:KSelectedBgColor];
            _loginBtn.enabled = YES;
        }
    }
}

-(void)valueChanged:(UITextField *)textField {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"associatedValue" object:textField];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark ------------------------Getter / Setter----------------------




@end

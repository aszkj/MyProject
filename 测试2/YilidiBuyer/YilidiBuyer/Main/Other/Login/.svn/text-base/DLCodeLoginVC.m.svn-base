//
//  DLCodeLoginVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLCodeLoginVC.h"
#import "JKCountDownButton.h"
#import "DLMainTabBarController.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
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

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark ------------------------Init---------------------------------
- (void)_init{

    
    [_phoneField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(FindAction:) name:@"CodeLoginValue" object:nil];
}
#pragma mark ------------------------Private-------------------------


#pragma mark ------------------------Api----------------------------------
- (void)getVerification {
    [self showLoadingHub];
    WEAK_SELF
    [AFNHttpRequestOPManager requestVaryCodeForPhoneNumber:self.phoneField.text varyCodeType:KTypeLogin block:^(id result, NSError *error) {
        if (error.code==1) {
            
            [_getCodeButton startWithSecond:[result[EntityKey][@"remainClock"]intValue]];
        }
            
            [weak_self hideLoadingHub];
        

    }];
  

    
}
- (void)requestLogin {
    
    [self.phoneField resignFirstResponder];
    [self.codeField resignFirstResponder];
    
    [self showLoadingHubWithText:@"正在登录.."];
 
    WEAK_SELF
    [AFNHttpRequestOPManager loginWithPhoneNumber:self.phoneField.text varyCode:self.codeField.text block:^(id result, NSError *error) {
        if (error.code==1) {
            
            if (isEmpty(result[EntityKey])) {
                [weak_self hideHubForText:nil];
                return ;
            }else{
                NSString *vipExpireDate;
                if (isEmpty(result[EntityKey][@"vipExpireDate"])) {
                    JLog(@".....");
                    vipExpireDate = @"";
                }else{
                    vipExpireDate = result[EntityKey][@"vipExpireDate"];
                    
                }
                
                [weak_self hideHubForText:@"登录成功"];
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
- (IBAction)countDownCode:(JKCountDownButton *)sender {
    if (!endBtn) {
        [self showSimplyAlertWithTitle:@"提示" message:@"手机号格式错误" sureAction:^(UIAlertAction *action) {
            
        }];
        return;
    }
    
    [sender setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
    sender.enabled = NO;
    //button type要 设置成custom 否则会闪动
    
    [self getVerification];
    
    [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
        NSString *title = [NSString stringWithFormat:@"(%d)重新获取",second];
        return title;
    }];
    [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        [sender setTitleColor:KSelectedBgColor forState:UIControlStateNormal];
        return @"重新获取";
        
    }];
    

}


- (IBAction)loginBtnClick:(id)sender {
   
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
                
                _editorStatus=TextEditorDefaultStatus;
                [_phoneField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
                if (_codeField.text.length==6) {
                    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [_loginButton setBackgroundColor:KSelectedBgColor];
                    _loginButton.enabled = YES;
                }
                return YES;
            }
        }else if (text.length < 11){
            
            [_loginButton setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
            [_loginButton setBackgroundColor:UIColorFromRGB(0xdcdcdc)];
            _loginButton.enabled = NO;
            return NO;
        }
    }else if (_editorStatus==TextEditorCodeFieldTag){
        if (_phoneField.text.length == 11&&text.length==6) {
            
            [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_loginButton setBackgroundColor:KSelectedBgColor];
            _loginButton.enabled = YES;
            _editorStatus=TextEditorDefaultStatus;
            return YES;
        }else{
            [_loginButton setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
            [_loginButton setBackgroundColor:UIColorFromRGB(0xdcdcdc)];
            _loginButton.enabled = NO;
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
        if (_phoneField.text.length==0||_codeField.text.length==0) {
            [_loginButton setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
            [_loginButton setBackgroundColor:UIColorFromRGB(0xdcdcdc)];
            _loginButton.enabled = NO;
        }else {
            [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_loginButton setBackgroundColor:KSelectedBgColor];
            _loginButton.enabled = YES;
           
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

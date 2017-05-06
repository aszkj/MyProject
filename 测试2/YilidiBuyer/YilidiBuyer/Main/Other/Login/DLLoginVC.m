//
//  DLLoginVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/10/8.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLLoginVC.h"
#import "DLLoginView.h"
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
#import "UserDataManager.h"
#import "ProjectRelativeKey.h"
#import "ShopCartGoodsManager+shopCartInfo.h"
#import "UserDataManager+passwd.h"
#import "DLLoginVC.h"
#import <Masonry/Masonry.h>
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "DLAssociatedPhoneVCViewController.h"
#import "UIImageView+WebCache.h"
#import "DLVipAndPennyGoodsVC.h"
#import "DataManager+linkDataHandle.h"
#import "UIView+BlockGesture.h"
#import "UIViewController+adLinkDataJumpHandler.h"
@interface DLLoginVC ()<TencentSessionDelegate,UITextFieldDelegate>
{

    BOOL endBtn;
}
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;

@property (nonatomic, assign)TextEditorStatus  editorStatus;
@property (strong, nonatomic) IBOutlet UIView *topView;

@property (strong, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic,strong)DLLoginView *loginView;
@property (nonatomic,strong)UIImageView *arrowImgView;
@property (strong, nonatomic) IBOutlet UIView *bgView;

@property (strong, nonatomic) IBOutlet UIView *registerView;
@property (nonatomic,copy)BackPerHomePageBlock backPerHomePageBlock;
@property (nonatomic,assign)NSInteger backPerHomePageIndex;

@property (nonatomic,strong)TencentOAuth *tencentOAuth;
@property (strong, nonatomic) IBOutlet UIButton *closeBtn;
@property (strong, nonatomic) IBOutlet UIView *lineView;

@property (nonatomic,strong)NSDictionary *linkInfo;
@property (nonatomic,strong)NSString *openId;
@property (nonatomic,strong)NSString *accessQQToken;

@property (nonatomic,strong)NSString *accountStr;
@property (nonatomic,strong)NSString *passWordStr;
@property (nonatomic,strong)NSNumber *linkTypeNumber;
@end

@implementation DLLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _init];
    [self _getHeadImage];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(FindAction:) name:@"registerValue" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wecahtCode:) name:@"wechatLogin" object:nil];

    
    [self registerLinkDataJumpNotification];
    
    if (isEmpty([kUserDefaults objectForKey:KUserInfoKey][@"userName"])) {
        return;
    }else{
        
        self.loginView.phoneNumber.text = [kUserDefaults objectForKey:KUserInfoKey][@"userName"];
        //        self.paswdTextFiled.text = [UserDataManager readPassWord];
    }
    
    
       
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
     [kNotification removeObserver:self];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
   
}



#pragma mark ------------------------Init---------------------------------
- (void)_init{

    
    
    
    
   
    _tencentOAuth=[[TencentOAuth alloc]initWithAppId:@"1105559980"andDelegate:self];
    
    
    self.loginView.hidden =NO;
    self.arrowImgView = [UIImageView new];
    self.arrowImgView.image = IMAGE(@"triangle");
    [self.view addSubview:self.arrowImgView];
    [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.mas_bottom);
        make.centerX.mas_equalTo(self.loginButton);
        make.size.mas_equalTo(CGSizeMake(14, 5));
    }];

    
    [self.phoneFiled addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.codeField addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passWordFiled addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    if (self.comeToLoginPageType == LoginedComin_FromSessionInvalidate) {
        
        self.closeBtn.hidden = YES;
    }

}



#pragma mark ------------------------Private-------------------------
- (void)_textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phoneFiled) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    if (textField == self.codeField) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
    
    if (textField == self.passWordFiled) {
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
}
- (void)_leaveLoginPage {
    
    [self performSelector:@selector(_enterMain) withObject:nil afterDelay:1.0f];
    
    
}

- (void)_enterMain {
    DLMainTabBarController *mainVC = [[DLMainTabBarController alloc]init];
    [mainVC setTabIndex:0];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
}

- (void)_enterShopCartPage {
    DLShopCarVC *shopCartPage = [[DLShopCarVC alloc] init];
    shopCartPage.cominFromLoginPage = YES;
    [self.navigationController pushViewController:shopCartPage animated:NO];
}

- (void)_backNotBecauseLoginOrOut {
    if (self.enterFromLoginOrLogout) {
        [self performSelector:@selector(_enterMain) withObject:nil afterDelay:1.0f];
    }else {
        if (self.backPerHomePageBlock) {//如果是从四个首页进入登陆页，需要回调，进入不同的首页
            self.backPerHomePageBlock(self.backPerHomePageIndex);
            [self dismissViewControllerAnimated:NO completion:nil];
        }else {
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }
}


#pragma mark ------------------------Api----------------------------------
//获取验证码
- (void)getVerification {
    
    
    [self showLoadingHub];
    WEAK_SELF
    [AFNHttpRequestOPManager requestVaryCodeForPhoneNumber:self.phoneFiled.text varyCodeType:KTypeLoginPassword block:^(id result, NSError *error) {
        if (error.code==1) {
           
            [_getCodeBtn startWithSecond:[result[EntityKey][@"remainClock"]intValue]];
    
        }
        
        [weak_self hideLoadingHub];
    }];
    
}
- (IBAction)submitRegisterData:(id)sender {
    
    if (![Util isNull:_passWordFiled.text]) {
        
        [Util ShowAlertWithOnlyMessage:@"输入的密码不能包含空格"];
        return;
    }
    
    if (![Util validateNickname:_passWordFiled.text]) {
        [Util ShowAlertWithOnlyMessage:@"输入的密码不能包含特殊字符"];
        return;
    }
    
    if (![Util checkPassWord:_passWordFiled.text]) {
        [Util ShowAlertWithOnlyMessage:@"密码由6-16位字母、数字组成"];
        return;
    }
    
    
   
    if (_selectedButton.selected==YES) {
        
        if (_InviteCodeField.text.length ==0) {
            
           [Util ShowAlertWithOnlyMessage:@"请输入邀请码"];
            return;
        }
        
    }
    
    
    
    
    [self _postData];
}


- (void)_getHeadImage{

    [self showLoadingHub];
    self.requestParam = @{@"type":ADVERTISEMENTTYPE_LOGIN};
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_HomeHeaderLoopPlayUrl block:^(NSDictionary *resultDic, NSError *error) {
        [weak_self hideLoadingHub];
        if (isEmpty(resultDic[EntityKey])) {
            return ;
        }
    
        
        NSArray *array = resultDic[EntityKey];
        
        [weak_self.loginHeadImage sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:0][@"imageUrl"]] placeholderImage:[UIImage imageNamed:@"banner"]];
        weak_self.linkInfo = [[DataManager sharedManager] transferToDicWithLinkCodeStr:[array objectAtIndex:0] [@"linkData"]linkTypeNumber:[array objectAtIndex:0][@"linkType"]];
        weak_self.linkTypeNumber = [array objectAtIndex:0][@"linkType"];
        
        [weak_self _jumpPage];
        
    }];
}

- (void)_postData {
    [self showLoadingHub];
    self.accountStr = self.phoneFiled.text;
    self.passWordStr = self.passWordFiled.text;
    
    
    NSDictionary *parameters = @{@"mobile":self.phoneFiled.text,@"code":self.codeField.text,@"password":self.passWordFiled.text,@"invitationCode":self.InviteCodeField.text};
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:parameters subUrl:kUrl_Regist block:^(NSDictionary *resultDic, NSError *error) {
        JLog(@"sss:%@",resultDic[@"msg"]);
        
        if (error.code ==1) {
            [weak_self requestLogin];
            
        }else{
            [weak_self hideLoadingHub];
        }
        
    }];
}



- (void)requestLogin{
    [_loginView.phoneNumber resignFirstResponder];
    [_loginView.passWordField resignFirstResponder];
    [_phoneFiled resignFirstResponder];
    [_passWordFiled resignFirstResponder];
    [_codeField resignFirstResponder];
    
    [self showLoadingHubWithText:@"正在登录.."];
    WEAK_SELF
    [AFNHttpRequestOPManager loginWithAcount:self.accountStr passwd:self.passWordStr block:^(id result, NSError *error) {
        if (error.code==1) {
            [weak_self hideHubForText:@"登录成功"];
            
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
                [weak_self requestSychronizeShopCartData];
            }
            
        }else{
            
            [self hideLoadingHub];
        }
    }];

    
}

//微信登录
- (void)wechatAndqqLogin:(NSDictionary *)dic submiturl:(NSString *)url{
    [_loginView.phoneNumber resignFirstResponder];
    [_loginView.passWordField resignFirstResponder];
    [_phoneFiled resignFirstResponder];
    [_passWordFiled resignFirstResponder];
    [_codeField resignFirstResponder];
    
    [self showLoadingHubWithText:@"正在登录.."];
    WEAK_SELF
    [AFNHttpRequestOPManager wechatAndlogin:dic
                                  submitUrl:url
                                    block:^(id result, NSError *error) {
        if (error.code==1) {
            [weak_self hideHubForText:nil];
            NSLog(@"result:%@",result);
            if (isEmpty(result[EntityKey])) {
                
                return ;
            }else{
                
                if ([result[EntityKey][@"binding"]integerValue]==0) {
                    NSString *lastSessionID = [kUserDefaults objectForKey:YiLiDiSessionID];
                    [kUserDefaults setObject:nil forKey:YiLiDiSessionID];
                    [kUserDefaults setObject:lastSessionID forKey:UNLOGIN_YiLiDiSessionID];
                    [kUserDefaults synchronize];
                    DLAssociatedPhoneVCViewController *associatedVC = [[DLAssociatedPhoneVCViewController alloc]init];
                    [self navigatePushViewController:associatedVC animate:YES];
                    return;
                }
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
    if (isEmpty(kCommunityStoreId)) {
        [self _leaveLoginPage];
        return;
    }
    [requestParam setObject:kCommunityStoreId forKey:KStoreIdKey];
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_SychronizeShopCart block:^(NSDictionary *resultDic, NSError *error) {
        JLog(@"同步购物车result=%@",resultDic[EntityKey]);
        
        NSArray *resultArr = resultDic[EntityKey];
        if (isEmpty(resultArr)) {
            resultArr = @[];
        }
        NSArray *transFeredArr = [resultArr sui_map:^GoodsModel *(NSDictionary* obj, NSUInteger index) {
            GoodsModel *model = [[GoodsModel alloc] initWithDefaultDataDic:obj];
            model.goodsNumber = obj[@"cartNum"];
            return model;
        }];
        [[ShopCartGoodsManager sharedManager] updateShopCartGoodsDicWithGoodsArr:transFeredArr isSychronizeShopCart:YES];
        [self _leaveLoginPage];
    }];
}

#pragma mark ------------------------Public----------------------------------
- (void)comFromPerHomePageOfIndex:(NSInteger)homeIndex backBlock:(BackPerHomePageBlock)backBlock {
    self.backPerHomePageIndex = homeIndex;
    self.backPerHomePageBlock = backBlock;
}


#pragma mark ------------------------Page Navigate---------------------------

- (void)_jumpPage {
    
    if (self.linkInfo!=nil) {
        WEAK_SELF
        [self.loginHeadImage addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
           
            NSString *linkNotificationName = [[DataManager sharedManager] transferTolinkNotificationNameWithlinkTypeNumber:weak_self.linkTypeNumber linkDataDic:weak_self.linkInfo];
            if (isEmpty(linkNotificationName)) {
//                weak_self.loginHeadImage.userInteractionEnabled=NO;
                return;
            }
            
//            weak_self.loginHeadImage.userInteractionEnabled=YES;
            [kNotification postNotificationName:linkNotificationName object:weak_self.linkInfo];
        }];
    }
    
}

- (IBAction)goBackPage:(id)sender {
    [self goBack];
//    [self dismissViewControllerAnimated:YES completion:^{
//    }];
}


#pragma mark ------------------------View Event---------------------------
- (IBAction)getVerificationCode:(JKCountDownButton *)sender {
    
    BOOL phone = [Util   isValidateMobile:_phoneFiled.text];
    if (_phoneFiled.text.length ==0) {
        
        [Util ShowAlertWithOnlyMessage:@"请输入手机号"];
        
        
    }else {
        if (!phone) {
            
            [Util ShowAlertWithOnlyMessage:@"手机号格式错误"];
            
           
            
            
        }else {
            
            sender.enabled = NO;
            [sender setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
            //button type要 设置成custom 否则会闪动
            
            [self getVerification];//发送请求
            
            [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                NSString *title = [NSString stringWithFormat:@"(%d)重新获取",second];
                return title;
            }];
            [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                countDownButton.enabled = YES;
                [countDownButton setTitleColor:KSelectedBgColor forState:UIControlStateNormal];
                return @"重新获取";
                
            }];
        }
    }

    
}


- (IBAction)isSeletedClick:(UIButton *)sender {
    
    _selectedButton.selected = !_selectedButton.selected;
    WEAK_SELF
    if (_selectedButton.selected==YES) {
    
        [UIView animateWithDuration:0.5 animations:^{
           
            weak_self.InviteCodeField.hidden =NO;
            weak_self.lineView.hidden = NO;
            weak_self.isInvitationLabel.textColor = KSelectedBgColor;
            CGRect rect = weak_self.regisBtnBgView.frame;
            rect.origin.y = weak_self.registerView.frame.size.height-rect.size.height;
            weak_self.regisBtnBgView.frame = rect;

        }];
        
        
    }else{
    
        [UIView animateWithDuration:0.5 animations:^{
            
            weak_self.InviteCodeField.hidden =YES;
            weak_self.lineView.hidden = YES;
            weak_self.isInvitationLabel.textColor = UIColorFromRGB(0x333333);
            CGRect rect = weak_self.regisBtnBgView.frame;
            rect.origin.y = weak_self.registerView.frame.size.height-rect.size.height-31;
            weak_self.regisBtnBgView.frame = rect;
            
        
        }];
    }
    
}

- (IBAction)loginButtonClick:(id)sender {
    self.loginView.hidden=NO;
    self.registerButton.selected = NO;
    self.loginButton.selected = NO;
    self.registerView.hidden=YES;
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6 options:UIViewAnimationOptionAllowUserInteraction animations:^{
      
        [self.arrowImgView mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.top.mas_equalTo(self.loginButton.mas_bottom);
            make.centerX.mas_equalTo(self.loginButton);
            make.size.mas_equalTo(CGSizeMake(14, 5));
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];

}

- (IBAction)registerButtonClick:(id)sender {
   self.loginView.hidden=YES;
   self.registerView.hidden=NO;
    self.loginButton.selected = YES;
    self.registerButton.selected = YES;
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6 options:UIViewAnimationOptionAllowUserInteraction animations:^{


         [self.arrowImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.registerButton.mas_bottom);
            make.centerX.mas_equalTo(self.registerButton);
            make.size.mas_equalTo(CGSizeMake(14, 5));
        
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
                   
    }];
    

}


- (IBAction)isShowPassWord:(UIButton *)sender {
    if ((sender.selected =! sender.selected)) {
        self.passWordFiled.secureTextEntry = NO;
    }else{
        self.passWordFiled.secureTextEntry = YES;
    }

}


- (IBAction)wechatLogin:(id)sender {
    SendAuthReq *req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo"; // 此处不能随意改
    req.state = @"123"; // 这个貌似没影响
    [WXApi sendReq:req];
}


- (IBAction)qqLogin:(id)sender {
    
    NSArray *permissions= [NSArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo",@"add_t", nil];
    [_tencentOAuth authorize:permissions inSafari:NO];
}

#pragma mark ------------------------Delegate-----------------------------

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger strLength = textField.text.length - range.length + string.length;
    NSString *text = nil;
    if (textField==_phoneFiled) {
        _editorStatus=TextEditorPhoneFieldTag;
        //实时监听点击清除按钮时候文本内容是否为空，为空按钮颜色置灰
        [_phoneFiled addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
        
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
        
    }else if (textField==_passWordFiled){
        _editorStatus=TextEditorPassWordFieldTag;
        [_passWordFiled addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
        
        
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

                if (_codeField.text.length==6&&_passWordFiled.text.length>5) {
                    [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [_registerBtn setBackgroundColor:KSelectedBgColor];
                    _registerBtn.enabled = YES;
                }
                return YES;
            }
        }else if (text.length < 11){
            [_registerBtn setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
            [_registerBtn setBackgroundColor:UIColorFromRGB(0xdcdcdc)];
            _registerBtn.enabled = NO;
            return NO;
        }
    } else if (_editorStatus==TextEditorCodeFieldTag){
        if (_phoneFiled.text.length == 11&&text.length==6&&_passWordFiled.text.length>5) {
            [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_registerBtn setBackgroundColor:KSelectedBgColor];
            _registerBtn.enabled = YES;
            _editorStatus=TextEditorDefaultStatus;
            return YES;
        }else{
            [_registerBtn setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
            [_registerBtn setBackgroundColor:UIColorFromRGB(0xdcdcdc)];
            _registerBtn.enabled = NO;
            return NO;
        }
        
        
    }
    else if (_editorStatus==TextEditorPassWordFieldTag){
        if (text.length>5&&_phoneFiled.text.length == 11&&_codeField.text.length==6) {
            [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_registerBtn setBackgroundColor:KSelectedBgColor];
            _registerBtn.enabled = YES;
            _editorStatus=TextEditorDefaultStatus;
            return YES;
        }else{
            [_registerBtn setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
            [_registerBtn setBackgroundColor:UIColorFromRGB(0xdcdcdc)];
            _registerBtn.enabled = NO;
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
        if (_phoneFiled.text.length==0||_codeField.text.length==0||_passWordFiled.text.length==0) {

            [_registerBtn setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
            [_registerBtn setBackgroundColor:UIColorFromRGB(0xdcdcdc)];
            _registerBtn.enabled = NO;
            
        }else{
            
            [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_registerBtn setBackgroundColor:KSelectedBgColor];
            _registerBtn.enabled = YES;
        }
    }
}

-(void)valueChanged:(UITextField *)textField {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"registerValue" object:textField];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -- TencentSessionDelegate
//登陆完成调用
- (void)tencentDidLogin
{
    
    
    self.openId =_tencentOAuth.openId;
    
    if (_tencentOAuth.accessToken && _tencentOAuth.accessToken.length)
    {
        //  记录登录用户的OpenID、Token以及过期时间
        
        NSLog(@"Token:%@",_tencentOAuth.accessToken);
        self.accessQQToken= _tencentOAuth.accessToken;
        NSDictionary *dic = @{@"accessToken":self.accessQQToken,@"openId":self.openId};
        [self wechatAndqqLogin:dic submiturl:kUrl_QQLogin];

//        [_tencentOAuth getUserInfo];
    }
    else
    {
        [Util ShowAlertWithOnlyMessage:@"登录不成功没有获取accesstoken"];
        
    }
}

//非网络错误导致登录失败：
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"tencentDidNotLogin");
    if (cancelled)
    {
        [Util ShowAlertWithOnlyMessage:@"用户取消登录"];
        
    }else{
        
        [Util ShowAlertWithOnlyMessage:@"登录失败"];
    }
}
// 网络错误导致登录失败：
-(void)tencentDidNotNetWork
{
    NSLog(@"tencentDidNotNetWork");
    
     [Util ShowAlertWithOnlyMessage:@"无网络连接，请设置网络"];
}

- (NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams{
    return nil;
}

-(void)getUserInfoResponse:(APIResponse *)response
{
    
    NSLog(@"respons:%@",response.jsonResponse);
    NSLog(@"respons:%@",response.jsonResponse[@"city"]);
    NSLog(@"respons:%@",response.jsonResponse[@"nickname"]);
    NSLog(@"respons:%@",response.jsonResponse[@"province"]);
    NSLog(@"respons:%@",response.jsonResponse[@"gender"]);
    NSLog(@"respons:%@",response.jsonResponse[@"figureurl"]);
    NSLog(@"respons:%@",response.jsonResponse[@"figureurl_1"]);
    
    
}

#pragma mark ------------------------Notification-------------------------
- (void)wecahtCode:(NSNotification *)cation{

    NSString *code = cation.object;
    
    NSDictionary *dic = @{@"code":code};
    [self wechatAndqqLogin:dic submiturl:kUrl_WechatLogin];
    
}

#pragma mark ------------------------Getter / Setter----------------------
- (DLLoginView *)loginView {
    //xib self.bgView 不知为何frame变了 有空再看
    self.bgView.frame = CGRectMake(0, self.topView.frame.origin.y+self.topView.frame.size.height, kScreenWidth, 285);
    if (!_loginView) {
        _loginView = BoundNibView(@"DLLoginView", DLLoginView);
        _loginView.frame = CGRectMake(0, 0, kScreenWidth, 230);
         [self.bgView addSubview:_loginView];
    }
     WEAK_SELF
    _loginView.loginBlock = ^{
        
        if (_loginView.phoneNumber.text.length==0) {
            
            [Util ShowAlertWithOnlyMessage:@"请输入手机号"];
        }else if (_loginView.passWordField.text.length==0){
            
            [Util ShowAlertWithOnlyMessage:@"请输入密码"];
            
        }else{
           
            weak_self.accountStr = weak_self.loginView.phoneNumber.text;
            weak_self.passWordStr = weak_self.loginView.passWordField.text;
            [weak_self requestLogin];
            
            
        }

        
    };
    
    _loginView.codeLoginBlock = ^{
    
        DLCodeLoginVC *codeLoginVC = [[DLCodeLoginVC alloc]init];
        [weak_self navigatePushViewController:codeLoginVC animate:YES];
    };
    
   
    _loginView.forgotPasswordBlock = ^{
        
        DLFindPasswordVC *findVC = [[DLFindPasswordVC alloc]init];
        [weak_self navigatePushViewController:findVC animate:YES];
    };
    
    
   
    return _loginView;
}

@end

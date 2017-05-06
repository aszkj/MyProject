//
//  loginViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "loginViewController.h"
#import "Header.h"
#import "SVProgressHUD.h"
#import "UIViewExt.h"
#import "IRequest.h"
#import "RigisterOrForgetPasswordController.h"
#import <ShareSDK/ShareSDK.h>
#import "MBProgressHUD.h"
#import "ThirdPaltFormLoginHelper.h"
#import "TieThirdPlatFormController.h"
#import "mainViewController.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "UIButton+Block.h"
#import "DownToUpAlertView.h"
#import "RepairInfoMationController.h"
#import "APService.h"
#import "JGDESUtils.h"
#import "JGActivityHelper.h"
#import "ThirdPlatformInfo.h"

@interface loginViewController ()<UITextFieldDelegate>
{
    UIButton       *_loginBtn,*_registBtn,*_forgetBtn,*_QQBtn,*_wechatBtn,*_sinaBtn;
    UITextField    *_nametf,*_pwdtf;
    UILabel        *_QQlab,*_sinalab,*_wechatlab;
    
    NSInteger        _thirdPlatNum;
    NSString        *_thirdPlatOpenID;
    NSString        * unionId;
    ThirdPaltFormLoginHelper    *_thirdPlatFormHelper;
    MBProgressHUD * _thirdLoginHub;
    NSString        *_thirdPlatToken;
}

@end

@implementation loginViewController


-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    //退出登录需要设置不接收推送消息,暂时这样做
     [[UIApplication sharedApplication] unregisterForRemoteNotifications];

//    [self performSelector:@selector(_hiddenNavBar) withObject:nil afterDelay:0.3];
    [self _hiddenNavBar];
}

- (void)_hiddenNavBar {
    self.navigationController.navigationBarHidden = YES;
}

-(void)vewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBarHidden = YES;
    
    _loginBtn  = [[UIButton alloc]init];  _forgetBtn = [[UIButton alloc]init];
    _registBtn = [[UIButton alloc]init];  _QQBtn     = [[UIButton alloc]init];
    _wechatBtn = [[UIButton alloc]init];   _sinaBtn  = [[UIButton alloc]init];
    _nametf    = [[UITextField alloc]init];_pwdtf    = [[UITextField alloc]init];
    _QQlab     = [[UILabel alloc]init];     _sinalab = [[UILabel alloc]init];_wechatlab = [[UILabel alloc]init];
    
    UIImageView * bgImg = [[UIImageView alloc]init];
    if (__MainScreen_Height == 480) {
        bgImg.image = [UIImage imageNamed:@"login_back_iphone4"];
    }else{
        bgImg.image = [UIImage imageNamed:@"login_back_iphone5"];
    }
    self.navigationController.view.backgroundColor = [ UIColor whiteColor];
    bgImg.frame = self.view.frame;
    [self.view addSubview:bgImg];
    
    //不登陆btn
    UIButton *closeLoginBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-30, 30, 20, 20)];
    [closeLoginBtn setBackgroundImage:[UIImage imageNamed:@"close_login"] forState:UIControlStateNormal];
    [self.view addSubview:closeLoginBtn];
    WEAK_SELF;
    [closeLoginBtn addActionHandler:^(NSInteger tag) {
        [weak_self _enterMainPage];
    }];
    
    
    [self greatUI];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    //判断第三方客户端，隐藏相应按钮
    [self _thirdPlatDeal];
    
}


-(void)_thirdPlatDeal {
    
    if (![WXApi isWXAppInstalled]) {
        _wechatBtn.hidden = YES;
        _wechatlab.hidden = YES;
    }
    
    if (![QQApiInterface isQQInstalled]){
        _QQBtn.hidden = YES;
        _QQlab.hidden = YES;
    }
}




//键盘出现
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //键盘弹起，，肯定是其中一个成为了响应者，，为了防止这个方法多次调用
    if ([_pwdtf isFirstResponder] || [_nametf isFirstResponder]) {
        
        if (self.view.top == 0) {
            
            CGFloat upDeta = 0;
            [Util setValueIndiffScreensWithVarary:&upDeta in4s:120 in5s:110 in6s:100 plus:90];
            
            [UIView animateWithDuration:0.2 animations:^{
                
                self.view.top = -upDeta;
                
            }];
            
        }
    }
}


//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
//    NSLog(@"self view top :%.2f",self.view.top);
    if (!([_pwdtf isFirstResponder] && [_nametf isFirstResponder])) {
        
        if (self.view.top < 0) {
            
            [UIView animateWithDuration:0.2 animations:^{
                
                self.view.top = 0;
            }];
        }
    }
    
    
}




- (void) greatUI
{
    [_sinaBtn setBackgroundImage:[UIImage imageNamed:@"login_sina"] forState:UIControlStateNormal];
    [self.view addSubview:_sinaBtn];
    
    [_QQBtn setBackgroundImage:[UIImage imageNamed:@"login_qq"] forState:UIControlStateNormal];
    [self.view addSubview:_QQBtn];

    [_wechatBtn setBackgroundImage:[UIImage imageNamed:@"login_weixin"] forState:UIControlStateNormal];
    [self.view addSubview:_wechatBtn];
    
    float box_img_h = 45.0;
#pragma mark - 修改的
//    float box_img_w = 510/2;
    float box_img_w = ( kScreenWidth - 30 * 2 );
    NSArray *array = [NSArray arrayWithObjects:@"login_name",@"login_password", nil];
    int   loginbtn_height = 0;
    if (__MainScreen_Height == 480) {
        loginbtn_height = loginbtn_h2;
    }else{
        loginbtn_height = loginbtn_h;
    }
    for (int i = 0; i < 2; i ++) {
        UIImageView * box_img = [[UIImageView alloc]init];
        
        box_img.frame = CGRectMake((__MainScreen_Width-box_img_w)/2, loginbtn_height+(box_img_h+13)*i, box_img_w, box_img_h);
        box_img.image = [UIImage imageNamed:@"login_frame"];
        [self.view addSubview:box_img];

        
        UIImageView * box_img2 = [[UIImageView alloc]init];
        
        box_img2.frame = CGRectMake((__MainScreen_Width-box_img_w)/2+19, loginbtn_height+(box_img_h+13)*i+15, 14, 14);
        box_img2.image = [UIImage imageNamed:[array objectAtIndex:i]];
        [self.view addSubview:box_img2];

        
        if (i == 0) {
            _nametf = [[UITextField alloc]init];

            _nametf.frame = CGRectMake(box_img2.frame.origin.x+box_img2.frame.size.width+8, box_img2.frame.origin.y - 6, __MainScreen_Width - (box_img2.frame.origin.x+box_img2.frame.size.width+8) - 35, 30);
            _nametf.placeholder = @"请输入手机号";
            _nametf.delegate = self;
            _nametf.textColor = [UIColor whiteColor];
            _nametf.clearButtonMode = UITextFieldViewModeWhileEditing;
            _nametf.font = [UIFont systemFontOfSize:17];
            _nametf.keyboardType = UIKeyboardTypeNumberPad;
            [self.view addSubview:_nametf];
        }else{
            _pwdtf = [[UITextField alloc]init];

            _pwdtf.frame = CGRectMake(box_img2.frame.origin.x+box_img2.frame.size.width+8, box_img2.frame.origin.y-6, __MainScreen_Width - (box_img2.frame.origin.x+box_img2.frame.size.width+8) - 35, 30);
            _pwdtf.placeholder = @"请输入密码";
            _pwdtf.delegate = self;
//            _pwdtf.text = @"123";
            _pwdtf.clearButtonMode = UITextFieldViewModeWhileEditing;
            _pwdtf.textColor = [UIColor whiteColor];
            _pwdtf.secureTextEntry = YES;
            _pwdtf.returnKeyType = UIReturnKeyDone;
            _pwdtf.font = [UIFont systemFontOfSize:17];
            [self.view addSubview:_pwdtf];
        }
        
        if (i == 1) {
            float line_lab_height = box_img.frame.origin.y+box_img.frame.size.height;
//            float btn_width = __MainScreen_Width-40;
            _loginBtn.tag = 1;
            _loginBtn.layer.cornerRadius = 4;
            _loginBtn.clipsToBounds = YES;
            [_loginBtn setBackgroundColor:color_loginBtn_1];
            [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
            [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_loginBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            _loginBtn.frame = CGRectMake((__MainScreen_Width-box_img_w)/2, line_lab_height+13, box_img_w, 45);
            [self.view addSubview:_loginBtn];
        }
    }
    
    _forgetBtn.tag = 2;
    [_forgetBtn setBackgroundColor:[UIColor clearColor]];
    [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_forgetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_forgetBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _forgetBtn.frame = CGRectMake((__MainScreen_Width-box_img_w)/2, _loginBtn.frame.origin.y+_loginBtn.frame.size.height, 65, 30);
    [self.view addSubview:_forgetBtn];
    
    _registBtn.tag = 3;
    [_registBtn setBackgroundColor:[UIColor clearColor]];
    [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
    _registBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _registBtn.frame = CGRectMake(__MainScreen_Width-80, _loginBtn.frame.origin.y+_loginBtn.frame.size.height, 60, 30);
    [self.view addSubview:_registBtn];
    
    float  _loginBtn_height = _registBtn.frame.origin.y + _registBtn.frame.size.height;
    float  btn_spase_x = 50;//第3方登录按钮距离两边框的距离
    float  btn_spase   = 50;//按钮彼此之间的距离
    float  btn_width = (__MainScreen_Width-btn_spase_x*2-btn_spase*2)/3;//按钮的大小

#pragma mark - 隐藏第三方登录
    _sinaBtn.frame = CGRectMake(btn_spase_x, _loginBtn_height+50, 31, 24);
    float sina_btn_height = _sinaBtn.frame.origin.y+_sinaBtn.frame.size.height;//第3方按钮的位置
    _sinalab.frame = CGRectMake(btn_spase_x, sina_btn_height-10, 31, 24);
    _QQBtn.frame = CGRectMake(btn_spase_x+btn_width+btn_spase, _loginBtn_height+50, 31, 24);
    _QQlab.frame = CGRectMake(btn_spase_x+btn_width+btn_spase, sina_btn_height-10, 31, 24);
    _wechatBtn.frame = CGRectMake(btn_spase_x+2*(btn_width+btn_spase), _loginBtn_height+50, 31, 24);
    _wechatlab.frame = CGRectMake(btn_spase_x+2*(btn_width+btn_spase), sina_btn_height-10, 31, 24);
    [_sinaBtn addTarget:self action:@selector(ThirtLoginView:) forControlEvents:UIControlEventTouchUpInside];
    [_wechatBtn addTarget:self action:@selector(ThirtLoginView:) forControlEvents:UIControlEventTouchUpInside];
    [_QQBtn addTarget:self action:@selector(ThirtLoginView:) forControlEvents:UIControlEventTouchUpInside];

    _QQBtn.tag = 3;
    _wechatBtn.tag = 4;
    _sinaBtn.tag = 5;
    
    UIImageView * other_img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_three"]];
    other_img.frame = CGRectMake((__MainScreen_Width-box_img_w)/2, _loginBtn_height+35, box_img_w, 55);
    [self.view addSubview:other_img];

    UILabel * other_lab = [[UILabel alloc]init];
    other_lab.frame = CGRectMake(0,  _loginBtn_height+30, __MainScreen_Width, 10);
    other_lab.text = @"第三方登录";
    other_lab.font = [UIFont systemFontOfSize:13];
    other_lab.textColor = [UIColor whiteColor];
    other_lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:other_lab];

    
}

- (void)BtnClick:(UIButton *)btn
{
    
    [self.view endEditing:YES];
    switch (btn.tag) {
        case 1:
        {
            [self _beginLogin];
        }
            break;
        case 2:
        {
#pragma mark - 注册页替换的
            RigisterOrForgetPasswordController *registerForgetPasswdVC = [[RigisterOrForgetPasswordController alloc] init];
            registerForgetPasswdVC.registerPageType = ForgetPasswordType;
            [self.navigationController pushViewController:registerForgetPasswdVC animated:YES];
        }
            break;
        case 3:
        {
            RigisterOrForgetPasswordController *registerForgetPasswdVC = [[RigisterOrForgetPasswordController alloc] init];
            registerForgetPasswdVC.registerPageType = RegisterType;
            [self.navigationController pushViewController:registerForgetPasswdVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(void)_beginLogin {

    if (_nametf.text.length<1) {
        [self showAlertViewWithStr:@"请输入手机号"];
        [_nametf becomeFirstResponder];
    }else if (_pwdtf.text.length<1){
        [self showAlertViewWithStr:@"请输入密码"];
        [_pwdtf becomeFirstResponder];
    }else{
        [SVProgressHUD showInView:self.view status:@"正在登录，请稍后..." networkIndicator:NO posY:-1 maskType:SVProgressHUDMaskTypeNone];
        
        NSString *authonUrlStr = @"";
        AbstractRequest *reuqest = [[AbstractRequest alloc] init:@""];
        authonUrlStr = reuqest.baseUrl;
        
        NSURL *url = [NSURL URLWithString:BaseAuthUrl];
//        url = [NSURL URLWithString:@"http://192.168.2.227:10020"];
        
        // NSURL *url = [NSURL URLWithString:releaseURL];
        
        VApiManager *manager = [[VApiManager alloc] initWithBaseURL:url clientId:@"carnation-resource-android" secret:@"98e32480-d064-4166-945b-5c4467c717ea"];
        NSString *username = _nametf.text;
        NSString *password = _pwdtf.text;
        username = [username stringByAppendingString:@"_"];
        password = [JGDESUtils encryptUseDES:password key:@"JgYeScOM_abc_12345678_kEHrDooxWHCWtfeSxvDvgqZq"];
        
        [manager authenticateUsingOAuthWithPath:@"/oauth2/token" username:username password:password
                                        success:^(AFHTTPRequestOperation *operation, AccessToken *credential) {
                                            
                                            NSLog(@"-----longin ---- token-----%@",credential.accessToken);
                                            
                                            //保存token
                                            [SVProgressHUD dismiss];
                                            [userDefaultManager SetLocalDataString:credential.accessToken key:@"Token"];

                                            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
                                            NSLog(@"dict === %@",dict);
                                            NSString * code = [dict objectForKey:@"code"];
                                            
                                            NSString * msg = [dict objectForKey:@"sub_msg"];
                                            NSLog(@"msg = %@   code = %@",msg,code);
#warning code等于2，token失效
                                            if ([code intValue]==2) {//token失效，
                                                [self showAlertViewWithStr:msg];
                                            }else{
                                                [userDefaultManager SetLocalDataString:_nametf.text key:@"userName"];
                                                [userDefaultManager SetLocalDataString:_pwdtf.text key:@"passWord"];
                                                [self _enterMainPage];
                                            }
                                            
                                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                            NSLog(@"error%@",error);
                                        }];
    
    }

}

#pragma mark - uitextfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if ([_nametf isFirstResponder]) {
        [_pwdtf becomeFirstResponder];
    }else{
        [_pwdtf becomeFirstResponder];
        [self _beginLogin];
    }
    return YES;
}

-(BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)showAlertViewWithStr:(NSString *)string
{
    UIAlertView * alertVc = [[UIAlertView alloc]initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];[alertVc show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ----------------------- 第三方登录 -----------------------
-(void)ThirtLoginView:(UIButton *)thirdPlatBtn
{
    //    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:nil message:@"该功能暂时还没开放，敬请期待。" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    //    [alter show];
    _thirdPlatNum = thirdPlatBtn.tag;
    
    [self _beginThirdLogin];
    
}

- (void)loginWithWeiXin {
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo,snsapi_base";
    req.state = @"";
    [WXApi sendReq:req];
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.getWXCode = YES;
    app.wxCodeBlock = ^(NSString *code){
        JGLog(@"code:%@",code);
        NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",Weixin_AppID,Weixin_AppSecret,code];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *zoneUrl = [NSURL URLWithString:url];
            NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
            NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data) {
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    NSString *access_token = dic[@"access_token"];
                    NSString *openid = dic[@"openid"];
                    _thirdPlatOpenID = openid;
                    JGLog(@"\n---------openid:%@",openid);
                    _thirdPlatToken = access_token;
                    JGLog(@"\n---------access_token:%@",access_token);
                    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openid];
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        NSURL *zoneUrl = [NSURL URLWithString:url];
                        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
                        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (data) {
                                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                NSString *wxunionid = dic[@"unionid"];
                                unionId = wxunionid;
                                JGLog(@"\n---------unionid:%@",wxunionid);
                                if (_thirdPlatOpenID) {
                                    //查询是否绑定
                                    [self _queryUserWhetherTiedToThirdPlat];
                                }
                            }
                        });
                    });
                }
            });
        });
    };
    return ;
}

#pragma mark - 开始第三方登录
- (void)_beginThirdLogin {

    ShareType thirdAuthType;
    switch (_thirdPlatNum) {
        case 3:
            //QQ
            thirdAuthType = ShareTypeQQSpace;
            break;
        case 4:
            //微信
        {
            thirdAuthType = ShareTypeWeixiTimeline;
            [self loginWithWeiXin];
            return;
        }
            break;
        case 5:
            //微博
            thirdAuthType = ShareTypeSinaWeibo;
            break;
            
        default:
            break;
    }
    
    [ShareSDK getUserInfoWithType:thirdAuthType authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        JGLog(@"用户openID %@",[userInfo uid]);
        _thirdPlatOpenID = [userInfo uid];// oGIrss4dtNKvchUDTspvYv4tI-nA
        _thirdPlatToken = [[ShareSDK getCredentialWithType:thirdAuthType] token];
        if (_thirdPlatOpenID) {
            //查询是否绑定
            [self _queryUserWhetherTiedToThirdPlat];
        }
    }];
    
}



#pragma mark - 查询是否绑定过第三方平台
-(void)_queryUserWhetherTiedToThirdPlat {
    
    _thirdLoginHub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    VApiManager *vapManager = [[VApiManager alloc] init];
    OpenIdBindingCheckRequest *request = [[OpenIdBindingCheckRequest alloc] init:@""];
    request.api_openId = _thirdPlatOpenID;
    request.api_type = @(_thirdPlatNum);
    if(!unionId){
        request.api_unionId = @"";
    }else{
         request.api_unionId = unionId;
    }
   
    
    [vapManager openIdBindingCheck:request success:^(AFHTTPRequestOperation *operation, OpenIdBindingCheckResponse *response) {
        JGLog(@"检查绑定结果 %@",response);
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSNumber *isBinding = dict[@"isBinding"];
        if (!isBinding.integerValue) {//没绑定，进入绑定页
            [_thirdLoginHub hide:YES];
            [self _cominToTheTiePage];
        }else {//绑定了，登录
            _thirdLoginHub.labelText = @"正在进行登录..";
            [self _thirdPlatLogin];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [_thirdLoginHub hide:YES];
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
    }];
    
}

#pragma mark - 绑定了，直接登录，调登录接口
-(void)_thirdPlatLogin {
    
    _thirdPlatFormHelper = [[ThirdPaltFormLoginHelper alloc] init];
    _thirdPlatFormHelper.thirdPlatFormId = _thirdPlatOpenID;
    _thirdPlatFormHelper.unionId = unionId;
    [_thirdPlatFormHelper beginLoginWithSuccess:^(NSDictionary *sucessDic) {
        
        _thirdLoginHub.labelText = @"登陆成功";
        [_thirdLoginHub hide:YES afterDelay:0.2];
        [self _enterMainPage];
        
    } failed:^(NSString *failedStr) {
        [_thirdLoginHub hide:YES];
        [Util ShowAlertWithOnlyMessage:failedStr];
    }];
}

#pragma mark - 进入主页
-(void)_enterMainPage {
    [JGActivityHelper queryUserDidCheckInPopView:^(UserSign *userSign) {
        // 用户没签到弹窗
        JGLog(@"userSign:%@",userSign);
    } notPop:^{
        // 用户已签到，或网络错误不弹窗
    }];
    
    AppDelegate * app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [app gogogoWithTag:0];
}


#pragma mark - 没绑定，进入绑定页
-(void)_cominToTheTiePage {
    TieThirdPlatFormController *tieInfoVC = [[TieThirdPlatFormController alloc] init];
    tieInfoVC.thirdPlatToken = _thirdPlatToken;
    tieInfoVC.thirdPlatTypeNumber = @(_thirdPlatNum);
    tieInfoVC.thirdPlatOpenID = _thirdPlatOpenID;
//    微信需要unionID ，微博，qq不需要
    if(!unionId){
        tieInfoVC.unionId = @"";
    }else{
         tieInfoVC.unionId = unionId;
    }
   
    [self.navigationController pushViewController:tieInfoVC animated:YES];
}




@end

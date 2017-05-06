//
//  DLAccountSecurityVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/2/20.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLAccountSecurityVC.h"
#import "DLChangePasswordVC.h"
#import "DLReplacePhoneVC.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "UserDataManager.h"
@interface DLAccountSecurityVC ()<TencentSessionDelegate>
@property (nonatomic,strong)TencentOAuth *tencentOAuth;
@property (nonatomic,strong)NSString *openId;
@property (nonatomic,strong)NSString *accessQQToken;


@end

@implementation DLAccountSecurityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"账户安全";
    [self _init];
     _tencentOAuth=[[TencentOAuth alloc]initWithAppId:@"1105559980"andDelegate:self];
    
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
  
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wecahtCode:) name:@"wechatLogin" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [kNotification removeObserver:self];
}

#pragma mark ------------------------Init---------------------------------
- (void)_init {
    
    DLUserInfoModel *userModel = [UserDataManager sharedManager].userInfo;
    NSString *tel = [userModel.userName stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    [self.bindingPhoneBtn setTitle:tel forState:UIControlStateNormal];
    if (!isEmpty(userModel.wechatName)) {
        self.bindingWechatBtn.selected =YES;
       [self.bindingWechatBtn setTitle:userModel.wechatName forState:UIControlStateNormal];
    }else{
        self.bindingWechatBtn.selected =NO;
        [self.bindingWechatBtn setTitle:@"未绑定" forState:UIControlStateNormal];
    }
    
    if (!isEmpty(userModel.qqName)) {
        self.bindingQQBtn.selected =YES;
        [self.bindingQQBtn setTitle:userModel.qqName forState:UIControlStateNormal];
    }else{
        self.bindingQQBtn.selected =NO;
        [self.bindingQQBtn setTitle:@"未绑定" forState:UIControlStateNormal];
    }
    
    
}
#pragma mark ------------------------Private-------------------------

#pragma mark ------------------------Api----------------------------------
//绑定微信
- (void)bindingWechatRequest:(NSDictionary *)dic submitUrl:(NSString *)url {
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:dic subUrl:url block:^(NSDictionary *result, NSError *error) {
        [self hideLoadingHub];
        if (error.code==1) {
            DLUserInfoModel *userModel = [UserDataManager sharedManager].userInfo;
            userModel.wechatName = result[@"entity"][@"nickName"];
            [[UserDataManager sharedManager]saveUserModel:userModel];
            [self _init];
        }
    }];
}
//解绑微信
- (void)UnWechatRequest:(NSDictionary *)dic submitUrl:(NSString *)url{
   
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:dic subUrl:url block:^(NSDictionary *result, NSError *error) {
        [self hideLoadingHub];
        if (error.code==1) {
            DLUserInfoModel *userModel = [UserDataManager sharedManager].userInfo;
            userModel.wechatName = @"";
            [[UserDataManager sharedManager]saveUserModel:userModel];
            [self _init];
        }
        
    }];
    
}

//绑定QQ
- (void)bindingQQRequest:(NSDictionary *)dic submitUrl:(NSString *)url {
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:dic subUrl:url block:^(NSDictionary *result, NSError *error) {
        [self hideLoadingHub];
        if (error.code==1) {
            DLUserInfoModel *userModel = [UserDataManager sharedManager].userInfo;
            userModel.qqName = result[@"entity"][@"nickName"];
            [[UserDataManager sharedManager]saveUserModel:userModel];
            [self _init];
        }
    }];
}
//解绑QQ
- (void)UnQQRequest:(NSDictionary *)dic submitUrl:(NSString *)url{
    
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:dic subUrl:url block:^(NSDictionary *result, NSError *error) {
        [self hideLoadingHub];
        if (error.code==1) {
            DLUserInfoModel *userModel = [UserDataManager sharedManager].userInfo;
            userModel.qqName = @"";
            [[UserDataManager sharedManager]saveUserModel:userModel];
            [self _init];
        }
        
    }];
    
}
#pragma mark ------------------------Page Navigate---------------------------

#pragma mark ------------------------View Event---------------------------
- (IBAction)changePasswordClick:(id)sender {
    
    DLChangePasswordVC *changeVC = [[DLChangePasswordVC alloc]init];
    changeVC.titleLabel = @"修改密码";
    [self navigatePushViewController:changeVC animate:YES];
    
}
- (IBAction)bindingPhoneClick:(id)sender {
    
    DLReplacePhoneVC *bindingVC = [[DLReplacePhoneVC alloc]init];
    [self navigatePushViewController:bindingVC animate:YES];
    
}

- (IBAction)bindingWechatClick:(id)sender {
    if (self.bindingWechatBtn.selected==YES) {
       
        [self showAlertWithTitle:@"提示" message:@"确定要解除绑定" sureTitle:@"确定" cancelTitle:@"取消" sureAction:^(UIAlertAction *action) {
            [self UnWechatRequest:nil submitUrl:kUrl_UnBindingWechat];
        } cancelAction:^(UIAlertAction *action) {
            
        }];
        
    }else{
        
        
        if ([WXApi isWXAppInstalled]){
            
            [self showAlertWithTitle:@"提示" message:@"一里递想要打开微信" sureTitle:@"打开" cancelTitle:@"取消" sureAction:^(UIAlertAction *action) {
                
                SendAuthReq *req =[[SendAuthReq alloc ] init];
                req.scope = @"snsapi_userinfo"; // 此处不能随意改
                req.state = @"123"; // 这个貌似没影响
                [WXApi sendReq:req];
                
            } cancelAction:^(UIAlertAction *action) {
                
            }];
            
        }else{
            
            [Util ShowAlertWithOnlyMessage:@"未安装微信客户端"];
        }

       
    }
   
    
    

}

- (IBAction)bindingQQClick:(id)sender {
    if (self.bindingQQBtn.selected==YES) {
        
        [self showAlertWithTitle:@"提示" message:@"确定要解除绑定" sureTitle:@"确定" cancelTitle:@"取消" sureAction:^(UIAlertAction *action) {
            [self UnQQRequest:nil submitUrl:kUrl_UnBindingQQ];
        } cancelAction:^(UIAlertAction *action) {
            
        }];
        
        
    }else{
    
        
        if ([TencentOAuth iphoneQQInstalled]) {
            
            [self showAlertWithTitle:@"提示" message:@"一里递想要打开QQ" sureTitle:@"打开" cancelTitle:@"取消" sureAction:^(UIAlertAction *action) {
                
                NSArray *permissions= [NSArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo",@"add_t", nil];
                [_tencentOAuth authorize:permissions inSafari:NO];
                
            } cancelAction:^(UIAlertAction *action) {
                
            }];
            
        }else{
            
            [Util ShowAlertWithOnlyMessage:@"未安装QQ客户端"];
            
        }

        
      

    }
    
   

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
        [self bindingQQRequest:dic submitUrl:kUrl_BindingQQ];
        
    }
    else
    {
        [Util ShowAlertWithOnlyMessage:@"绑定不成功没有获取accesstoken"];
        
    }
}

//非网络错误导致登录失败：
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"tencentDidNotLogin");
    if (cancelled)
    {
        [Util ShowAlertWithOnlyMessage:@"用户取消"];
        
    }else{
        
        [Util ShowAlertWithOnlyMessage:@"绑定失败"];
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
    
    NSDictionary *dic = @{@"code":code,@"tradeType":@""};
    [self bindingWechatRequest:dic submitUrl:kUrl_BindingWechat];
    
}




#pragma mark ------------------------Getter / Setter----------------------




@end

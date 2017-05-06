//
//  KJLoginController.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/1.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "KJLoginController.h"
#import "LoginRegisterHelper.h"
#import "Util.h"
#import "RigisterOrForgetPasswordController.h"
#import "XKJHOnlineOrderIncomeDetailController.h"
#import "XKJHTheDetailController.h"
#import "XKJHOfflineOrderManageController.h"
#import "XKJHOfflineSwipeCardController.h"
#import "XKJHCommentManageMentController.h"
#import "UIViewController+MBHud.h"
#import "JGShareView.h"
#import "XKJHRootController.h"
#import "RepyController.h"
#import "XKJHShopEnterInfoViewController.h"
#import "QueryProgressViewController.h"
#import "APService.h"

@interface KJLoginController ()<UITextFieldDelegate> {

    LoginRegisterHelper *_loginHelper;
    MBProgressHUD *hub;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeightConstraint;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *userNameTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *userPasswdTextField;

@end



@implementation KJLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _loginHelper = [[LoginRegisterHelper alloc] init];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.topHeightConstraint.constant = (198.0 / iPhone6_Height) * kScreenHeight;
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    //退出登录需要设置不接收推送消息,暂时这样做
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
    //退出或者被人挤掉的时候要把商户ID和是或否O2O商户判断数据清空
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:kUserDefaultsIsO2OKey];
    [userDefaults setObject:nil forKey:kUserDefaultsUserIDKey];
    [userDefaults synchronize];
    
    
    JGLog(@"%@---%@",[userDefaults objectForKey:kUserDefaultsUserIDKey],[userDefaults objectForKey:kUserDefaultsIsO2OKey]);
    
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = NO;

}


#pragma mark ----------------------- Action Method -----------------------
#pragma mark - 登录
- (IBAction)loginAction:(id)sender {

    [self _beginLoginLogic];
}


#pragma mark - 开始登录逻辑
-(void)_beginLoginLogic {
    NSString *verifyStr = [_loginHelper loginInputVeriryForUserName:self.userNameTextField.text passwd:self.userPasswdTextField.text];
    if (verifyStr) {//说明输入有错误
        [Util ShowAlertWithOnlyMessage:verifyStr];
    }else{
        [self loadHud:self.view];
        hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hub.labelText = @"正在登录..";
        //登录请求
        [_loginHelper beginLoginWithSuccess:^(NSString *sucessToken) {
            //登录成功，跳转
            if (sucessToken) {
                //查询商户审核状态
                [self _queryMerchantsAuditStatus:sucessToken];
            }
        } failed:^(NSString *failedStr) {
            [Util ShowAlertWithOnlyMessage:failedStr];
            [hub hide:YES];
            hub.labelText = @"登录失败";
        }];
    }
}

#pragma mark - 查询商户审核进度
-(void)_queryMerchantsAuditStatus:(NSString *)successToken {
    
    hub.labelText = @"正在查询商户审核状态..";
    VApiManager *vapManager = [[VApiManager alloc] init];
   GroupQueryStoreStatusRequest *request = [[GroupQueryStoreStatusRequest alloc] init:successToken];
    
   [vapManager groupQueryStoreStatus:request success:^(AFHTTPRequestOperation *operation, GroupQueryStoreStatusResponse *response) {
       
      [hub hide:YES];
      DDLogVerbose(@"审核状态响应 %@",response);
       if (response.errorCode.integerValue > 0) {
           [Util ShowAlertWithOnlyMessage:response.subMsg];
           return;
       }
      StoreApplyInfo *storeInfo =  [StoreApplyInfo objectWithKeyValues:response.applyInfo];
       //商户审核状态
       NSInteger merchantAuditStatusNum = storeInfo.storeStatus.integerValue;
       
       DDLogVerbose(@"审核状态数字 %ld",merchantAuditStatusNum);
       if (!merchantAuditStatusNum) {//等于0,提交申请状态
           //进入商户申请资料填写
           XKJHShopEnterInfoViewController *merchantInfoVC = [[XKJHShopEnterInfoViewController alloc] init];
           [self.navigationController pushViewController:merchantInfoVC animated:YES];
       }else if (merchantAuditStatusNum == 15){//审核通过状态
           //进入主页
           [self enterRootView];
           
       }else{//审核失败
           //进入审核进度页
           QueryProgressViewController *queryProgressViewController = [[QueryProgressViewController alloc] init];
           [self.navigationController pushViewController:queryProgressViewController animated:YES];
       }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        hub.labelText = @"请求超时";
        [hub hide:NO];
        [hub hide:YES afterDelay:2.0];
    }];
}


#pragma mark - 进入主界面
- (void)enterRootView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    VApiManager *vapiManager = [[VApiManager alloc]init];
    
    GroupMerchantInfoRequest *request = [[GroupMerchantInfoRequest alloc]init:GetToken];
    WEAK_SELF
    [vapiManager groupMerchantInfo:request success:^(AFHTTPRequestOperation *operation, GroupMerchantInfoResponse *response) {
         NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[response.merchant keyValues]];
        
        NSString *strStoreID = [NSString stringWithFormat:@"%@",dic[@"id"]];
        NSString *strNumIsO2O = [NSString stringWithFormat:@"%@",dic[@"isO2o"]];
        //请求商户的id和是否是O2O商户，存在本地，以备后面使用
        NSUserDefaults *userDefaunlts = [NSUserDefaults standardUserDefaults];
        [userDefaunlts setObject:strStoreID forKey:kUserDefaultsUserIDKey];
        [userDefaunlts setObject:strNumIsO2O forKey:kUserDefaultsIsO2OKey];
        [userDefaunlts synchronize];
        
        [weak_self getUserIdForJPushUse];
        
        XKJHRootController *root = [[XKJHRootController alloc] init];
        
        
        weak_self.view.window.rootViewController = root;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        hub.labelText = @"请求超时";
        [hub hide:NO];
        [hub hide:YES afterDelay:2.0];
    }];
}


#pragma mark - 注册
- (IBAction)registerAction:(id)sender {
    
    RigisterOrForgetPasswordController *rigesterVC = [[RigisterOrForgetPasswordController alloc] init];
    rigesterVC.registerPageType = RegisterType;
    [self.navigationController pushViewController:rigesterVC animated:YES];
    
}


#pragma mark - 忘记密码
- (IBAction)forgetPasswdAction:(id)sender {
    
    RigisterOrForgetPasswordController *fogetPasswdVC = [[RigisterOrForgetPasswordController alloc] init];
    fogetPasswdVC.registerPageType = ForgetPasswordType;
    [self.navigationController pushViewController:fogetPasswdVC animated:YES];
}


#pragma mark ----------------------- text Field delegate -----------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 1) {
        [self.userPasswdTextField becomeFirstResponder];
    }else if (textField.tag == 2) {
        [textField resignFirstResponder];
        [self _beginLoginLogic];
    }
    return YES;
}

#pragma mark ---------获取用户ID并且给ID加上别名，打上标记，以供极光推送区分,同时打开接收推送
- (void)getUserIdForJPushUse
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    
    
    
    
    
   
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *strApiId = [userDefaults objectForKey:kUserDefaultsUserIDKey];

    //        t_ 测试
    //        p_ 生产
    NSString *userAliasStr = [NSString stringWithFormat:@"%@%@",kJPushEnvirStr,strApiId];
    //设置别名
    [APService setTags:nil alias:userAliasStr callbackSelector:nil object:self];
    
    NSLog(@"别名---- %@",userAliasStr);

}








@end

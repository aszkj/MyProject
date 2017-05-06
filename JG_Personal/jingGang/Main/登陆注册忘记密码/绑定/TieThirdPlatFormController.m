//
//  TieThirdPlatFormController.m
//  jingGang
//
//  Created by 张康健 on 15/10/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "TieThirdPlatFormController.h"
#import "ThirdPaltFormLoginHelper.h"
#import "Util.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "GlobeObject.h"
#import "AppDelegate.h"
#import "RepairInfoMationController.h"
#import "IQKeyboardManager.h"

@interface TieThirdPlatFormController () {

    ThirdPaltFormLoginHelper *_thirdPlatFormHelper;

}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *veryCodeTextField;

@end

@implementation TieThirdPlatFormController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JGLog(@"平台类型 nuber %@ 平台 ID %@",_thirdPlatTypeNumber,_thirdPlatOpenID);
    
    [self _init];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] shouldResignOnTouchOutside];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}



- (void)viewWillDisappear:(BOOL)animate {
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}


- (void)_init {
    
    _thirdPlatFormHelper = [[ThirdPaltFormLoginHelper alloc] init];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [Util setNavTitleWithTitle:@"绑定手机号" ofVC:self];
    self.navigationController.navigationBar.barTintColor = status_color;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
}


#pragma mark ----------------------- Action Method -----------------------
- (IBAction)getVeryCode:(UIButton *)sender {
    
    //发送验证码请求之前先验证手机号码
    NSString *veryfyPhoneNumStr = [_thirdPlatFormHelper veryfyPhoneNumberBeforeSendVeryCode:self.phoneNumberTextField.text];
    if (veryfyPhoneNumStr) {
        [Util ShowAlertWithOnlyMessage:veryfyPhoneNumStr];
        return;
    }
    
    //把验证码button交给helper处理
    _thirdPlatFormHelper.veryfyButton = sender;
    //验证码请求
//    [_thirdPlatFormHelper requestVeryCodeForTieThirdPlatformfailed:^(NSString *failedDic) {
//        //发送验证码请求失败，
//        [Util ShowAlertWithOnlyMessage:failedDic];
//    }];
    [_thirdPlatFormHelper requestVeryCodeForTieThirdPlatformfailed:^(NSString *failedStr) {
        //发送验证码请求失败，
        [Util ShowAlertWithOnlyMessage:failedStr];
    } success:^(NSDictionary *sucessDic) {
        [Util ShowAlertWithOnlyMessage:sucessDic[@"successKey"]];
    }];
    
}

- (IBAction)sureAction:(id)sender {
    
    [self _tieLogic];
}


#pragma mark - 绑定逻辑
-(void)_tieLogic {
    NSString *verifyStr = nil;
    verifyStr = [_thirdPlatFormHelper tieThirdInfoInputVeryFyForPhoneNumber:self.phoneNumberTextField.text veryCode:self.veryCodeTextField.text];
    if (verifyStr) {
        [Util ShowAlertWithOnlyMessage:verifyStr];
    }else {
        _thirdPlatFormHelper.thirdPlatFormId = self.thirdPlatOpenID;
        _thirdPlatFormHelper.thirdPlatFormNumber = self.thirdPlatTypeNumber;
        _thirdPlatFormHelper.thirdPlatToken = self.thirdPlatToken;
        _thirdPlatFormHelper.unionId = self.unionId;
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hub.labelText = @"正在绑定..";
        _thirdPlatFormHelper.hub = hub;
        //开始绑定
        [_thirdPlatFormHelper tieThirdPlatFormSuccess:^(NSDictionary *sucessDic) {
            if(self.tagV == 1){
                [self.navigationController popViewControllerAnimated:YES];
                return ;
            }
            hub.labelText = @"登录成功";
            [hub hide:YES afterDelay:0.1];
            [self _enterMainPage];
    
        } failed:^(NSString *failedStr) {
            if(self.tagV == 1){
                [self.navigationController popViewControllerAnimated:YES];
                return ;
            }
            [hub hide:YES afterDelay:0.1];
            if ([failedStr isEqualToString:NotPlatUser]) {//不是平台用户，进入资料补全页
                [self _cominToRepairInfoPage];
            }else {
                [Util ShowAlertWithOnlyMessage:failedStr];
            }
        }];
        
    }
    
}


#pragma mark - 非平台账号进入补全信息页面
-(void)_cominToRepairInfoPage {

    RepairInfoMationController *repairVC = [[RepairInfoMationController alloc] init];
    repairVC.thirdPlatToken = self.thirdPlatToken;
    repairVC.thirdPlatOpenID = self.thirdPlatOpenID;
    
    repairVC.thirdPlatTypeNumber = self.thirdPlatTypeNumber;
    repairVC.phoneNumber = self.phoneNumberTextField.text;
    repairVC.wxunionId = self.unionId;
    [self.navigationController pushViewController:repairVC animated:YES];
    

}

#pragma mark - 进入主页
- (void)_enterMainPage {
    AppDelegate * app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [app gogogoWithTag:0];
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

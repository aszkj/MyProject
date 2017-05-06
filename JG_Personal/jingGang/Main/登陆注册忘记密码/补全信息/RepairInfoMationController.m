//
//  RepairInfoMationController.m
//  jingGang
//
//  Created by 张康健 on 15/10/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "RepairInfoMationController.h"
#import "ThirdPaltFormLoginHelper.h"
#import "Util.h"
#import "GlobeObject.h"
#import "AppDelegate.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "IQKeyboardManager.h"
#import "KeyboardNextActionHander.h"

@interface RepairInfoMationController () {

    ThirdPaltFormLoginHelper *_thirdPlatLoginHelper;
    KeyboardNextActionHander *_keyBoardNextHander;
}

@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *againPasswdTextField;
@property (weak, nonatomic) IBOutlet UITextField *registerInvitationCodeTextfield;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@end

@implementation RepairInfoMationController

/**
 *  补全信息页面
 */
- (void)viewDidLoad {
    [super viewDidLoad];
   
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

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    _keyBoardNextHander = [[KeyboardNextActionHander alloc] initWithBodyView:self.view goNextByType:GoNextByPosition];
    WEAK_SELF;
    _keyBoardNextHander.lastNextBlock = ^{
        [weak_self repareInfoLogic];
    };
    
}




#pragma mark ----------------------- private Method -----------------------
-(void)_init {
    
    
    _thirdPlatLoginHelper = [[ThirdPaltFormLoginHelper alloc] init];
    self.phoneNumberLabel.text = self.phoneNumber;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [Util setNavTitleWithTitle:@"补全信息" ofVC:self];
   
    self.navigationController.navigationBar.barTintColor = status_color;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
}


- (void)repareInfoLogic {
    NSString *veryfyStr = nil;
    veryfyStr = [_thirdPlatLoginHelper repareInfoMationForNickName:self.nickNameTextField.text passwd:self.passwdTextFiled.text againPasswd:self.againPasswdTextField.text invitationCode:self.registerInvitationCodeTextfield.text];
    if (veryfyStr) {
        [Util ShowAlertWithOnlyMessage:veryfyStr];
    }else {
        _thirdPlatLoginHelper.outPhoneNumber = self.phoneNumber;
        _thirdPlatLoginHelper.thirdPlatFormId = self.thirdPlatOpenID;
        _thirdPlatLoginHelper.thirdPlatFormNumber = self.thirdPlatTypeNumber;
        _thirdPlatLoginHelper.thirdPlatToken = self.thirdPlatToken;
        _thirdPlatLoginHelper.unionId = self.wxunionId;
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hub.labelText = @"正在补全资料..";
        _thirdPlatLoginHelper.hub = hub;
        [_thirdPlatLoginHelper repareiInfoSuccess:^(NSDictionary *sucessDic) {
            hub.labelText = @"登录成功";
            [hub hide:YES afterDelay:0.1];
            [self _enterMainPage];
            
        } failed:^(NSString *failedStr) {
            [hub hide:YES afterDelay:0.1];
            [Util ShowAlertWithOnlyMessage:failedStr];
        }];
    }
    
}

#pragma mark - 进入主页
- (void)_enterMainPage {
    AppDelegate * app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [app gogogoWithTag:0];
}


#pragma mark ----------------------- Action Method -----------------------
- (IBAction)makeSureAction:(id)sender {
    
    [self repareInfoLogic];

}


- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

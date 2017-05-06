//
//  XKUpdatePasswdController.m
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKUpdatePasswdController.h"
#import "UpdatePasswdView.h"
#import "XKWithDrawCashView.h"
#import "UpdatePasswdHeiper.h"

@interface XKUpdatePasswdController () {

    UpdatePasswdView   *_updatePasswdView;
    XKWithDrawCashView *_drawCashView;
    UpdatePasswdHeiper *_updatePasswdHelper;
    BOOL                _hasGetAccountPhoneInfo;
}
@property (nonatomic, strong)UpdatePasswdHeiper *updatePasswdHelper;

@property (nonatomic, strong)XKWithDrawCashView *drawCashView;



@end

@implementation XKUpdatePasswdController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _init];
    if (self.updatePasswdType == UpdateRefundPasswd) {
        //获取运营商基本信息
        [self _getOperatorBaseInfo];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    if (self.updatePasswdType == UpdatePasswd) {//修改密码
        self.topBarHMSegmentedControl.selectedSegmentIndex = 0;
        _updatePasswdView.hidden = NO;
        _drawCashView.hidden = YES;
    }else {
        self.topBarHMSegmentedControl.selectedSegmentIndex = 1;
        _updatePasswdView.hidden = YES;
        _drawCashView.hidden = NO;
    }
}


#pragma mark ----------------------- private Method -----------------------
- (void)_init {
    _hasGetAccountPhoneInfo = NO;
    self.topVCtitle = @"修改密码";
    self.sectionTitles = @[@"修改登录密码",@"修改提现密码"];
    _updatePasswdHelper = [[UpdatePasswdHeiper alloc] init];
    //加载内容视图
    _updatePasswdView = (UpdatePasswdView *)[self loadContentViewWithName:@"UpdatePasswdView"];
//    _updatePasswdView.hidden = NO;
    //修改密码
    WEAK_SELF
    _updatePasswdView.updatePasswdSureBlock = ^(NSString *oldPasswd,NSString *newPasswd,NSString *againPasswd){
        NSString *verifyStr = nil;
        verifyStr = [weak_self.updatePasswdHelper updatePasswdInputVeriryForOldPasswd:oldPasswd newPasswd:newPasswd againPasswd:againPasswd];
        if (verifyStr) {
            [Util ShowAlertWithOnlyMessage:verifyStr];
        }else {
            MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:weak_self.view animated:YES];
            hub.labelText = @"正在修改登录密码..";
            [weak_self.updatePasswdHelper beginUpdatePasswdSuccess:^{
                [hub hide:YES];
                [Util ShowAlertWithOnlyMessage:@"修改登录密码成功"];
                [weak_self performSelector:@selector(back) withObject:nil afterDelay:0.5];
            } failed:^(NSString *errorStr) {
                [hub hide:YES];
                [Util ShowAlertWithOnlyMessage:errorStr];
            }];
        }
    };
    
    _drawCashView = (XKWithDrawCashView *)[self loadContentViewWithName:@"XKWithDrawCashView"];
    
    //验证码
    _drawCashView.drawCashSendVeryCodeBlock = ^(NSString *phoneNum){
        //发送验证码请求之前先验证手机号码
        NSString *veryfyPhoneStr = [weak_self.updatePasswdHelper veryfyPhoneNumberBeforeSendVeryCode:phoneNum];
        if (veryfyPhoneStr) {
            [Util ShowAlertWithOnlyMessage:veryfyPhoneStr];
        }else {

            weak_self.updatePasswdHelper.veryfyButton = weak_self.drawCashView.sendVeryCodeButton;
            [weak_self.updatePasswdHelper requestVeryCodefailed:^(NSString *errorStr) {
                [Util ShowAlertWithOnlyMessage:errorStr];
            }];
        }
    };
    
    //修改体现密码
    _drawCashView.drawCashUpdatePasswdSureBlock = ^(NSString *phoneNum,NSString *veryCode,NSString *newPasswd,NSString *againPasswd) {
        NSString *verifyStr = nil;
        verifyStr = [weak_self.updatePasswdHelper updateDrawCashPasswdInputVeriryForPhoneNum:phoneNum veryCode:veryCode newPasswd:newPasswd againPasswd:againPasswd];
        if (verifyStr) {
            [Util ShowAlertWithOnlyMessage:verifyStr];
        }else {
            MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:weak_self.view animated:YES];
            hub.labelText = @"正在修改提现密码..";
            [weak_self.updatePasswdHelper beginDrawCashUpdatePasswdSuccess:^{
                [hub hide:YES];
                [Util ShowAlertWithOnlyMessage:@"修改提现密码成功"];
                [weak_self performSelector:@selector(back) withObject:nil afterDelay:0.5];
            } failed:^(NSString *errorStr) {
                [hub hide:YES];
                [Util ShowAlertWithOnlyMessage:errorStr];
            }];
        }
    };
    self.contentViewsArr = @[_updatePasswdView,_drawCashView];
    
}


- (void)_getOperatorBaseInfo {
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.labelText = @"正在获取账户手机号码..";
    VApiManager *vapManager = [[VApiManager alloc] init];
    OperatorInfoGetRequest *request = [[OperatorInfoGetRequest alloc] init:GetToken];
    
    [vapManager operatorInfoGet:request success:^(AFHTTPRequestOperation *operation, OperatorInfoGetResponse *response) {
        [hub hide:YES];
        if (response.errorCode.integerValue == 2) {
            [Util ShowAlertWithOnlyMessage:response.subMsg];
            [self _getUserPhoneInfoFailed];
            return ;
        }
        OperatorInfo *operatorInfo = [OperatorInfo objectWithKeyValues:response.operatorInfo];
        DDLogVerbose(@"运营商手机号码: %@",operatorInfo.phone);
        if (operatorInfo.phone) {
            _drawCashView.phoneNumTextField.text = operatorInfo.phone;
            _hasGetAccountPhoneInfo = YES;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [hub hide:YES];
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
        [self _getUserPhoneInfoFailed];
        
    }];
}


-(void)_getUserPhoneInfoFailed {
    _drawCashView.phoneNumTextField.text = @"获取手机号码失败";
    _drawCashView.sendVeryCodeButton.enabled = NO;
    [_drawCashView.sendVeryCodeButton setTitle:@"无法发送" forState:UIControlStateDisabled];
}



#pragma mark ----------------------- Action Method ------------------------
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    //由父类处理显示隐藏
    [super segmentedControlChangedValue:segmentedControl];
    if (segmentedControl.selectedSegmentIndex == 1) {
        if (!_hasGetAccountPhoneInfo) {
            [self _getOperatorBaseInfo];
        }
    }
    
}//点击上面的tabbar选项


- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


@end

//
//  JGCloudValueController.m
//  jingGang
//
//  Created by dengxf on 16/1/6.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import "JGCloudValueController.h"
#import "JGPayCloudView.h"
#import "JGPayResultController.h"
#import "JGCashView.h"
#import "IQKeyboardManager.h"
#import "JGSettingPayPasswordController.h"
#import "JGCloudAndValueManager.h"
#import "UIAlertView+Extension.h"

@interface JGCloudValueController ()

@property (assign, nonatomic) BottomButtonType buttonType;

/**
 *  查询用户默认提现账户表单
 */
@property (strong,nonatomic) CloudForm *cloudPredepositCash;

/**
 *  云币提现视图 */
@property (strong,nonatomic) JGCashView *cashView;
/**
 *  云币充值视图 */
@property (strong,nonatomic) JGPayCloudView *payCloudView;

@end

@implementation JGCloudValueController

/**
 *  初始化
 */
- (instancetype)initWithControllerType:(BottomButtonType)buttonType {
    if (self = [super init]) {
        self.buttonType = buttonType;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.buttonType == BottomButtonCashType) {
        // 如果是云币提现会查询默认提现银行
        [[IQKeyboardManager sharedManager] setEnable:YES];
        [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
        WeakSelf;
        [self showHud];
        [JGCloudAndValueManager inquiryCashDefaultsType:^(CloudForm *cloudPredepositCash) {
            JGLog(@"已查到默认支付方式");
            // 用户已提现过云币
            JGLog(@"默认支付表单:%@",cloudPredepositCash);
            [bself hiddenHud];
            bself.cashView.cloudPredepositCash = cloudPredepositCash;
        } fail:^{
            JGLog(@"未设置默认支付方式");
            [bself hiddenHud];
        } error:^(NSError *error) {
            [bself hiddenHud];
            [UIAlertView xf_showWithTitle:@"网络错误,请重新再试" message:nil onDismiss:^{
                [bself.navigationController popViewControllerAnimated:YES];
            }];
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configContentInterface];
}

- (void)configContentInterface {
    // 添加返回键
    [self setupNavBarPopButton];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = JGColor(245, 245, 245, 1);
    switch (self.buttonType) {
        case BottomButtonPayType:
        {
            [self setupNavBarTitleViewWithText:@"云币充值"];
            WeakSelf;
            JGPayCloudView *payView = [[JGPayCloudView alloc] initWithPaySuccess:^(BOOL payResult, id response) {
                
                StrongSelf;
                JGPayResultController *resultController = [[JGPayResultController alloc] initWithResposeObj:response];
                [strongSelf.navigationController pushViewController:resultController animated:YES];
                
            } superController:self.navigationController];
            payView.x = 0;
            payView.y = 0;
            payView.width = ScreenWidth;
            payView.height = ScreenHeight;
            [self.view addSubview:payView];
            self.payCloudView = payView;
        }
            break;
        case BottomButtonCashType:
        {
            [self setupNavBarTitleViewWithText:@"云币提现"];
            WeakSelf;
            JGCashView *cashView = [[JGCashView alloc] initWithCashActionSuccess:^(CloudBuyerCashSaveResponse *response) {
                // 提现成功 返回成功的信息
                StrongSelf;
                [strongSelf.view endEditing:YES];
                JGPayResultController *resultController =[[JGPayResultController alloc] initWithResposeObj:response];
                [strongSelf.navigationController pushViewController:resultController animated:NO];
            }];
            cashView.x = 0;
            cashView.y = 0;
            cashView.width = ScreenWidth;
            cashView.height = ScreenHeight;
            cashView.totleValue = self.totleValue;
            cashView.settingPayPasswordAction = ^(JGSettingPayPasswordType type){
                StrongSelf;
                NSString *title;
                switch (type) {
                    case SettingPayPasswordType:
                        title = @"设置支付密码";
                        break;
                    case ForgetPayPasswordType:
                        title = @"重新设置密码";
                    default:
                        break;
                }
                JGSettingPayPasswordController *settingPasswordController = [[JGSettingPayPasswordController alloc] initWithTitile:title];
                [strongSelf.navigationController pushViewController:settingPasswordController animated:NO];
            };
            [self.view addSubview:cashView];
            self.cashView = cashView;
        }
            break;
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(void)dealloc {
    JGLog(@"dealloc");
}

@end

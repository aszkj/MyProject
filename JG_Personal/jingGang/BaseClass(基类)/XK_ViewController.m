//
//  XK_ViewController.m
//  jingGang
//
//  Created by ray on 15/10/20.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "XK_ViewController.h"
#import "UIButton+Block.h"
#import "loginViewController.h"
#import "MJRefresh.h"
#import "KeyboardManager.h"
#import "AppDelegate.h"

@interface XK_ViewController () <UIAlertViewDelegate>

@end

@implementation XK_ViewController
#define KInvalidTokenErrorCode     @"您的账号已失效,请重新登录!"
#define Token @"access_token"

- (void)dealloc {
    NSLog(@"dealloc--%@",[self class]);
    [self.vapiManager.operationQueue cancelAllOperations];
    [self.viewModel.client.vapiManager.operationQueue cancelAllOperations];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setCanAdjustTextView:YES];
}

- (void)viewWillDisappear:(BOOL)animate {
    [super viewWillDisappear:animate];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setCanAdjustTextView:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindViewModel];
    [self setUIAppearance];
}

- (void)setUIAppearance {
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self setLeftBarAndBackgroundColor];
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.tintColor = [UIColor whiteColor];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    navBar.translucent = NO;
    navBar.barTintColor = status_color;
}

- (void)bindViewModel {
    @weakify(self);
    RAC(self,title) = RACObserve(self.viewModel, title);
    [RACObserve(self.viewModel, isExcuting) subscribeNext:^(NSNumber *isExcuting) {
        @strongify(self);
        if ([isExcuting boolValue]) {
            [self.view showLoading];
        }
        else    [self.view hideLoading];
    }];
    [[RACObserve(self.viewModel, error) filter:^BOOL(NSError *value) {
        return value != nil;
    }] subscribeNext:^(NSError *error) {
        @strongify(self);
        if (self.closeDefaultErrorInform) return;
        NSString *errorMessage = @"未知错误";
        if (error.localizedDescription.length > 0) {
            errorMessage = error.localizedDescription;
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        if (error.code == 2 || [errorMessage rangeOfString:KInvalidTokenErrorCode].length > 0) {
            [alertView setMessage:KInvalidTokenErrorCode];
            //退出登录需要设置不接收推送消息,暂时这样做
            [[UIApplication sharedApplication] unregisterForRemoteNotifications];
            [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber *indexNumber) {
                AppDelegate * app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
                [app beGinLogin];
            }];
        } else {
            [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber *indexNumber) {
                [self specErrorHandle:error];
            }];
        }
        
        [alertView show];
    }];
}

- (void)specErrorHandle:(NSError *)error {

}

- (void)errorHandle:(NSError *)error {
    if (error.code == 3840) {
        [Util ShowAlertWithOnlyMessage:@"服务器连接失败"];
    }
    else
    {
        [Util ShowAlertWithOnlyMessage:@"网络连接错误，请检查网络..."];
    }
}

- (XKO_ViewModel *)viewModel {
    return nil;
}
- (VApiManager *)vapiManager
{
    if (_vapiManager == nil) {
        _vapiManager = [[VApiManager alloc ]init];
    }
    return _vapiManager;
}


@end

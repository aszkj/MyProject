//
//  XKJHBaseController.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHBaseController.h"
#import "KJLoginController.h"
@interface XKJHBaseController () 

@end

@implementation XKJHBaseController

- (void)dealloc
{
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)hideHubWithOnlyText:(NSString *)hideText {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hideText;
    hud.margin = 10.f;
    hud.yOffset = 80.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)init
{
    if (self = [super init]) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    [self setUIAppearance];
    [self bindViewModel];
}

- (void)bindViewModel {
    @weakify(self);
    RAC(self,title) = RACObserve(self.viewModel, title);
    [RACObserve(self.viewModel, isExcuting) subscribeNext:^(NSNumber *isExcuting) {
        @strongify(self);
        if ([isExcuting boolValue]) {
            [self.view showLoading];
            self.viewModel.active = YES;
        }
        else    [self.view hideLoading];
    }];
    [[RACObserve(self.viewModel, error) filter:^BOOL(NSError *value) {
        return value != nil;
    }] subscribeNext:^(NSError *error) {
        @strongify(self);
        NSString *errorMessage = @"未知错误";
        if (error.localizedDescription.length > 0) {
            errorMessage = error.localizedDescription;
        }
       
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        if (error.code == 2) {
            [alertView setMessage:@"您的账号已经失效,请重新登录"];
            [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber *indexNumber) {
                KJLoginController *login = [[KJLoginController alloc] init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
                [kUserDefaults removeObjectForKey:Token];
                [kUserDefaults synchronize];
                self.view.window.rootViewController = nav;
            }];
        } else {
            [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber *indexNumber) {
                [self errorHandle:error];
            }];
        }
        [alertView show];
    }];
}

#pragma mark - private Method
- (void)errorHandle:(NSError *)error {
   
}


- (XKO_ViewModel *)viewModel {
    return nil;
}

- (void)setBarButtonItem {
    if (self.navigationController.viewControllers.count == 1) return;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(goBack) target:self];
}

- (void)setNavigationBar {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    navBar.barTintColor = status_color;
    navBar.translucent = NO;
}

- (void)setUIAppearance {
    [self setBarButtonItem];
    [self setNavigationBar];
    self.view.backgroundColor = VCBackgroundColor;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (VApiManager *)vapManager
{
    if (!_vapManager) {
        _vapManager = [[VApiManager alloc] init];
    }
    return _vapManager;
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)getHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    return headerView;
}

@end

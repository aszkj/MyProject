//
//  XKJHBaseController.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "DLBuyerBaseController.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIViewController+hub.h"
#import "UIViewController+showHiddenBottomBarHandle.h"
#import "ProjectRelativeMaco.h"
#import "UIImage+GIF.h"

const CGFloat defaulDelayGoBackSeconds = 1.2;

@interface DLBuyerBaseController ()

@property (nonatomic, strong)MBProgressHUD *loadingHub;

@property (nonatomic,strong)AlertViewManager *alertManager;

@property (nonatomic,strong)UIView*loadingBgView;

@end

@implementation DLBuyerBaseController

- (void)dealloc
{
#ifdef DEBUG
     DDLogVerbose(@"Debug Delloced VC %@",NSStringFromClass([self class]));
#else
    
#endif
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

- (MBProgressHUD *)showLoadingHub {
    
    
    return [self showLoadingHubWithText:nil];
}

- (MBProgressHUD *)showLoadingHubWithText:(NSString *)loadingText {
    
    self.loadingHub = [self MB_showLoadingHubWithText:loadingText];

    return self.loadingHub;
}

- (void)hideLoadingHub {
    
    [self MB_hideLoadingHub];
}


- (void)navigatePushViewController:(UIViewController *)viewController
                           animate:(BOOL)animate
{

    NSAssert(self.navigationController.viewControllers.count >= 1, @"该控制器还未被加入导航控制器中");
    [self.navigationController pushViewController:viewController animated:animate];
}


- (void)hideHubForText:(NSString *)hideText{
    
    [self MB_hideHubForText:hideText];
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
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self showHiddenBottomBarHandle];
}



- (void)showSimplyAlertWithTitle:(NSString *)alertTitle
                         message:(NSString *)alertMessage
                      sureAction:(AlertViewAction)sureAction

{
    [self.alertManager showAlertViewWithControllerTitle:alertTitle message:alertMessage controllerStyle:UIAlertControllerStyleAlert isHaveTextField:NO actionTitle:@"确定" actionStyle:UIAlertActionStyleDefault alertViewAction:^(UIAlertAction *action) {
        if (sureAction) {
            sureAction(action);
        }
    }];
}


- (void)showSimplyAlertWithTitle:(NSString *)alertTitle
                         message:(NSString *)alertMessage
                      sureAction:(AlertViewAction)sureAction
                    cancelAction:(AlertViewOtherAction)cancelAction
{

    //两个action
    [self.alertManager showAlertViewWithControllerTitle:alertTitle message:alertMessage controllerStyle:UIAlertControllerStyleAlert isHaveTextField:NO actionTitle:@"确定" actionStyle:UIAlertActionStyleDefault alertViewAction:^(UIAlertAction *action) {
        if (sureAction) {
            sureAction(action);
        }
    } otherActionTitle:@"取消" otherActionStyle:UIAlertActionStyleDefault otherAlertViewAction:^(UIAlertAction *action) {
        if (cancelAction) {
            cancelAction(action);
        }
    }];
}

- (void)showAlertWithTitle:(NSString *)alertTitle
                   message:(NSString *)alertMessage
                 sureTitle:(NSString *)sureTitle
               cancelTitle:(NSString *)cancelTitle
                sureAction:(AlertViewAction)sureAction
              cancelAction:(AlertViewOtherAction)cancelAction
{

    //两个action
    [self.alertManager showAlertViewWithControllerTitle:alertTitle message:alertMessage controllerStyle:UIAlertControllerStyleAlert isHaveTextField:NO actionTitle:sureTitle actionStyle:UIAlertActionStyleDefault alertViewAction:^(UIAlertAction *action) {
        if (sureAction) {
            sureAction(action);
        }
    } otherActionTitle:cancelTitle otherActionStyle:UIAlertActionStyleDefault otherAlertViewAction:^(UIAlertAction *action) {
        if (cancelAction) {
            cancelAction(action);
        }
    }];
}


#pragma mark - private Method
- (void)errorHandle:(NSError *)error {
   
}

-(void)setPageTitle:(NSString *)pageTitle {
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    titleLable.font = [UIFont systemFontOfSize:18.0];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = UIColorFromRGB(0x333333);
    titleLable.text = pageTitle;
    self.navigationItem.titleView = titleLable;
}

- (void)setBarButtonItem {
    if (self.navigationController.viewControllers.count == 1) return;
    if (self.doNotNeedBaseBackItem){
       self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
        return;
    }
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initDLSalerBackItemWihtAction:@selector(goBack) target:self];
}

- (void)setNavigationBar {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
//    navBar.barTintColor = status_color;
    navBar.translucent = NO;
}

- (AlertViewManager *)alertManager {

    if (!_alertManager) {
        _alertManager = [[AlertViewManager alloc] init];
    }
    return _alertManager;
}

- (void)setUIAppearance {
    [self setBarButtonItem];
    self.navigationController.navigationBar.translucent = NO;
//    [self setNavigationBar];
//    self.view.backgroundColor = VCBackgroundColor;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)goBackAfter:(NSInteger)seconds {

    [self performSelector:@selector(goBack) withObject:nil afterDelay:seconds];
}

- (void)delayGoBack {

    [self goBackAfter:defaulDelayGoBackSeconds];
    
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

#pragma mark -------------------Notification Method----------------------


@end

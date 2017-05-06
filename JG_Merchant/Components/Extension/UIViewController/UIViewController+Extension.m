//
//  UIViewController+DebugJump.m
//  jingGang
//
//  Created by thinker on 15/8/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "PublicInfo.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "MBProgressHUD.h"
#include <objc/runtime.h>

@implementation UIViewController (Extension)

+ (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    if ([topVC isKindOfClass:[UINavigationController class]]) {
        topVC = ((UINavigationController *)topVC).topViewController;
    }
    return topVC;
}

+ (UIViewController *)activityViewController
{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if(tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]]) {
            activityViewController = nextResponder;
        } else {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
}


- (void)setLeftBarAndBackgroundColor
{
    if (self.navigationController.viewControllers.count != 1 ||
        self.navigationController.presentingViewController) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    }
    self.view.backgroundColor = VCBackgroundColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)btnClick
{
    if (self.navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)addBackButtonIfNeed
{
    if (self.navigationController.viewControllers.count != 1) {
        return;
    }
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)setupNavBarTitleViewWithText:(NSString *)text {
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont systemFontOfSize:20.0];
    titleLable.text = text;
    titleLable.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLable;
}

- (void)setupNavBarPopButton {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(backToLastController) target:self];
}

- (void)backToLastController {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)backToMain {
    if (self.navigationController.presentingViewController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{

        }];
    }
}


- (void)addJumpButton:(SEL)action title:(NSString *)title
{
    CGSize size = [self.view bounds].size;
    
    UIButton *button = [[UIButton alloc] initWithFrame:
                        CGRectMake(20, size.height - 40,
                                   size.width-40, 40)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    if ([self respondsToSelector:action]) {
        [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)hiddenBottomBar {
    self.hidesBottomBarWhenPushed = YES;
    self.navigationController.tabBarController.tabBar.hidden = YES;
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


@end

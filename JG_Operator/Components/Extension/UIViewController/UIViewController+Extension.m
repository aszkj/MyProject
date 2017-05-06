//
//  UIViewController+DebugJump.m
//  jingGang
//
//  Created by thinker on 15/8/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "UIViewController+Extension.h"
#import <objc/runtime.h>
//#import "PublicInfo.h"
//#import "UIBarButtonItem+WNXBarButtonItem.h"

@implementation UIViewController (Extension)

- (void)setLeftBar
{
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
}

- (void)hiddenBottomBar {
    self.hidesBottomBarWhenPushed = YES;
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)backToMain {
    if (self.navigationController.presentingViewController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{

        }];
    }
}

- (void)addJumpButton:(UIViewController *)VC title:(NSString *)title;
{
#ifdef DEBUG
    CGSize size = [self.view bounds].size;
    
    UIButton *button = [[UIButton alloc] initWithFrame:
                        CGRectMake(20, size.height - 40,
                                   size.width-40, 40)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    objc_setAssociatedObject(button, "firstObject", VC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [button addTarget:self action:@selector(jumpToVC:) forControlEvents:UIControlEventTouchUpInside];
#endif
}

- (void)jumpToVC:(UIButton *)button
{
    UIViewController *VC = objc_getAssociatedObject(button, "firstObject");
    if (self.navigationController == nil) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    } else {
        [self.navigationController pushViewController:VC animated:YES];
    }
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

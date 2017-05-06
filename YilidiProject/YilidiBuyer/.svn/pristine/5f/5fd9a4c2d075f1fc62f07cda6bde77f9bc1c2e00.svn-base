//
//  UIViewController+unLoginHandle.m
//  YilidiBuyer
//
//  Created by yld on 16/6/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "UIViewController+unLoginHandle.h"
#import "DLLoginVC.h"
#import "GlobleConst.h"
#import "ProjectRelativeDefineNotification.h"
#import "ProjectRelativEmerator.h"
#import "DLMainTabBarController.h"

@implementation UIViewController (unLoginHandle)

- (BOOL)unloginHandle {
    
    if (UserIsLogin) {
        return YES;
    }
    
    DLLoginVC *loginVC = [[DLLoginVC alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
//    [self presentViewController:loginVC animated:YES completion:nil];
    return NO;
}

- (void)registerComeToLoginPageFromPerHomePageNotification {
    [kNotification addObserver:self selector:@selector(comeToLoginPageFromPerhomePage:) name:KNotificationCometoLoginPageFromPerhomePage object:nil];
}

- (void)comeToLoginPageFromPerhomePage:(NSNotification *)info {
    
    NSNumber *homeIndex = info.object;
    DLLoginVC *loginVC = [[DLLoginVC alloc] init];
    if (homeIndex.integerValue == ShopCartPageIndex) {
        loginVC.comeToLoginPageType = UnloginedComin_FromNormalPageToShopCartToLoginPage;
    }else {
        loginVC.comeToLoginPageType = UnloginedComin_FromPerHomePageNotShopCartAndFirstHomePage;
        [loginVC comFromPerHomePageOfIndex:homeIndex.integerValue backBlock:^(NSInteger backHomePageIndex) {
            DLMainTabBarController *mainVC = (DLMainTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            [mainVC setTabIndex:backHomePageIndex];
        }];
    }
    [self.navigationController pushViewController:loginVC animated:YES];
//    [self presentViewController:loginVC animated:YES completion:nil];

}



@end

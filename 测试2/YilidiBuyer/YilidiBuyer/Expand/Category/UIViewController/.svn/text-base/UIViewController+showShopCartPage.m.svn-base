//
//  UIViewController+showShopCartPage.m
//  YilidiBuyer
//
//  Created by yld on 16/6/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "UIViewController+showShopCartPage.h"
#import "ProjectRelativeDefineNotification.h"
#import "DLShopCarVC.h"

@implementation UIViewController (showShopCartPage)

- (void)registerShowShowCartPageNotification {

    [kNotification addObserver:self selector:@selector(selectShopCartPage:) name:KNotificationSelectShopCartHomePage object:nil];
}


- (void)selectShopCartPage:(NSNotification *)info {
    DLShopCarVC *shopCartVC = [[DLShopCarVC alloc] init];
    shopCartVC.cominFromPerhomePage = YES;
    [self.navigationController pushViewController:shopCartVC animated:YES];
}


@end

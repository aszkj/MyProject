//
//  ShopCartGoodsManager+loginOut.m
//  YilidiBuyer
//
//  Created by yld on 16/6/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsManager+loginOut.h"
#import "ProjectRelativeDefineNotification.h"
#import "ShopCartGoodsManager+request.h"
@implementation ShopCartGoodsManager (loginOut)

- (void)registerLoginOutNotification {
    
    [kNotification addObserver:self selector:@selector(_observeLogin:) name:KNofiticationLogIn object:nil];
    [kNotification addObserver:self selector:@selector(_observeLogout:) name:KNofiticationLogout object:nil];
}

#pragma mark -------------------Private Method----------------------
- (void)_loginLogic {
//    [self requestSychronizeShopCartData];
}

- (void)_logOutLogic {
    [self clearAllShopCartData];
}

#pragma mark -------------------Notification Method----------------------
- (void)_observeLogin:(NSNotification *)notification {
    [self _loginLogic];
}

- (void)_observeLogout:(NSNotification *)notification {
    [self _logOutLogic];
}


@end

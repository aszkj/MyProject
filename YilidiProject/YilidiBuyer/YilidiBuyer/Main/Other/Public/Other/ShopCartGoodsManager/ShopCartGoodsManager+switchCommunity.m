//
//  ShopCartGoodsManager+switchCommunity.m
//  YilidiBuyer
//
//  Created by yld on 16/6/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsManager+switchCommunity.h"
#import "ProjectRelativeDefineNotification.h"
#import "ShopCartGoodsManager+request.h"
#import "GlobleConst.h"

@implementation ShopCartGoodsManager (switchCommunity)

- (void)registerSwitchCommunityNotification {
    
//    [kNotification addObserver:self selector:@selector(_observeSwitchCommunity:) name:KNotificationSwitchCommunity object:nil];
    
}

#pragma mark -------------------Private Method----------------------
- (void)switchCommunityLogic {
    if (UserIsLogin) {
        [self requestClearShopCartData];
    }
    [self clearAllShopCartData];
}

#pragma mark -------------------Notification Method----------------------
- (void)_observeSwitchCommunity:(NSNotification *)notification {
    [self switchCommunityLogic];
}



@end

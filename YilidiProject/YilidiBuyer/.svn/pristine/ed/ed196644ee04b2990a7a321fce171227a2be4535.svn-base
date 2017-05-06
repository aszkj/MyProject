//
//  DLCordovaH5VC+pageJump.m
//  YilidiBuyer
//
//  Created by mm on 17/3/29.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLCordovaH5VC+pageJump.h"
#import "Operation.h"
#import "DLShopCarVC.h"
#import "DLLoginVC.h"
#import "DLOrderListVC.h"
#import "DLOrderDetailsVC.h"
#import "DLIndividulBrandVC.h"
#import "DLIndividulClassVC.h"

@implementation DLCordovaH5VC (pageJump)

- (void)initPageJumpPluin {
    
    Operation *operation = (Operation *)[self getCommandInstance:@"Operation"];
    WEAK_SELF
    operation.htmlToCartPageBlock = ^{
        [weak_self _enterShopCartPage];
    };
    
    operation.htmlToLoginPageBlock = ^{
        [weak_self _enterLoginPage];
    };
    
    operation.htmlToOrderlistPageBlock = ^{
        [weak_self _enterOrderListPage];
    };
    
    operation.htmlToOrderDetailPageBlock = ^(NSString *orderNo){
        [weak_self _enterOrderDetailPageWithOrderNo:orderNo];
    };

    operation.htmlToClassPageBlock = ^{
        [weak_self _enterClassPage];
    };
    
    operation.htmlToBrandPageBlock = ^{
        [weak_self _enterBrandPage];
    };
}

- (void)_enterShopCartPage {
    DLShopCarVC *shopCartPage = [[DLShopCarVC alloc] init];
    [self.navigationController pushViewController:shopCartPage animated:YES];
}

- (void)_enterLoginPage {
    DLLoginVC *loginPage = [[DLLoginVC alloc] init];
    [self.navigationController pushViewController:loginPage animated:YES];
}

- (void)_enterOrderListPage {
    DLOrderListVC *orderListPage = [[DLOrderListVC alloc] init];
    [self.navigationController pushViewController:orderListPage animated:YES];
}

- (void)_enterOrderDetailPageWithOrderNo:(NSString *)orderNo {
    DLOrderDetailsVC *orderDetailPage = [[DLOrderDetailsVC alloc] init];
    orderDetailPage.orderNo = orderNo;
    [self.navigationController pushViewController:orderDetailPage animated:YES];
}

- (void)_enterClassPage {
    DLIndividulClassVC *classPage = [[DLIndividulClassVC alloc] init];
    [self.navigationController pushViewController:classPage animated:YES];
}

- (void)_enterBrandPage {
    DLIndividulBrandVC *brandPage = [[DLIndividulBrandVC alloc] init];
    [self.navigationController pushViewController:brandPage animated:YES];
}





@end

//
//  DLOrderPaySuccessVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/7/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderPaySuccessVC.h"
#import "DLMainTabBarController.h"
#import "DLOrderDetailsVC.h"
#import "DLPayResultPageModel.h"

@interface DLOrderPaySuccessVC ()


@end

@implementation DLOrderPaySuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"支付成功";
    [self _requestPayResultPageData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------------------Api Method----------------------
- (void)_requestPayResultPageData {
    self.requestParam = @{@"saleOrderNo":self.orderNo};
    [self showHubWithDefaultStatus];
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_GetSelfTakeOrderPayResultPageInfo block:^(NSDictionary *resultDic, NSError *error) {
        NSDictionary *result = resultDic[EntityKey];
        if (isEmpty(result)) {
            [self dissmiss];
            return ;
        }
        [self dissmiss];
        DLPayResultPageModel *resultModel = [[DLPayResultPageModel alloc] initWithDefaultDataDic:result];
        [self _configureDataWithResultModel:resultModel];
        
    }];
}

#pragma mark -------------------PageNavigate Method----------------------
- (void)_enterOrderDetail {
    DLOrderDetailsVC *orderdetail = [[DLOrderDetailsVC alloc] init];
    orderdetail.orderNo = self.orderNo;
    [self navigatePushViewController:orderdetail animate:YES];
}

- (void)_enterHomePage {
    DLMainTabBarController *mainVC = [[DLMainTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
}
#pragma mark -------------------Private Method----------------------
- (void)_configureDataWithResultModel:(DLPayResultPageModel *)payPageResultModel{
    self.storeName.text = payPageResultModel.storeInfo.storeName;
    self.storePhone.text = payPageResultModel.storeInfo.hotline;
    self.storeTimer.text = payPageResultModel.storeInfo.storeBusinessDisplayTime;
    self.address.text = [NSString stringWithFormat:@"自提地址: %@",payPageResultModel.storeInfo.storeAdress];
    self.code.text = payPageResultModel.receiveCode;
    self.payLabel.text = payPageResultModel.payTypeName;
    self.shippingMethod.text = payPageResultModel.deliveryModeName;
    self.price.text = jFormat(@"￥%.2f",payPageResultModel.paidAmount.floatValue/1000);
    self.distributionTimer.text = payPageResultModel.deliveryTimeNote;
    self.preferentialMoney.text  = jFormat(@"￥%.2f",payPageResultModel.preferentialAmt.floatValue/1000);
}

- (IBAction)lookOrderClick:(id)sender {
    [self _enterOrderDetail];
}

- (IBAction)continueShoppingClick:(id)sender {
    [self _enterHomePage];
}

- (IBAction)dialTheServiceNumberAction:(id)sender {
    UIButton *serviceButton = (UIButton *)sender;
    [Util dialWithPhoneNumber:serviceButton.titleLabel.text];
}

- (void)goBack {
    if (self.isComeFromSettleAcount) {
        [self _enterHomePage];
    }else {
        emptyBlock(self.backPayRreshBlock);
        [super goBack];
    }
}


@end

//
//  DLPaySuccessVC.m
//  YilidiSeller
//
//  Created by yld on 16/7/2.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLPaySuccessVC.h"
#import "DLOrderDetailsVC.h"
#import "DLMainTabBarController.h"
#import "Util.h"
#import "DLPayResultPageModel.h"

@interface DLPaySuccessVC ()
@property (weak, nonatomic) IBOutlet UILabel *couponAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *dispatchOrderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteResponsityLabel;
@property (weak, nonatomic) IBOutlet UILabel *dispatchGoodsNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *dispatchTimeLabel;
@end

@implementation DLPaySuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _requestPayResultPageData];
}

#pragma mark -------------------Private Method----------------------
- (void)_assignData:(DLPayResultPageModel *)resultModel{
    self.dispatchOrderNumberLabel.text = jFormat(@"订  单  号：  %@",resultModel.saleOrderNo);
    self.dispatchTimeLabel.text = jFormat(@"订单金额：  ￥%.2f", resultModel.paidAmount.doubleValue/1000);
    self.couponAmountLabel.text = jFormat(@"优惠金额：  ￥%.2f", resultModel.preferentialAmt.doubleValue/1000);
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

#pragma mark ---------------------Api Method------------------------------
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
        [self _assignData:resultModel];
    }];
}


#pragma mark -------------------View Event Method----------------------
- (IBAction)continueShoppingAction:(id)sender {
    [self _enterHomePage];
}

- (IBAction)lookOrderDetailAction:(id)sender {
    [self _enterOrderDetail];
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

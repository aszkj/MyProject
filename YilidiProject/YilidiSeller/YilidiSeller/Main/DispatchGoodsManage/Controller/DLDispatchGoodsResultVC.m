//
//  DLDispatchGoodsResultVC.m
//  YilidiSeller
//
//  Created by yld on 16/7/2.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLDispatchGoodsResultVC.h"
#import "DLInvoiceDetailsVC.h"
#import "Util.h"
@interface DLDispatchGoodsResultVC ()
@property (weak, nonatomic) IBOutlet UILabel *dispatchOrderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteResponsityLabel;
@property (weak, nonatomic) IBOutlet UILabel *dispatchGoodsNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *dispatchTimeLabel;

@end

@implementation DLDispatchGoodsResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _assignData];
}

#pragma mark -------------------Private Method----------------------
-(void)_init {
    self.pageTitle = @"调货商品管理";
}

- (void)_assignData {
    self.dispatchOrderNumberLabel.text = jFormat(@"调拨单号： %@",self.dispatchGoodsOrderModel.allotOrderNo);
    self.minuteResponsityLabel.text = jFormat(@"调出仓库： %@",self.dispatchGoodsOrderModel.allotFromStoreName);
    self.dispatchGoodsNumberLabel.text = jFormat(@"调拨数量： %ld",self.dispatchGoodsOrderModel.allotTotalCount.integerValue);
    self.dispatchTimeLabel.text = jFormat(@"申请时间： %@",self.dispatchGoodsOrderModel.createTime);
}

#pragma mark -------------------PageNavigate Method----------------------
- (void)_enterDispatchOrderDetailPage {
    DLInvoiceDetailsVC *invoiceDetailsVC = [[DLInvoiceDetailsVC alloc] init];
    invoiceDetailsVC.orderNo = self.dispatchGoodsOrderModel.allotOrderNo;
    invoiceDetailsVC.isManagementVC =YES;
    [self navigatePushViewController:invoiceDetailsVC animate:YES];
}

#pragma mark -------------------View Event Method----------------------
- (IBAction)backToHomePage:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)lookDispatchGoodsOrderAction:(id)sender {
    [self _enterDispatchOrderDetailPage];
}

- (IBAction)dialTheServiceNumberAction:(id)sender {
    UIButton *serviceButton = (UIButton *)sender;
    [Util dialWithPhoneNumber:serviceButton.titleLabel.text];
}

- (void)goBack {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

//
//  DLRefundOrderVC.m
//  YilidiBuyer
//
//  Created by mm on 17/2/22.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLRefundOrderVC.h"
#import "MycommonTableView.h"
#import "DLOrderDetailsVC.h"
#import "DLOrderListCell.h"
#import "GlobleConst.h"

@interface DLRefundOrderVC ()
@property (weak, nonatomic) IBOutlet MycommonTableView *myRefundOrderTableView;

@end

@implementation DLRefundOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initOrderTableView];
    
    [self _init];
    
    [self showHubWithStatus:@"正在获取订单列表.."];
}

-(void)_init {
    
    self.pageTitle = @"我的退款";
}


- (void)_initOrderTableView {
    WEAK_SELF
    self.myRefundOrderTableView.cellHeight = orderListCellHeight;
    [self.myRefundOrderTableView configurecellNibName:@"DLOrderListCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        OrderListModel *orderListModel = (OrderListModel *)cellModel;
        DLOrderListCell  *orderlistCell = (DLOrderListCell *)cell;
        orderlistCell.orderListModel = orderListModel;
        
        orderlistCell.gotoLookOrderDetailBlock = ^(NSString *orderNo){
            [weak_self _enterOrderDetailPageWithOrderNo:orderNo];
        };
        
        
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
    }];
    
    [self.myRefundOrderTableView headerAutoRreshRequestBlock:^{
        [weak_self _requestAllOrderData];
    }];
    
    [self.myRefundOrderTableView headerRreshRequestBlock:^{
        [weak_self _requestAllOrderData];
    }];
    
    [self.myRefundOrderTableView footerRreshRequestBlock:^{
        [weak_self _requestAllOrderData];
    }];
}




#pragma mark -------------------PageNavigate Method----------------------
- (void)_enterOrderDetailPageWithOrderNo:(NSString *)orderNo {
    DLOrderDetailsVC *orderDetailVC = [[DLOrderDetailsVC alloc] init];
    orderDetailVC.orderNo = orderNo;
    [self navigatePushViewController:orderDetailVC animate:YES];
}

#pragma mark -------------------Api Method----------------------
- (void)_requestAllOrderData {
    NSDictionary *paramDic = @{kRequestPageNumKey:@(self.myRefundOrderTableView.dataLogicModule.requestFromPage),
                               kRequestPageSizeKey:@(kRequestDefaultPageSize),
                               @"statusCode":@(4)};
    
    [AFNHttpRequestOPManager postWithParameters:paramDic subUrl:kUrl_OrderList block:^(NSDictionary *resultDic, NSError *error) {
        [self dissmiss];
        NSArray *responseArr = resultDic[EntityKey][@"list"];
        NSArray *transferedArr = [OrderListModel objectArrWithOrderArr:responseArr];
        [self.myRefundOrderTableView configureTableAfterRequestPagingData:transferedArr];
    }];
}



@end

//
//  DLAllOrderVC.m
//  YilidiBuyer
//
//  Created by yld on 16/6/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLAllOrderVC.h"
#import "MycommonTableView.h"
#import "DLOrderListCell.h"
#import "GlobleConst.h"
#import "DLOrderDetailsVC.h"
#import "ZFActionSheet.h"
#import "PayManager+requestPayNeedInfo.h"
#import "PayRequestModel.h"
#import "DLPaySuccessVC.h"
#import "PayView.h"
#import "DLOrderPaySuccessVC.h"
#import <Masonry/Masonry.h>
#import "DLOrderCommentVC.h"

@interface DLAllOrderVC ()

@property (weak, nonatomic) IBOutlet MycommonTableView *allOrderTableView;

@property (nonatomic, strong)PayManager *addFirstAddressView;

@property (nonatomic, strong)PayView *payView;

@end

@implementation DLAllOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _initOrderTableView];
    
    [self _init];
    
    
    [self showHubWithStatus:@"正在获取订单列表.."];
}

-(void)_init {
    
    self.pageTitle = @"全部订单";
}


- (void)_initOrderTableView {
    WEAK_SELF
    self.allOrderTableView.cellHeight = orderListCellHeight;
    [self.allOrderTableView configurecellNibName:@"DLOrderListCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        OrderListModel *orderListModel = (OrderListModel *)cellModel;
        DLOrderListCell  *orderlistCell = (DLOrderListCell *)cell;
        WEAK_OBJ(orderlistCell)
        WEAK_OBJ(orderListModel)
        orderlistCell.orderListModel = orderListModel;
        
        orderlistCell.gotoPayBlock = ^(NSString *orderNo){
            [weak_self _startPayRequestWithOrderModel:orderListModel];
        };
        
        orderlistCell.confiureRecieveGoodsBlock = ^(NSString *orderNo){
            [weak_self _alertEnsureRecieveGoodsOfOrderModel:orderListModel];
        };
        
        orderlistCell.gotoLookOrderDetailBlock = ^(NSString *orderNo){
            [weak_self _enterOrderDetailPageWithOrderNo:orderNo];
        };
        
        orderlistCell.gotoCommentBlock = ^(NSString *orderNo){
            [weak_self _enterCommentPageWithOrderNo:orderNo];
        };

        orderlistCell.cancelOrderGoodsBlock = ^(NSString *orderNo){
            [weak_self _alertCancelOrderWithOrderNo:weak_orderListModel cancelCell:weak_orderlistCell];
        };

    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
    }];
    
    [self.allOrderTableView headerAutoRreshRequestBlock:^{
        [weak_self _requestAllOrderData];
    }];
    
    [self.allOrderTableView headerRreshRequestBlock:^{
        [weak_self _requestAllOrderData];
    }];
    
    [self.allOrderTableView footerRreshRequestBlock:^{
        [weak_self _requestAllOrderData];
    }];
}

#pragma mark -------------------Private Method----------------------
- (void)_alertCancelOrderWithOrderNo:(OrderListModel *)orderListModel cancelCell:(DLOrderListCell *)cancelCell{
    [self showSimplyAlertWithTitle:@"提示" message:@"是否确定取消订单" sureAction:^(UIAlertAction *action) {
        [self _requestOrderWithOrderListModel:orderListModel cancelCell:cancelCell];
    } cancelAction:^(UIAlertAction *action) {
        
    }];
}

- (void)_alertEnsureRecieveGoodsOfOrderModel:(OrderListModel *)model {
    [self showSimplyAlertWithTitle:@"提示" message:@"是否确定收货" sureAction:^(UIAlertAction *action) {
        [self _requestEnsureRecieveGoodsOfOrderModel:model];
    } cancelAction:^(UIAlertAction *action) {
        
    }];
}


- (void)_reloadAllOrderData {
    self.allOrderTableView.dataLogicModule.requestFromPage = 1;
    [self _requestAllOrderData];
}


#pragma mark -------------------PageNavigate Method----------------------
- (void)_enterOrderDetailPageWithOrderNo:(NSString *)orderNo {
    DLOrderDetailsVC *orderDetailVC = [[DLOrderDetailsVC alloc] init];
    orderDetailVC.orderNo = orderNo;
    [self navigatePushViewController:orderDetailVC animate:YES];
}

- (void)_enterCommentPageWithOrderNo:(NSString *)orderNo {
    DLOrderCommentVC *orderCommentVC = [[DLOrderCommentVC alloc] init];
    orderCommentVC.orderNo = orderNo;
    [self navigatePushViewController:orderCommentVC animate:YES];
}

- (void)_enterPayResultPageWithOrderModel:(PayRequestModel *)payRequestModel {
    DLPaySuccessVC *payResultPage = [[DLPaySuccessVC alloc] init];
    payResultPage.isComeFromSettleAcount = NO;
    WEAK_SELF
    payResultPage.backPayRreshBlock = ^{
        [weak_self _reloadAllOrderData];
    };
    payResultPage.orderAmount = payRequestModel.orderAmount;
    payResultPage.orderNo = payRequestModel.orderNo;
    [self navigatePushViewController:payResultPage animate:YES];
}

- (void)_enterSelfTakeOrderPayResultPageWithOrderNo:(NSString *)orderNo {
    DLOrderPaySuccessVC *selfTakeOrderPayResultPage = [[DLOrderPaySuccessVC alloc] init];
    selfTakeOrderPayResultPage.isComeFromSettleAcount = NO;
    WEAK_SELF
    selfTakeOrderPayResultPage.backPayRreshBlock = ^{
        [weak_self _reloadAllOrderData];
    };
    selfTakeOrderPayResultPage.orderNo = orderNo;
    [self navigatePushViewController:selfTakeOrderPayResultPage animate:YES];
}

#pragma mark -------------------Api Method----------------------
- (void)_requestAllOrderData {
     NSDictionary *paramDic = @{kRequestPageNumKey:@(self.allOrderTableView.dataLogicModule.requestFromPage),
                               kRequestPageSizeKey:@(kRequestDefaultPageSize),
                               @"statusCode":@(0)};
    
    [AFNHttpRequestOPManager postWithParameters:paramDic subUrl:kUrl_OrderList block:^(NSDictionary *resultDic, NSError *error) {
        [self dissmiss];
        NSArray *responseArr = resultDic[EntityKey][@"list"];
        NSArray *transferedArr = [OrderListModel objectArrWithOrderArr:responseArr];
        [self.allOrderTableView configureTableAfterRequestPagingData:transferedArr];
    }];
}

- (void)_requestEnsureRecieveGoodsOfOrderModel:(OrderListModel *)model {
    NSDictionary *paramDic = @{@"saleOrderNo":model.orderNo};
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:paramDic subUrl:kUrl_orderConfirm block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        if (error.code == 1) {
            [self _requestAllOrderData];
        }else {
        }
    }];
    
}


- (void)_requestOrderWithOrderListModel:(OrderListModel *)orderListModel cancelCell:(DLOrderListCell *)cancelCell{
//    [self showLoadingHub];
    [self showLoadingHubWithText:@"正在取消订单.."];
    NSDictionary *paramDic = @{@"saleOrderNo":orderListModel.orderNo};
    [AFNHttpRequestOPManager postWithParameters:paramDic subUrl:kUrl_OrderCancel block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        if (error.code == 1) {
            [self _reloadAllOrderData];
        }else {
        }
        
    }];
}
#pragma mark -------------------Pay Method----------------------
- (void)_startPayRequestWithOrderModel:(OrderListModel *)orderListModel {
    PayRequestModel *payRequestModel = [[PayRequestModel alloc] initWithOrderNo:orderListModel.orderNo orderAmount:orderListModel.totalAmount];
    payRequestModel.orderPayShipWay = orderListModel.orderShipWay;
    WEAK_SELF
    [self.payView showPayViewWithRequestModel:payRequestModel responseBlock:^(PayRequestModel *payRequestModel, PayResponseBaseModel *payResponseModel, NSError *payRequestError) {
        [weak_self _dealPayResultWithResponseModel:payResponseModel ofPayRequestModel:payRequestModel];
    }];
}

- (void)_dealPayResultWithResponseModel:(PayResponseBaseModel *)payResponseModel ofPayRequestModel:(PayRequestModel *)payRequestModel{
    if (payResponseModel.payResult == PayResult_Success) {
        if (payRequestModel.orderPayShipWay == ShipWay_DeliveryGoodsHome) {
            [self _enterPayResultPageWithOrderModel:payRequestModel];
        }else if (payRequestModel.orderPayShipWay == ShipWay_SelfTake) {
            [self _enterSelfTakeOrderPayResultPageWithOrderNo:payRequestModel.orderNo];
        }
    }else if(payResponseModel.payResult == PayResult_Canceled){
        [self _enterOrderDetailPageWithOrderNo:payRequestModel.orderNo];
    }else {
        [Util ShowAlertWithOnlyMessage:payResponseModel.statusStr];
    }
}

- (PayView *)payView {
    if (!_payView) {
        _payView = [PayView new];
        [self.view.window addSubview:_payView];
        [_payView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view.window);
        }];
    }
    return _payView;
}




@end

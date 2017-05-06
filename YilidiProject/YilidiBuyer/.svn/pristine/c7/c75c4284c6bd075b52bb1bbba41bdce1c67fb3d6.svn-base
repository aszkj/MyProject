//
//  DLOrderlistVCTopHelper.m
//  YilidiSeller
//
//  Created by yld on 16/3/28.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import "DLOrderlistVCTopHelper.h"
#import "NSObject+setModelIndexPath.h"
#import "MycommonTableView.h"
#import "DLOrderListCell.h"
#import "DLOrderListVC.h"
#import "GlobleConst.h"
#import "DLHomeGoodsModel.h"
#import "DLOrderDetailsVC.h"
#import "GoodsModel.h"
#import "ZFActionSheet.h"
#import "PayRequestModel.h"
#import "PayManager.h"
#import "PayManager+requestPayNeedInfo.h"
#import "DLPaySuccessVC.h"
#import "PayView.h"
#import <Masonry/Masonry.h>
#import "DLOrderPaySuccessVC.h"
#import "DLOrderCommentVC.h"

@interface DLOrderlistVCTopHelper()

@property (nonatomic, strong)PayView *payView;


@end

@implementation DLOrderlistVCTopHelper

#pragma mark -------------------Init Method----------------------

-(id)initWithTableCount:(NSInteger)tableCount vcRootView:(UIView *)vcRootView {
    
    self = [super initWithTableCount:tableCount vcRootView:vcRootView];
    if (self) {
        self.isAutoFreshEachTimeWhenSwitchedTopbarIndex = YES;
    }
    return self;
}

-(void)loadTableInView:(UIView *)vcRootView tableCount:(NSInteger)tableCount {
    
    for (int i=0; i<tableCount; i++) {
        MycommonTableView *tableView = [[MycommonTableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kScreenWidth,kScreenHeight-kNavBarAndStatusBarHeight-kTopBarHeight) style:UITableViewStylePlain];
        [tableView setBackgroundColor:KViewBgColor];
        [self _configureTableView:tableView];
        tableView.noDataLogicModule.nodataAlertTitle = @"暂无订单";
        tableView.noDataLogicModule.nodataAlertImage = @"noOrderImage";
        //配置每张表
        [self setTableAttributeAtIndex:i forTableView:tableView];
        [vcRootView addSubview:tableView];
        [self.contentTableArr addObject:tableView];
    }
}

- (void)_configureTableView:(MycommonTableView *)orderTableView {
    orderTableView.cellHeight = orderListCellHeight;
    WEAK_SELF
    [orderTableView configurecellNibName:@"DLOrderListCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        OrderListModel *orderListModel = (OrderListModel *)cellModel;
        DLOrderListCell  *orderlistCell = (DLOrderListCell *)cell;
        orderlistCell.orderListModel = orderListModel;
        WEAK_OBJ(orderListModel)
        orderlistCell.gotoPayBlock = ^(NSString *orderNo){
            [weak_self _startPayRequestWithOrderModel:orderListModel];
        };
        
        orderlistCell.gotoLookOrderDetailBlock = ^(NSString *orderNo){
            [weak_self _enterOrderDetailPageWithOrderNo:orderNo];
        };
        
        orderlistCell.gotoCommentBlock = ^(NSString *orderNo){
            [weak_self _enterCommentPageWithOrderNo:orderNo];
        };

        orderlistCell.confiureRecieveGoodsBlock = ^(NSString *orderNo){
            [weak_self _alertEnsureRecieveGoodsOfOrderModel:weak_orderListModel];
        };
        
        orderlistCell.cancelOrderGoodsBlock = ^(NSString *orderNo){
            [weak_self _alertCancelOrderWithOrderModel:weak_orderListModel];
        };

        
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {

    }];
}

#pragma mark -------------------Private Method----------------------
- (void)_refreshCurrentOrderTableAndData {
    self.currentFreshTableView.dataLogicModule.requestFromPage = 1;
    [self requestData];
}

- (void)_alertEnsureRecieveGoodsOfOrderModel:(OrderListModel *)model {
    [self.orderListVC showSimplyAlertWithTitle:@"提示" message:@"是否确定收货" sureAction:^(UIAlertAction *action) {
        [self _requestEnsureRecieveGoodsOfOrderModel:model];
    } cancelAction:^(UIAlertAction *action) {
        
    }];
}

- (void)_alertCancelOrderWithOrderModel:(OrderListModel *)orderListModel{
    [self.orderListVC showSimplyAlertWithTitle:@"提示" message:@"是否确定取消订单" sureAction:^(UIAlertAction *action) {
        [self _requestOrderWithOrderListModel:orderListModel];
    } cancelAction:^(UIAlertAction *action) {
        
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



#pragma mark -------------------Api Method----------------------
-(void)requestData{
    NSNumber *requestTypeNumber = (NSNumber *)[self getRequestTypeWithTalbleTag:self.currentFreshTableView.tag];
    NSDictionary *paramDic = @{kRequestPageNumKey:@(self.currentFreshTableView.dataLogicModule.requestFromPage),
                               kRequestPageSizeKey:@(kRequestDefaultPageSize),
                               @"statusCode":requestTypeNumber};
    [AFNHttpRequestOPManager postWithParameters:paramDic subUrl:kUrl_OrderList block:^(NSDictionary *resultDic, NSError *error) {
        NSArray *responseArr = resultDic[EntityKey][@"list"];
        NSArray *transferedArr = [OrderListModel objectArrWithOrderArr:responseArr];
        [self configureTableAfterRequestData:transferedArr];
        [self.currentFreshTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
    }];
}

- (void)_requestEnsureRecieveGoodsOfOrderModel:(OrderListModel *)model {
    NSDictionary *paramDic = @{@"saleOrderNo":model.orderNo};
    [self.orderListVC showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:paramDic subUrl:kUrl_orderConfirm block:^(NSDictionary *resultDic, NSError *error) {
        if (error.code == 1) {
            [self.orderListVC hideHubForText:@"确认收货成功"];
            [self _refreshCurrentOrderTableAndData];
        }else {
            [self.orderListVC hideLoadingHub];
        }
    }];
}

- (void)_requestOrderWithOrderListModel:(OrderListModel *)orderListModel{
    [self.orderListVC showLoadingHubWithText:@"正在取消订单.."];
    NSDictionary *paramDic = @{@"saleOrderNo":orderListModel.orderNo};
    [AFNHttpRequestOPManager postWithParameters:paramDic subUrl:kUrl_OrderCancel block:^(NSDictionary *resultDic, NSError *error) {
        [self.orderListVC hideLoadingHub];
        if (error.code == 1) {
            [self _refreshCurrentOrderTableAndData];
        }else {
        }
        
    }];
}


#pragma mark -------------------PageNavigate Method----------------------
- (void)_enterPayPageWithModel:(OrderListModel *)model {
    
}

- (void)_enterCommentPageWithOrderNo:(NSString *)orderNo {
    DLOrderCommentVC *orderCommentVC = [[DLOrderCommentVC alloc] init];
    orderCommentVC.orderNo = orderNo;
    [self.orderListVC navigatePushViewController:orderCommentVC animate:YES];
}

- (void)_enterSelfTakeOrderPayResultPageWithOrderNo:(NSString *)orderNo {
    DLOrderPaySuccessVC *selfTakeOrderPayResultPage = [[DLOrderPaySuccessVC alloc] init];
    selfTakeOrderPayResultPage.orderNo = orderNo;
    WEAK_SELF
    selfTakeOrderPayResultPage.backPayRreshBlock = ^{
        [weak_self _refreshCurrentOrderTableAndData];
    };
    selfTakeOrderPayResultPage.isComeFromSettleAcount = NO;
    [self.orderListVC navigatePushViewController:selfTakeOrderPayResultPage animate:YES];
}


- (void)_enterPayResultPageWithOrderModel:(PayRequestModel *)payRequestModel{
    DLPaySuccessVC *payResultPage = [[DLPaySuccessVC alloc] init];
    WEAK_SELF
    payResultPage.backPayRreshBlock = ^{
        [weak_self _refreshCurrentOrderTableAndData];
    };
    payResultPage.isComeFromSettleAcount = NO;
    payResultPage.orderAmount = payRequestModel.orderAmount;
    payResultPage.orderNo = payRequestModel.orderNo;
    [self.orderListVC navigatePushViewController:payResultPage animate:YES];
}


- (void)_enterOrderDetailPageWithOrderNo:(NSString *)orderNo {
    DLOrderDetailsVC *orderDetailVC = [[DLOrderDetailsVC alloc] init];
    orderDetailVC.orderNo = orderNo;
    [self.orderListVC navigatePushViewController:orderDetailVC animate:YES];
}

#pragma mark -------------------Private Method----------------------
-(NSNumber *)getRequestTypeWithTalbleTag:(NSInteger)tag {
    
    NSInteger requestTypeNumber;
    switch (tag) {
        case 0://全部
            requestTypeNumber = 0;
            break;
        case 1://待付款
            requestTypeNumber = 1;
            break;
        case 2://待收货
            requestTypeNumber = 2;
            break;
        case 3://待评价
            requestTypeNumber = 3;
            break;
        default:
            break;
    }

    return @(requestTypeNumber);
}

- (PayView *)payView {
    if (!_payView) {
        _payView = [PayView new];
        [self.orderListVC.view.window addSubview:_payView];
        [_payView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.orderListVC.view.window);
        }];
    }
    return _payView;
}





@end

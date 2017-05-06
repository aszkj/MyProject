//
//  DLOrderDetailVC.m
//  YilidiSeller
//
//  Created by yld on 16/6/7.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderDetailVC.h"
#import "DLOrderDetailView.h"
#import "DLOrderReturnClauseView.h"
#import "HMSegmentedControl.h"
#import "GlobleConst.h"
#import "Util.h"
#import <Masonry/Masonry.h>
#import "DLLocationViewController.h"
const NSInteger orderDetailIndex = 0;
const NSInteger orderReturnClauseIndex = 1;

@interface DLOrderDetailVC ()
@property (weak, nonatomic) IBOutlet HMSegmentedControl *topBarView;
@property (nonatomic, strong)DLOrderDetailView *orderDetailView;
@property (nonatomic, strong)DLOrderReturnClauseView *orderReturnClauseView;

@end

@implementation DLOrderDetailVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self _init];
    
    [self _initTopBarView];
    
    [self _initOrderDetailView];
    
    [self _getOrderDetailData];
}

#pragma mark ------------------------Init---------------------------------
-(void)_init {
    self.pageTitle = @"订单详情";
}

- (void)_getOrderDetailData {
    
    if (isEmpty(self.orderDetailModel)) {
        [self _requestOrderDetail];
    }else {
        self.recieveCode = self.orderDetailModel.recieveCode;
        self.orderNo = self.orderDetailModel.orderNo;
        self.orderDetailView.detailModel = self.orderDetailModel;
        self.orderDetailView.comeForTheShipCode = YES;
    }
}

-(void)_initTopBarView {
    
    NSArray *topBarTitles = nil;
    topBarTitles = @[@"订单详情",@"订单返款明细"];
    self.topBarView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.topBarView.selectionIndicatorHeight = 2.0f;
    self.topBarView.font = kSystemFontSize(15);
    self.topBarView.sectionTitles = topBarTitles;
    self.topBarView.textColor = kGetColor(136, 135, 136);
    self.topBarView.selectedTextColor = KSelectedBgColor;
    self.topBarView.selectionIndicatorColor = KSelectedBgColor;
    self.topBarView.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
}

-(void)_initOrderDetailView {
    
    self.orderDetailView = BoundNibView(@"DLOrderDetailView", DLOrderDetailView);
    WEAK_SELF
    self.orderDetailView.locationBlock = ^(CGFloat customerLatitude,CGFloat customerLongtitude,NSString*name,NSString*address){
        DLLocationViewController *locationVC = [[DLLocationViewController alloc]init];
        locationVC.customerLatitude = customerLatitude;
        locationVC.customerLongtitude = customerLongtitude;
        locationVC.name=name;
        locationVC.address=address;
        [weak_self navigatePushViewController:locationVC animate:YES];
    };
    
    self.orderDetailView.ensureTakeTheOrderBlock = ^{
        [weak_self _requestEnsureTakeTheOrder];
    };
    
    self.orderDetailView.ensureDeliverGoodsBlock = ^{
        [weak_self _requestEnsureDeliveryGoods];
    };
    
    self.orderDetailView.ensureCustomerRecieveGoodsBlock = ^{
        [weak_self _requestEnsureCustomerRecieveGoods];
    };
    
    self.orderDetailView.cancelTakeOrderBlock = ^{
        [weak_self _requestCancelTheOrder];
    };


    [self.view addSubview:self.orderDetailView];
    [self.orderDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kTopBarHeight+kSmallGap);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
    
}

#pragma mark ------------------------Private-------------------------
- (void)_dealTheTequestResult:(NSDictionary *)result error:(NSError *)error{
    [self hideLoadingHub];
    if (error.code == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
    }
}

#pragma mark ------------------------Api----------------------------------
- (void)_requestOrderDetail {
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:0];
    if (!isEmpty(self.orderNo)) {
        [requestParam setObject:self.orderNo forKey:@"saleOrderNo"];
    }
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_OrderDetail block:^(NSDictionary *resultDic, NSError *error) {
        if (isEmpty(resultDic[EntityKey])) {
            return ;
        }
        [self hideLoadingHub];
        MerchantOrderDetailModel *orderDetailModel = [[MerchantOrderDetailModel alloc] initWithDefaultDataDic:resultDic[EntityKey]];
        self.orderDetailView.detailModel = orderDetailModel;
        self.orderDetailModel = orderDetailModel;
    }];
}

- (void)_requestEnsureTakeTheOrder {
    self.requestParam = @{@"saleOrderNo":self.orderNo};
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_TakeOrder block:^(NSDictionary *resultDic, NSError *error) {
        [self _dealTheTequestResult:resultDic error:error];
    }];
}

- (void)_requestEnsureDeliveryGoods {
    self.requestParam = @{@"saleOrderNo":self.orderNo};
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_DeliveryGoods block:^(NSDictionary *resultDic, NSError *error) {
        [self _dealTheTequestResult:resultDic error:error];

    }];

}

- (void)_requestEnsureCustomerRecieveGoods {
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:0];
    if (!isEmpty(self.orderNo)) {
        [requestParam setObject:self.orderNo forKey:@"saleOrderNo"];
    }
    if (!isEmpty(self.recieveCode)) {
        [requestParam setObject:self.recieveCode forKey:@"receiveNo"];
    }
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_EnsureCustomerRecieGoods block:^(NSDictionary *resultDic, NSError *error) {
        [self _dealTheTequestResult:resultDic error:error];
    }];
}

- (void)_requestCancelTheOrder {
    self.requestParam = @{@"saleOrderNo":self.orderNo};
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_CancelOrder block:^(NSDictionary *resultDic, NSError *error) {
        [self _dealTheTequestResult:resultDic error:error];
    }];
}

#pragma mark ------------------------Page Navigate---------------------------

#pragma mark ------------------------View Event---------------------------
- (IBAction)topBarViewClickAction:(id)sender {
    HMSegmentedControl *topBarControl = (HMSegmentedControl *)sender;
    if (topBarControl.selectedSegmentIndex == orderDetailIndex) {
        self.orderDetailView.hidden = NO;
        self.orderReturnClauseView.hidden = YES;
    }else if (topBarControl.selectedSegmentIndex == orderReturnClauseIndex) {
        self.orderDetailView.hidden = YES;
        self.orderReturnClauseView.hidden = NO;
        if (!self.orderReturnClauseView.detailModel) {
            self.orderReturnClauseView.detailModel = self.orderDetailModel;
        }
    }
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------
-(DLOrderReturnClauseView *)orderReturnClauseView {
    
    if (!_orderReturnClauseView) {
        _orderReturnClauseView = BoundNibView(@"DLOrderReturnClauseView", DLOrderReturnClauseView);
        [self.view addSubview:_orderReturnClauseView];
        [_orderReturnClauseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kTopBarHeight+kSmallGap);
            make.left.bottom.right.mas_equalTo(self.view);
        }];
    }
    return _orderReturnClauseView;
}

@end

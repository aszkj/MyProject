//
//  DLOrderStatusVCViewController.m
//  YilidiBuyer
//
//  Created by yld on 16/5/30.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderDetailsVC.h"
#import "HMSegmentedControl.h"
#import "MycommonTableView.h"
#import "DLOrderStatusCell.h"
#import "DLOrderDetaiCell.h"
#import "DLOrderDetaiFooterView.h"
#import "DLOrderDetaiHeaderView.h"
#import "DLInvoiceStatusModel.h"
#import "DLOrdertailsModel.h"
#import "DLStatusFooterView.h"
#import "GlobleConst.h"
#import "DLGotoSetAccountVC.h"
#import "DLOrderStatusView.h"
#import "OrderDetailModel.h"
#import <Masonry/Masonry.h>
#import "DLOrderBottomView.h"
#import "ProjectRelativEmerator.h"
#import "PayManager.h"
#import "PayManager+requestPayNeedInfo.h"
#import "ZFActionSheet.h"
#import "DLPaySuccessVC.h"
#import "PayView.h"
#import <Masonry/Masonry.h>
#import "DLSinceOrderHeaderView.h"
#import "DLOrderPaySuccessVC.h"
#import "MLEmojiLabel.h"
#import "DLOrderCommentVC.h"
#import "DLVouchersModel.h"
#import "DLOrderCouponsCell.h"
#define TopSegmentedViewHeight 42

@interface DLOrderDetailsVC ()<UITableViewDelegate,UITableViewDataSource,MLEmojiLabelDelegate>
{
    double payResult;
}
@property (nonatomic,strong)UIButton *btnOrder;
@property (weak, nonatomic) IBOutlet HMSegmentedControl *topSegmentedView;
@property (weak, nonatomic) IBOutlet MycommonTableView *statusTableView;
@property (nonatomic,strong)DLOrderBottomView *orderBottomView;
@property (nonatomic,strong)DLOrderDetaiFooterView *detailsFooterView;
@property (nonatomic,strong)DLOrderDetaiHeaderView *detailsHeadView;
@property (nonatomic,strong)DLStatusFooterView     *statusFooterView;
@property (nonatomic,strong)DLOrderStatusView      *orderStatusView;
@property (nonatomic,strong)UITableView *orderDetaiTableView;
@property (nonatomic,copy)NSArray *statusArr;
@property (nonatomic,strong)NSMutableArray *orderArr;
@property (nonatomic,strong)NSArray *orderArray;
@property (nonatomic,strong)OrderDetailModel *orderDetaimodel;
@property (nonatomic,strong)DLSinceOrderHeaderView *sinceHeaderView;
@property (nonatomic, assign)PayType payType;
@property (nonatomic, strong)PayManager *payManager;
@property (nonatomic, strong)PayView *payView;
@property (nonatomic,assign)BOOL isDelivery;
/** 提示框 */
@property (strong, nonatomic) UIView *alertView;
@end

@implementation DLOrderDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self _statusTableView];
    [self _orderTableView];
    [self _initSegmented];
    [kNotification addObserver:self
                      selector:@selector(appEnterForeGround:)
                          name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _requestData];

}


#pragma mark ------------------------Init---------------------------------
-(void)_initSegmented {
    
    [self.view addSubview:self.alertView];
    NSArray *topBarTitles = nil;
    topBarTitles = @[@"订单状态",@"订单详情"];
    self.topSegmentedView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.topSegmentedView.selectionIndicatorHeight = 2.0f;
    self.topSegmentedView.font = kSystemFontSize(14);
    self.topSegmentedView.sectionTitles = topBarTitles;
    self.topSegmentedView.textColor = KTextColor;
    self.topSegmentedView.selectedTextColor = KCOLOR_MAIN_TEXT;
    self.topSegmentedView.selectionIndicatorColor = KCOLOR_PROJECT_RED;
    self.topSegmentedView.selectedSegmentIndex=1;
    WEAK_SELF
    self.topSegmentedView.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.topSegmentedView.indexChangeBlock = ^(NSInteger index){
        
        if (index ==0) {
            
            weak_self.orderDetaiTableView.hidden = YES;
            weak_self.statusTableView.hidden = NO;
            
        }else{
            
            weak_self.orderDetaiTableView.hidden = NO;
            weak_self.statusTableView.hidden = YES;
            
        }
        
    };
    
}

#pragma mark ------------------------Private-------------------------
- (void)_statusTableView{
    
    self.statusTableView.cellHeight = 79.0f;
    WEAK_SELF
    [self.statusTableView configurecellNibName:@"DLOrderStatusCell" cellDataSource:self.statusArr configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        DLInvoiceStatusModel *model = (DLInvoiceStatusModel *)cellModel;
        DLOrderStatusCell *statusCell = (DLOrderStatusCell *)cell;
        statusCell.model = model;
        
        
        if (model.modelAtIndexPath.row==0) {
            statusCell.orderContent.textColor =KCOLOR_PROJECT_BLUE;
            statusCell.orderStatus.textColor = KCOLOR_PROJECT_BLUE;
            statusCell.orderTime.textColor =KCOLOR_PROJECT_BLUE ;
            statusCell.lineView.hidden=YES;
            statusCell.circleButton.selected=YES;
        }else{
            statusCell.orderContent.textColor =KWeakTextColor;
            statusCell.orderStatus.textColor  = KWeakTextColor;
            statusCell.orderTime.textColor  = KWeakTextColor;
            statusCell.lineView.hidden=NO;
            statusCell.circleButton.selected=NO;
        }
        
        
        [statusCell.orderContent setEmojiText:model.statusNote];
        statusCell.orderContent.emojiDelegate = self;
        statusCell.orderContent.commonLinkColor = KCOLOR_PROJECT_BLUE;
        
        
        if (model.modelAtIndexPath.row==[weak_self.statusArr count]-1) {
            statusCell.lineViewTwo.hidden=YES;
        }else{
            statusCell.lineViewTwo.hidden=NO;
        }
        
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
    }];
    
    self.statusTableView.hidden=YES;
    
    self.statusTableView.firstSectionHeaderHeight = 0.00001f;
    self.statusTableView.firstSectionFooterHeight = 80.0f;
    [self.statusTableView configureFirstSectioFooterNibName:@"DLStatusFooterView" ConfigureTablefirstSectionFooterBlock:^(UITableView *tableView, id cellModel, UIView *firstSectionFooterView) {
       

        
        
    }];
}

- (void)_orderTableView {
    
    self.orderDetaiTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TopSegmentedViewHeight, kScreenWidth, kScreenHeight-TopSegmentedViewHeight-kNavBarAndStatusBarHeight) style:UITableViewStyleGrouped];
    self.orderDetaiTableView.delegate = self;
    self.orderDetaiTableView.dataSource = self;
    self.orderDetaiTableView.backgroundColor = KViewBgColor;
    
    self.pageTitle = @"订单详情";
    [self.orderDetaiTableView registerNib:[UINib nibWithNibName:@"DLOrderDetaiCell" bundle:nil] forCellReuseIdentifier:@"DLOrderDetaiCell"];
    
    [self.orderDetaiTableView registerNib:[UINib nibWithNibName:@"DLOrderCouponsCell" bundle:nil] forCellReuseIdentifier:@"DLOrderCouponsCell"];
    
    
    self.orderDetaiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.orderDetaiTableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.orderDetaiTableView];
    
}



- (void)_consigneeAddressBeanData:(NSDictionary *)dic {

    self.detailsHeadView.consigneeNameLabel.text = dic[@"consigneeName"];
    self.detailsHeadView.phoneNoLabel.text = dic[@"phoneNo"];
    self.detailsHeadView.addressLabel.text = dic[@"address"];
    
}

- (void)_sinceStoreInfoData:(NSDictionary *)dic {

    self.sinceHeaderView.storeName.text = dic[@"storeName"];
    self.sinceHeaderView.storeTimer.text = [NSString stringWithFormat:@"%@-%@",dic[@"businessHoursBegin"],dic[@"businessHoursEnd"]];
    self.sinceHeaderView.adress.text = [NSString stringWithFormat:@"自提地址：%@",dic[@"addressDetail"]];
    
}



- (void)_orderFeeInfoData:(NSDictionary *)dic {
    _detailsFooterView.totalNum.text = [NSString stringWithFormat:@"共%ld件商品",_orderArr.count];
    _detailsFooterView.totalAmountLabel.text = [NSString stringWithFormat:@"￥%.2f",[dic[@"totalAmount"] floatValue]/1000];
    _detailsFooterView.preferentialAmtLabel.text = [NSString stringWithFormat:@"-￥%.2f",[dic[@"preferentialAmt"] floatValue]/1000];
    _detailsFooterView.transferFeeLabel.text = [NSString stringWithFormat:@"￥%.2f", [dic[@"transferFee"] floatValue]/1000];
    _detailsFooterView.payableAmountLabel.text = [NSString stringWithFormat:@"合计:￥%.2f",[dic[@"payableAmount"] floatValue]/1000];
    
    payResult = [dic[@"payableAmount"] doubleValue]/1000;
    
}

- (void)_orderBaseInfoData:(NSDictionary *)dic {
    NSString *note;
    if (isEmpty(dic[@"note"])) {
        note=@"无";
    }else{
        note = dic[@"note"];
    }
    
    _detailsFooterView.saleOrderNoLabel.text = dic[@"saleOrderNo"];
    _detailsFooterView.createTimeLabel.text = dic[@"createTime"];
    _detailsFooterView.payTypeNameLabel.text = dic[@"payTypeName"];
    _detailsFooterView.noteLabel.text = note;
    NSString *deliveryName;
    if (isEmpty(dic[@"deliveryModeName"])) {
        deliveryName=@"配送上门";
    }else{
        deliveryName = dic[@"deliveryModeName"];
    }
    _detailsFooterView.deliveryModeNameLabel.text = deliveryName;
    _detailsFooterView.payableAmountLabel.textColor = KCOLOR_PROJECT_RED;
    WEAK_SELF
    
    switch (_orderDetaimodel.orderStatus) {
        case OrderStatus_ReadyToPay:
        {
            [self.view addSubview:self.orderBottomView];
            
        }
            break;
        case OrderStatus_ReadyToRecieveGoods:
        {
            //            if (_isDelivery==NO) {
            [self.view addSubview:self.orderStatusView];
            //            }
            
        }
            break;
        case OrderStatus_ReadyToComment:
        {
            
        }
            break;
        case OrderStatus_MerchantHasDeliveredGoodsConfiureRecieveGoods:
        {
            [self.view addSubview:self.orderStatusView];
            NSString *statusStr;
            if (_isDelivery==NO) {
                statusStr=@"确认收货";
            }else{
                statusStr=@"确认提货";
            }
            [self.orderStatusView.calcelButton setTitle:statusStr forState:UIControlStateNormal];
            self.orderStatusView.orderStatusBlock = ^{
                
                [weak_self _confirmOrderRequest];
            };
        }
            break;
        case OrderStatus_HasFinished:
        {
            if (self.orderDetaimodel.isOrderEvaluated==NO) {
               
                [self.view addSubview:self.orderStatusView];
                [self.orderStatusView.calcelButton setTitle:@"去评价" forState:UIControlStateNormal];
                
                self.orderStatusView.orderStatusBlock = ^{
                    [weak_self _gotoComment];
                };
            }else{
                self.orderStatusView.hidden = YES;
                self.orderDetaiTableView.frame = CGRectMake(0, TopSegmentedViewHeight, kScreenWidth, kScreenHeight-TopSegmentedViewHeight-kNavBarAndStatusBarHeight);
            }
           
        }
            break;

            
        case OrderStatus_HasCanceled:
        {
            
  

        }
            break;
            
        case OrderStatus_HasRefunded:
        {
            
        }
            break;
            
        case OrderStatus_Refunding:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    
    JLog(@"statusCode%@",dic[@"statusCode"]);
    JLog(@"statusCodeName%@",dic[@"statusCodeName"]);
    
}

#pragma mark ------------------------Api----------------------------------
- (void)_requestData {
    [self showLoadingHub];
    NSDictionary *paramDic = @{@"saleOrderNo":self.orderNo};
    [AFNHttpRequestOPManager postWithParameters:paramDic subUrl:kUrl_OrderDetail block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        
        NSArray *statusOrderArr = resultDic[EntityKey][@"orderStatusList"];
        _statusArr = [DLInvoiceStatusModel objectGoodsModelWithGoodsArr:statusOrderArr];
        
        self.statusTableView.dataLogicModule.currentDataModelArr = [_statusArr mutableCopy];
        [self.statusTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
        
        JLog(@"result:%@",resultDic[EntityKey]);
        
        NSArray *array = @[@{@"saleProductImageUrl":@"http://uploadtest.yldbkd.com/pic/product/201607/8/201607081658219578664.jpg",@"saleProductName":@"啦啦",@"saleProductSpec":@"500ml*24",@"brandName":@"哈哈",@"cartNum":@"1",@"orderPrice":@422000}];
       
       
        _orderArray = resultDic[EntityKey] [@"saleOrderItemList"];
        _orderArr = [DLOrdertailsModel ObjectOrdertailsModelArr:_orderArray];
        for (NSDictionary *dic in array) {
            DLOrdertailsModel *model = [[DLOrdertailsModel alloc]initWithDefaultDataDic:dic];
            model.isGift = YES;
            [_orderArr insertObject:model atIndex:_orderArr.count];
        }
        
        NSArray *resultArr = @[@{@"beginTime":@"2016-12-17 00:00:00",@"endTime":@"2017-06-17 23:59:59",@"limitedAmount":@"49000"},@{@"beginTime":@"2017-12-17 00:00:00",@"endTime":@"2017-06-17 23:50:59",@"limitedAmount":@"39000"}];
        
        
        for (NSDictionary *dic in resultArr) {
            DLVouchersModel *model = [[DLVouchersModel alloc]initWithDefaultDataDic:dic];
            [_orderArr insertObject:model atIndex:_orderArr.count];
        }
        
        _orderDetaimodel = [[OrderDetailModel alloc]init];
        [_orderDetaimodel setDefaultDataDic:resultDic[EntityKey][@"orderBaseInfo"]];
        
        //判断是否是自提 还是送货上门
        if ([resultDic[EntityKey][@"orderBaseInfo"][@"deliveryModeCode"]integerValue]==2) {
            
            [self _sinceStoreInfoData:resultDic[EntityKey][@"storeInfo"]];
            self.sinceHeaderView.goodsCode.text = resultDic[EntityKey][@"receiveNo"];
            _isDelivery=YES;
        }else{
            _isDelivery=NO;
            self.detailsHeadView.orderNumber.text = resultDic[EntityKey][@"receiveNo"];
//            self.detailsHeadView.orderNumber.textColor = KCOLOR_PROJECT_RED;
//            self.detailsHeadView.goodsCodeLabel.textColor = KCOLOR_PROJECT_RED;
            
            [self _consigneeAddressBeanData:resultDic[EntityKey][@"consigneeAddressBean"]];
        }
        
        
        [self _orderFeeInfoData:resultDic[EntityKey][@"orderFeeInfo"]];
        [self _orderBaseInfoData:resultDic[EntityKey][@"orderBaseInfo"]];
        
        [self.statusTableView reloadData];
        [self.orderDetaiTableView reloadData];
        
    }];
    
    
}

- (void)_confirmOrderRequest {
    
    WEAK_SELF
    [self showSimplyAlertWithTitle:@"提示" message:@"是否确定收货" sureAction:^(UIAlertAction *action) {
        [weak_self showLoadingHub];
        NSDictionary *paramDic = @{@"saleOrderNo":self.orderNo};
        
        
        [AFNHttpRequestOPManager postWithParameters:paramDic subUrl:kUrl_orderConfirm block:^(NSDictionary *resultDic, NSError *error) {
//            self.orderStatusView.hidden=YES;
            
            [self hideHubForText:@"收货成功"];
            
            [self _requestData];
        }];
        
    } cancelAction:^(UIAlertAction *action) {
        
    }];
}


- (void)_cancelOrder {
    WEAK_SELF
    [self showSimplyAlertWithTitle:@"提示" message:@"是否确定取消订单" sureAction:^(UIAlertAction *action) {
        [weak_self showLoadingHub];
        NSDictionary *paramDic = @{@"saleOrderNo":self.orderNo};
        
        [AFNHttpRequestOPManager postWithParameters:paramDic subUrl:kUrl_OrderCancel block:^(NSDictionary *resultDic, NSError *error) {
            [self hideHubForText:@"取消成功"];
            
            if (error.code!=1) {
                return;
            }
            JLog(@"EntityKey:%@",resultDic[EntityKey]);
            self.orderStatusView.hidden=YES;
            self.orderBottomView.hidden=YES;
            self.orderDetaiTableView.frame = CGRectMake(0, TopSegmentedViewHeight, kScreenWidth, kScreenHeight-TopSegmentedViewHeight-kNavBarAndStatusBarHeight);
            [self _requestData];
            
        }];
        
    } cancelAction:^(UIAlertAction *action) {
        
    }];
}


- (void)_requestOrderConfirm {
    
    if (_isDelivery==YES) {
        [self  _startPayRequestWithOrderNo:self.orderNo OrderAmount:@(payResult) orderShipWay:ShipWay_SelfTake];
    }else{
        [self  _startPayRequestWithOrderNo:self.orderNo OrderAmount:@(payResult) orderShipWay:ShipWay_DeliveryGoodsHome];
    }
    
}

- (void)goBack {
    if (self.popToLastPageBlock) {
        self.popToLastPageBlock();
    }
    [super goBack];
}

- (void)_comToSetAccountPageWithData:(NSDictionary *)needDataDic {
    
    DLGotoSetAccountVC *gotoSetAccountVC = [[DLGotoSetAccountVC alloc] init];
    gotoSetAccountVC.orderSetAcountDic = needDataDic;
    [self navigatePushViewController:gotoSetAccountVC animate:YES];
}
#pragma mark ------------------------Page Navigate---------------------------
- (void)_gotoComment{
 
    
    DLOrderCommentVC *commentVC = [[DLOrderCommentVC alloc] init];
    commentVC.orderNo = self.orderNo;
    [self navigatePushViewController:commentVC animate:YES];
    
}


#pragma mark ------------------------View Event---------------------------



#pragma mark ------------------------Delegate-----------------------------

- (void)mlEmojiLabel:(MLEmojiLabel*)emojiLabel didSelectLink:(NSString*)link withType:(MLEmojiLabelLinkType)type
{
    switch(type){
        case MLEmojiLabelLinkTypeURL:
            NSLog(@"点击了链接%@",link);
            break;
        case MLEmojiLabelLinkTypePhoneNumber:
            NSLog(@"点击了电话%@",link);
            [Util dialServerNumber:link];
            break;
        case MLEmojiLabelLinkTypeEmail:
            NSLog(@"点击了邮箱%@",link);
            break;
        case MLEmojiLabelLinkTypeAt:
            NSLog(@"点击了用户%@",link);
            break;
        case MLEmojiLabelLinkTypePoundSign:
            NSLog(@"点击了话题%@",link);
            break;
        default:
            NSLog(@"点击了不知道啥%@",link);
            break;
    }
    
}



#pragma -- mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_isDelivery==YES) {
        
        return 210.5;
    }
    
    return 164;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 370;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (_isDelivery==YES) {
        
        return self.sinceHeaderView;
    }
    
    return self.detailsHeadView;
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return self.detailsFooterView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _orderArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DLOrdertailsModel *model = _orderArr[indexPath.row];
    if ([model.type integerValue]==101) {
        return 90;
    }else{
        return 100;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    DLOrdertailsModel *model = _orderArr[indexPath.row];
    if ([model.type integerValue]==101) {
        DLOrderCouponsCell *cell = [self.orderDetaiTableView dequeueReusableCellWithIdentifier:@"DLOrderCouponsCell" forIndexPath:indexPath];
//        DLVouchersModel *model = _orderArr[indexPath.row];
//        [cell setModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        DLOrderDetaiCell *cell = [self.orderDetaiTableView dequeueReusableCellWithIdentifier:@"DLOrderDetaiCell" forIndexPath:indexPath];
        DLOrdertailsModel *model = _orderArr[indexPath.row];
        NSLog(@"indexPath.row::::%ld",indexPath.row);
        [cell setModel:model];
        return cell;

    }
       
        
}



#pragma mark ------------------------Notification-------------------------
- (void)appEnterForeGround:(NSNotification *)info {
    
    
}

#pragma mark ------------------------Getter / Setter----------------------

- (DLOrderDetaiHeaderView *)detailsHeadView{
    
    if (!_detailsHeadView) {
        _detailsHeadView = BoundNibView(@"DLOrderDetaiHeaderView", DLOrderDetaiHeaderView);
    }
    
    return _detailsHeadView;
}


- (DLSinceOrderHeaderView *)sinceHeaderView{
    if (!_sinceHeaderView) {
        _sinceHeaderView = BoundNibView(@"DLSinceOrderHeaderView", DLSinceOrderHeaderView);
        
    }
    
    return _sinceHeaderView;
    
    
}


- (DLOrderDetaiFooterView *)detailsFooterView {
    
    if (!_detailsFooterView) {
        _detailsFooterView = BoundNibView(@"DLOrderDetaiFooterView", DLOrderDetaiFooterView);
        
        
        
    }
    return _detailsFooterView;
}


- (DLStatusFooterView *)statusFooterView {
    
    if (!_statusFooterView) {
        _statusFooterView = BoundNibView(@"DLStatusFooterView", DLStatusFooterView);
        
        
    }
    return _statusFooterView;
}
- (DLOrderStatusView *)orderStatusView {
    
    if (!_orderStatusView) {
        _orderStatusView = BoundNibView(@"DLOrderStatusView", DLOrderStatusView);
        
        WEAK_SELF
        _orderStatusView.orderStatusBlock = ^{
            
            [weak_self _cancelOrder];
        };
        self.orderDetaiTableView.frame = CGRectMake(0, TopSegmentedViewHeight, kScreenWidth, kScreenHeight-TopSegmentedViewHeight-kNavBarAndStatusBarHeight-58);
        
        
        
    }
    return _orderStatusView;
}

- (DLOrderBottomView  *)orderBottomView {
    
    if (!_orderBottomView) {
        _orderBottomView = BoundNibView(@"DLOrderBottomView", DLOrderBottomView);
        
        WEAK_SELF
        _orderBottomView.cancelBlock = ^{
            [weak_self _cancelOrder];
            
        };
        
        _orderBottomView.playBlock = ^{
            
            [weak_self _requestOrderConfirm];
        };
        

        self.orderDetaiTableView.frame = CGRectMake(0, TopSegmentedViewHeight, kScreenWidth, kScreenHeight-TopSegmentedViewHeight-kNavBarAndStatusBarHeight-58);
        
    }
    return _orderBottomView;
}




#pragma mark -------------------Pay Method----------------------
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



- (void)_startPayRequestWithOrderNo:(NSString *)orderNumber OrderAmount:(NSNumber *)orderPrice orderShipWay:(SelectShipWay)shipway{
    PayRequestModel *payRequestModel = [[PayRequestModel alloc] initWithOrderNo:orderNumber orderAmount:orderPrice];
    payRequestModel.orderPayShipWay = shipway;
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
        self.orderBottomView.hidden=YES;
        self.orderDetaiTableView.frame = CGRectMake(0, TopSegmentedViewHeight, kScreenWidth, kScreenHeight-TopSegmentedViewHeight-kNavBarAndStatusBarHeight);
        
    }else {
        [Util ShowAlertWithOnlyMessage:payResponseModel.statusStr];
    }
}

- (void)_enterPayResultPageWithOrderModel:(PayRequestModel *)payRequestModel {
    DLPaySuccessVC *payResultPage = [[DLPaySuccessVC alloc] init];
    payResultPage.isComeFromSettleAcount = NO;
    WEAK_SELF
    payResultPage.backPayRreshBlock = ^{
        [weak_self _requestData];
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
        [weak_self _requestData];
    };
    selfTakeOrderPayResultPage.orderNo = orderNo;
    [self navigatePushViewController:selfTakeOrderPayResultPage animate:YES];
}



@end

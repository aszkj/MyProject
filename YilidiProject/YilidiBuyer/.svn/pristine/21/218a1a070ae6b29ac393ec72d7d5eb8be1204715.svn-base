//
//  DLMakesureOrderVC.m
//  YilidiBuyer
//
//  Created by yld on 16/4/22.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGotoSetAccountVC.h"
#import "MycommonTableView.h"
#import "DLGotoSetAcountGoodsCell.h"
#import "NSArray+SUIAdditions.h"
#import "ProjectRelativeMaco.h"
#import "ShopCartGoodsManager.h"
#import "ProjectRelativEmerator.h"
#import "PayManager.h"
#import "AliPayResponseModel.h"
#import "WXinPayResponseModel.h"
#import "PayManager+requestPayNeedInfo.h"
#import "DLPaySuccessVC.h"
#import "DLUpgradeSuccessVC.h"
#import "GlobleConst.h"
#import "DLOrderDetailsVC.h"
#import "ProjectRelativEmerator.h"
#import "CreateOrderResultModel.h"
#import "DLOrderPaySuccessVC.h"
#import "DLSelectCouponView.h"
#import <Masonry.h>
#import "ViewStateEmerater.h"
#import "DLCouponModel.h"
#import "NSArray+extend.h"
#import "NSString+SUIRegex.h"

const NSInteger wxinPayButtonTag = 10;
const NSInteger aliPayButtonTag = 11;
const CGFloat   vipViewHeight = 35;

#define DonotUseTicketButtonTitleColor UIColorFromRGB(0x666666)



static NSString *couponButtonUseTicketKey = @"couponButtonUseTicketKey";
static NSString *pledgeTicketButtonUseTicketKey = @"pledgeTicketButtonUseTicketKey";

@interface DLGotoSetAccountVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet MycommonTableView *gotoSetAccountTableView;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gotoSetAccountTableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *favoritePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *shipPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouldPayPriceLabel;
@property (weak, nonatomic) IBOutlet UITextField *commentTextFiled;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalGoodsCountLabel;
@property (nonatomic, assign)PayType payType;
@property (nonatomic, strong)PayManager *payManager;
@property (nonatomic, assign)SelectShipWay orderShipWay;

@property (nonatomic, strong)CreateOrderResultModel *createOrderResultModel;

@property (nonatomic, copy)NSString *producedOrderNo;
@property (nonatomic, copy)NSNumber *producedOrderAmount;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vipBottomViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *vipBottomView;
@property (weak, nonatomic) IBOutlet UIButton *hasPayedButton;
@property (nonatomic, assign)BOOL hasPayed;
@property (nonatomic, assign)BOOL isVipOrder;
@property (nonatomic, copy)NSString *recevierCode;


/**
 没有转化过的应付金额，最终根据此金额确认是否需要支付
 */
@property (nonatomic,assign) long real_shouldPayAmount;
/**
 当前应付金额
 */
@property (nonatomic,assign) CGFloat shouldPayAmount;
/**
 不使用券抵用的最开始网络请求的应付金额
 */
@property (nonatomic,assign) CGFloat originalShouldPayAmount;
/**
 原来请求下来的优惠金额
 */
@property (nonatomic,assign) CGFloat originalCouponAmount;

#pragma mark - 券部分
@property (nonatomic,strong) DLSelectCouponView *selectCouponView;

@property (nonatomic,copy) NSArray *totalCouponList;
@property (nonatomic,copy) NSArray *totalPledgeTicketsList;

@property (nonatomic,copy) NSArray *selectedCouponList;
@property (nonatomic,copy) NSArray *selectedPledgeTicketsList;

@property (nonatomic,assign) NSInteger avaliableCouponCount;
@property (nonatomic,assign) NSInteger avaliablePledgeCount;

@property (weak, nonatomic) IBOutlet UIButton *selectCouponValueButton;
@property (weak, nonatomic) IBOutlet UIButton *selectPledgeValueButton;

@property (nonatomic,assign) SelectTicketType currentSelectTicketType;
@property (nonatomic,copy) NSArray *curerentSelectTickets;
@property (nonatomic,assign) BOOL currentIsUseTicket;
@property (nonatomic,assign) BOOL willShowTicketUseTicket;
@property (nonatomic,assign) BOOL systemFirstAutoSelectTicket;
@property (nonatomic,strong) UIButton *currentSelectButton;
@property (nonatomic,strong) NSMutableDictionary *ticketButtonStatusDic;
@property (nonatomic,assign) CGFloat selectedTicketTotalAmount;

/**
 同一种券是否支持多选
 */
@property (nonatomic,assign) NSInteger isTicketSingleSelection;



@end

@implementation DLGotoSetAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _configureSettAccountGoodsType];
    
    [self _initGotoSetAccountGoodsTableView];
    
    [self _assignUIData];
    
    [self _initTicketInfo];
    
    [self _configureUIWhenStoreOnNotInBussinessTime];
    
    [kNotification addObserver:self
                      selector:@selector(appEnterForeGround:)
                          name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [kNotification removeObserver:self];
}



-(void)_init {
    self.payType = PayType_WxPay;
    self.hasPayed = NO;
    self.pageTitle = @"订单结算";
    self.isVipOrder = [self.orderSetAcountDic[EntityKey][@"isVipOrder"] boolValue];
}

-(void)_initGotoSetAccountGoodsTableView {
    
    self.gotoSetAccountTableView.cellHeight = kGotoSetAcountGoodsCellHeight;
    [self.gotoSetAccountTableView configurecellNibName:@"DLGotoSetAcountGoodsCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        DLGotoSetAcountGoodsCell *goodsCell = (DLGotoSetAcountGoodsCell *)cell;
        if ([cellModel isKindOfClass:[GoodsModel class]]) {
            GoodsModel *model = (GoodsModel *)cellModel;
            [goodsCell setCellModel:model];
        }else if ([cellModel isKindOfClass:[DLCouponModel class]]){
            DLCouponModel *model = (DLCouponModel *)cellModel;
            [goodsCell setCellGiftTicketModel:model];
        }
    }];
}


#pragma mark ---------------------Private Method------------------------------
- (void)_configureSettAccountGoodsType {
    self.vipBottomViewHeightConstraint.constant = self.isVipOrder ? vipViewHeight : 0;
    self.vipBottomView.hidden = !self.isVipOrder;
}


- (void)_configureUIWhenStoreOnNotInBussinessTime {
    
    NSString *storeIsNotInBussinessTimeAlert = nil;
    if (kCurrentStoreOnbusinessTimeNumber == 1) {
        storeIsNotInBussinessTimeAlert =
        self.selectShipWay == ShipWay_DeliveryGoodsHome ? kAlertDeliveryGoodsHomeStoreIsAfterBussinessTime : kAlertSelfTakeStoreIsAfterBussinessTime;
    }else if (kCurrentStoreOnbusinessTimeNumber == -1) {
        storeIsNotInBussinessTimeAlert =
        self.selectShipWay == ShipWay_DeliveryGoodsHome ? kAlertDeliveryGoodsHomeStoreIsFrontOfBussinessTime : kAlertSelfTakeStoreIsFrontOfBussinessTime;
    }
    if (storeIsNotInBussinessTimeAlert) {
        [self showSimplyAlertWithTitle:@"提示" message:storeIsNotInBussinessTimeAlert sureAction:^(UIAlertAction *action) {
            
        }];
    }
}


- (void)_assignUIData{
    
    if (isEmpty(self.orderSetAcountDic)) {
        return;
    }
    
    NSArray *orderGoodsList = self.orderSetAcountDic[EntityKey][@"saleOrderItemList"];
    self.totalGoodsCountLabel.text = jFormat(@"共%ld件商品",orderGoodsList.count);
    NSNumber *favoritePrice = self.orderSetAcountDic[EntityKey][@"orderFeeInfo"][@"preferentialAmt"];
    NSNumber *shipPrice = self.orderSetAcountDic[EntityKey][@"orderFeeInfo"][@"transferFee"];
    NSNumber *goodsPrice = self.orderSetAcountDic[EntityKey][@"orderFeeInfo"][@"totalAmount"];
    NSNumber *shouldPayPrice = self.orderSetAcountDic[EntityKey][@"orderFeeInfo"][@"payableAmount"];
    self.real_shouldPayAmount = shouldPayPrice.longValue;
    favoritePrice = @(favoritePrice.doubleValue/1000);
    shipPrice = @(shipPrice.doubleValue/1000);
    goodsPrice = @(goodsPrice.doubleValue/1000);
    shouldPayPrice = @(shouldPayPrice.doubleValue/1000);
    self.shouldPayAmount = shouldPayPrice.floatValue;
    self.originalCouponAmount = favoritePrice.floatValue;
    self.originalShouldPayAmount = self.shouldPayAmount;
    self.favoritePriceLabel.text = kNumberToStrRemain2PointRMBWithOutPrice(favoritePrice);
    self.goodsPriceLabel.text = kNumberToStrRemain2PointRMBWithOutPrice(goodsPrice);
    self.shouldPayPriceLabel.text = kNumberToStrRemain2PointRMBWithOutPrice(shouldPayPrice);
    self.totalAmountLabel.text = kNumberToStrRemain2PointRMBWithOutPrice(shouldPayPrice);
    self.totalAmountLabel.textColor = KCOLOR_PROJECT_RED;
    self.totalLabel.textColor = KCOLOR_PROJECT_RED;
    self.shipPriceLabel.text = kNumberToStrRemain2PointRMBWithOutPrice(shipPrice);
    self.storeNameLabel.text = self.orderSetAcountDic[EntityKey][@"storeName"];
    //商品列表
    NSArray *transFeredArr = [orderGoodsList sui_map:^GoodsModel *(NSDictionary* obj, NSUInteger index) {
        GoodsModel *model = [[GoodsModel alloc] initWithDefaultDataDic:obj];
        model.goodsNumber = obj[@"cartNum"];
        return model;
    }];
    //赠品-商品
    NSDictionary *giftInfo = self.orderSetAcountDic[EntityKey][@"giftInfo"];
    NSArray *giftGoodsArr = [giftInfo kj_safeArrForKey:@"giftProductList"];
    giftGoodsArr = [GoodsModel objectGiftGoodsModelWithGoodsArr:giftGoodsArr];
    //赠品-券
    NSArray *giftTicketsArr = [giftInfo kj_safeArrForKey:@"giftCouponList"];
    #pragma mark - here
    giftTicketsArr = [giftTicketsArr transferDicArrToModelArrWithModelClass:[DLCouponModel class]];
    NSMutableArray *setAccountList = [NSMutableArray arrayWithCapacity:5];
    [setAccountList addObjectsFromArray:transFeredArr];
    [setAccountList addObjectsFromArray:giftGoodsArr];
    [setAccountList addObjectsFromArray:giftTicketsArr];

    self.gotoSetAccountTableView.dataLogicModule.currentDataModelArr = setAccountList;
    [self.gotoSetAccountTableView reloadData];
    self.gotoSetAccountTableViewHeightConstraint.constant = setAccountList.count * kGotoSetAcountGoodsCellHeight;
}

- (void)_configurePayButton {
    self.hasPayedButton.enabled = !self.hasPayed;
    self.hasPayedButton.backgroundColor = !self.hasPayed ? KSelectedBgColor  : [UIColor darkGrayColor];
    self.hasPayedButton.alpha = !self.hasPayed ? 1 : 0.5;
}

- (void)_setShouldPayAmountUI {
    self.shouldPayAmount = self.originalShouldPayAmount - self.selectedTicketTotalAmount;
    if (self.shouldPayAmount < 0) {
        self.shouldPayAmount = 0;
    }
    self.shouldPayPriceLabel.text = jFormat(@"￥%.2f",self.shouldPayAmount);
}

- (void)_setCouponPayAmountUI {
    self.favoritePriceLabel.text = jFormat(@"￥%.2f",self.selectedTicketTotalAmount);
}



#pragma mark ----- ticket related
- (void)_initTicketInfo {
    self.ticketButtonStatusDic = [NSMutableDictionary dictionaryWithCapacity:0];
    self.isTicketSingleSelection = [self.orderSetAcountDic[EntityKey][@"isTicketSingleSelection"] integerValue];
    NSArray *tickesArr = self.orderSetAcountDic[EntityKey][@"ticketTypes"];
    if (isEmpty(tickesArr)) {
        tickesArr = @[];
    }
    for (NSDictionary *ticketDic in tickesArr) {
        NSArray *tickets = ticketDic[@"ticketInfoList"];
        if (isEmpty(tickets)) {
            tickets = @[];
        }
        NSInteger ticketType = [ticketDic[@"ticketType"] integerValue];
        if (ticketType == 1) {//优惠券
            NSArray *couponlist = [tickets transferDicArrToModelArrWithModelClass:[DLCouponModel class]];
            self.avaliableCouponCount = [self _getAvaliableTicketCountForTickets:couponlist];
            self.totalCouponList = couponlist;
        }else if (ticketType == 2){//抵用券
            NSArray *pledegelist = [tickets transferDicArrToModelArrWithModelClass:[DLCouponModel class]];
            self.avaliablePledgeCount = [self _getAvaliableTicketCountForTickets:pledegelist];
            self.totalPledgeTicketsList = pledegelist;
        }
    }
    if (self.isTicketSingleSelection) {
        [self _configureSelectTicketButtonsIfJustSupportTicketSingleSelect];
    }else {
        [self _configureSelectTicketButtonsIfSupportMutalTicketSelect];
    }
}

#pragma mark - ticket button useTicket status
- (void)_ticketType:(SelectTicketType)tickeType useTicket:(BOOL)useTicket{
    NSString *ticketKey = [self _ticketKeyForTicketType:tickeType];
    [self.ticketButtonStatusDic setObject:@(useTicket) forKey:ticketKey];
}

- (NSString *)_ticketKeyForTicketType:(SelectTicketType)tickeType {
    NSString *ticketKey = @"";
    switch (tickeType) {
        case CouponTicket:
            ticketKey = couponButtonUseTicketKey;
            break;
        case PledgeTicket:
            ticketKey = pledgeTicketButtonUseTicketKey;
            break;
        default:
            break;
    }
    return ticketKey;
}

- (BOOL)_useTicketForTicketType:(SelectTicketType)tickeType {
    NSString *ticketKey = [self _ticketKeyForTicketType:tickeType];
    return [[self.ticketButtonStatusDic objectForKey:ticketKey] boolValue];
}

#pragma mark --------------------
#pragma mark - 设置当前选中券button金额
- (void)_setTotalAmountForCurrentSelectTicketButton {
    NSString *typeStr = nil;
    if (self.currentSelectTicketType == CouponTicket) {
        typeStr = @"优惠";
    }else if (self.currentSelectTicketType == PledgeTicket) {
        typeStr = @"抵用";
    }
    NSInteger totalAmount = [self _avalialbeTotalAmountForTickets:self.curerentSelectTickets];
    [self.currentSelectButton setTitle:jFormat(@"%@金额%ld元",typeStr,totalAmount) forState:UIControlStateNormal];
}

#pragma mark - 计算选中的券金额
- (void)_calculateSelectedTicketTotalAmount {
    [self _requestCalculateTicketAmountBackBlock:^(CGFloat ticketAmount) {
        self.selectedTicketTotalAmount = ticketAmount;
        [self _setCouponPayAmountUI];
        //        [self _setShouldPayAmountUI];
    }];
}

#pragma mark - 在已知的券列表中选中指定的券列表
- (void)setSelectedUseNowTickes:(NSArray *)nowTickets forOriginalTickets:(NSArray *)originalTickets {
    for (DLCouponModel *nowModel in nowTickets) {
        for (DLCouponModel *originalModel in originalTickets) {
            if ([nowModel.ticketId isEqualToString:originalModel.ticketId]) {
                originalModel.selected = YES;
                break;
            }
        }
    }
}

- (void)_selectAllTickets:(NSArray *)tickets select:(BOOL)select{
    for (DLCouponModel *model in tickets) {
        model.selected = select;
    }
}

#pragma mark - 弹出券列表判断逻辑
- (void)_showTicketsLogicWithTicketType:(SelectTicketType)ticketType {
    
    if (ticketType == self.currentSelectTicketType) {//点的和上次券类型一样
        [self _notAlertToShowTicketViewWithTicketType:ticketType];
    }else {//不一样和上次
        if (self.currentSelectTicketType == UnknownTicket) {//多选情况下，系统不会选择一种类型
            [self _notAlertToShowTicketViewWithTicketType:ticketType];
        }else {
            //获取上次跟踪的是否使用券信息
            self.willShowTicketUseTicket = [self _useTicketForTicketType:ticketType];
            [self _dealLastSelectTicketTypeDiffrentFromCurrentSelectTicketType:ticketType];
        }
        
    }
}

- (void)_notAlertToShowTicketViewWithTicketType:(SelectTicketType)ticketType  {
    self.willShowTicketUseTicket = self.currentIsUseTicket;
    self.selectCouponView.needResetOtherTypeSelectTicket = NO;
    [self _showTicketViewWithTicketType:ticketType];
}

#pragma mark - 当前选择的和上次选择的不同处理
- (void)_dealLastSelectTicketTypeDiffrentFromCurrentSelectTicketType:(SelectTicketType)ticketType {
    if (self.curerentSelectTickets) {//上一次选择了券，提示是否取消
        [self _alertWhenLastSelectTicketTypeDiffrentFromCurrentSelectTicketType:ticketType];
    }else {//上次没选直接展示
        [self _showTicketViewWithTicketType:ticketType];
    }
}
#pragma mark - 当前选择的和上次选择的不同，弹出提示
- (void)_alertWhenLastSelectTicketTypeDiffrentFromCurrentSelectTicketType:(SelectTicketType)ticketType  {
    NSString *lastSelectedTicketTypeStr = [self _ticketTypeStrForTicketType:self.currentSelectTicketType];
    NSString *alertStr = nil;
    if (self.systemFirstAutoSelectTicket) {
        alertStr = jFormat(@"系统已选择优惠金额最大的%@，是否取消%@",lastSelectedTicketTypeStr,lastSelectedTicketTypeStr);
    }else {
        alertStr = jFormat(@"您已选择了%@，是否取消%@的选择",lastSelectedTicketTypeStr,lastSelectedTicketTypeStr);
    }
    [self showAlertWithTitle:nil message:alertStr sureTitle:@"确认取消" cancelTitle:@"暂不取消" sureAction:^(UIAlertAction *action) {
        [self _showConfigureWhenLastSelectTicketTypeDiffrentFromCurrentSelectTicketType:ticketType];
    } cancelAction:^(UIAlertAction *action) {
        
    }];
}

#pragma mark - 点击确认取消上次选的之后，刷新上次选的button的ui
- (void)_refreshCurrentSelectCouponButton{
    UIButton *refreshButton = [self _selectTicketButtonForTicketType:self.currentSelectTicketType];
    NSString *title = jFormat(@"不使用%@",[self _ticketTypeStrForTicketType:self.currentSelectTicketType]);
    [refreshButton setTitle:title forState:UIControlStateNormal];
    [refreshButton setTitleColor:DonotUseTicketButtonTitleColor forState:UIControlStateNormal];
}

#pragma mark - 点击确认取消上次选的之后的一些配置
- (void)_showConfigureWhenLastSelectTicketTypeDiffrentFromCurrentSelectTicketType:(SelectTicketType)ticketType {
    //重置上一个选择button的状态
    [self _ticketType:self.currentSelectTicketType useTicket:NO];
    self.curerentSelectTickets = nil;
    [self _clearLastSelectTicketInfo];
    //需要清除其它类型的选择
    self.selectCouponView.needResetOtherTypeSelectTicket = YES;
    [self _refreshCurrentSelectCouponButton];
    [self _showTicketViewWithTicketType:ticketType];
}

#pragma mark - 正式弹出券列表
- (void)_showTicketViewWithTicketType:(SelectTicketType)ticketType {
    self.currentSelectTicketType = ticketType;
    self.currentSelectButton = [self _selectTicketButtonForTicketType:ticketType];
    self.selectCouponView.willShowTicketUseTicket = self.willShowTicketUseTicket;
    self.selectCouponView.isTicketSingleSelection = self.isTicketSingleSelection;
    if (ticketType == CouponTicket) {
        [self _showCouponList];
    }else if (ticketType == PledgeTicket) {
        [self _showPledgeTicketsList];
    }
}

#pragma mark - 弹出优惠券券列表
- (void)_showCouponList {
    [self.selectCouponView setCoupons:self.totalCouponList];
    [self.selectCouponView showAvaliableTicketsWithTicketType:CouponTicket];
}

#pragma mark - 弹出抵用券列表
- (void)_showPledgeTicketsList {
    [self.selectCouponView setPledgeTickets:self.totalPledgeTicketsList];
    [self.selectCouponView showAvaliableTicketsWithTicketType:PledgeTicket];
}
#pragma mark -  一进来，多选情况下配置和券相关button
- (void)_configureSelectTicketButtonsIfSupportMutalTicketSelect {
    [self _configureSelectTicketButton:self.selectCouponValueButton byTicketAvaliableCount:self.avaliableCouponCount];
    [self _configureSelectTicketButton:self.selectPledgeValueButton byTicketAvaliableCount:self.avaliablePledgeCount];
    //跟踪每种button的状态
    [self _ticketType:CouponTicket useTicket:YES];
    [self _ticketType:PledgeTicket useTicket:YES];
    self.currentSelectTicketType = UnknownTicket;
    self.currentIsUseTicket = YES;
    self.systemFirstAutoSelectTicket = NO;
}

#pragma mark - 多选情况下配置券选择button
- (void)_configureSelectTicketButton:(UIButton *)ticketButton
              byTicketAvaliableCount:(NSInteger)ticketAvaliableCount {
    //抵用券button
    UIColor *ticketButtonColor = nil;
    BOOL ticketEabled = NO;
    NSString *ticketTitle = nil;
    if (ticketAvaliableCount) {//有可用的抵用券，不能选他，它就为不使用抵用券
        ticketButtonColor = KCOLOR_PROJECT_RED;
        ticketEabled = YES;
        ticketTitle = jFormat(@"%ld张可用",ticketAvaliableCount);
    }else {//无可用
        ticketButtonColor = KWeakTextColor;
        ticketEabled = NO;
        ticketTitle = @"无可用";
    }
    [self _setButton:ticketButton eabled:ticketEabled title:ticketTitle titleColor:ticketButtonColor];
}

#pragma mark -  一进来，单选情况下配置和券相关button
- (void)_configureSelectTicketButtonsIfJustSupportTicketSingleSelect {
    SelectTicketType totalAmountMaxTicketType;
    DLCouponModel *maxAmountModel = [self _getMaxTicketAmountModel];
    if (maxAmountModel) {
        if (maxAmountModel.ticketType == 1) {
            totalAmountMaxTicketType = CouponTicket;
        }else if (maxAmountModel.ticketType == 2){
            totalAmountMaxTicketType = PledgeTicket;
        }
    }else{
        totalAmountMaxTicketType = UnknownTicket;
    }
    //    SelectTicketType totalAmountMaxTicketType = [self _getMaxTotalTicketAmountTicketType];
    //    DLCouponModel *maxAmountModel = nil;
    if (totalAmountMaxTicketType == CouponTicket) {
        self.currentSelectButton = self.selectCouponValueButton;
        //        maxAmountModel = [self _getMaxTicketModelInOneTypeTicketForTickets:self.totalCouponList];
        //选中model
        [self setSelectedUseNowTickes:@[maxAmountModel] forOriginalTickets:self.totalCouponList]
        ;
        //跟踪每种button的状态
        [self _ticketType:CouponTicket useTicket:YES];
        [self _ticketType:PledgeTicket useTicket:NO];
        
        //设置非选中button的UI
        
        //抵用券button
        UIColor *pledgeTicketButtonColor = nil;
        BOOL pledgeTicketEabled = NO;
        NSString *pledgeTitle = nil;
        if (self.avaliablePledgeCount) {//有可用的抵用券，不能选他，它就为不使用抵用券
            pledgeTicketButtonColor = DonotUseTicketButtonTitleColor;
            pledgeTicketEabled = YES;
            pledgeTitle = @"不使用抵用券";
        }else {//无可用
            pledgeTicketButtonColor = KWeakTextColor;
            pledgeTicketEabled = NO;
            pledgeTitle = @"无可用";
        }
        [self _setButton:self.selectPledgeValueButton eabled:pledgeTicketEabled title:pledgeTitle titleColor:pledgeTicketButtonColor];
        
    }else if (totalAmountMaxTicketType == PledgeTicket) {
        self.currentSelectButton = self.selectPledgeValueButton;
        //        maxAmountModel = [self _getMaxTicketModelInOneTypeTicketForTickets:self.totalPledgeTicketsList];
        [self setSelectedUseNowTickes:@[maxAmountModel] forOriginalTickets:self.totalPledgeTicketsList];
        
        //跟踪每种button的状态
        [self _ticketType:CouponTicket useTicket:NO];
        [self _ticketType:PledgeTicket useTicket:YES];
        
        //设置非选中button的UI
        //抵用券button
        UIColor *couponTicketButtonColor = nil;
        BOOL couponTicketEabled = NO;
        NSString *couponTitle = nil;
        if (self.avaliableCouponCount) {//有可用的抵用券，不能选他，它就为不使用抵用券
            couponTicketButtonColor = DonotUseTicketButtonTitleColor;
            couponTicketEabled = YES;
            couponTitle = @"不使用优惠券";
        }else {//无可用
            couponTicketButtonColor = KWeakTextColor;
            couponTicketEabled = NO;
            couponTitle = @"无可用";
        }
        [self _setButton:self.selectCouponValueButton eabled:couponTicketEabled title:couponTitle titleColor:couponTicketButtonColor];
    }else {//都没有可用的
        [self _setButton:self.selectCouponValueButton eabled:NO title:@"无可用" titleColor:KWeakTextColor];
        [self _setButton:self.selectPledgeValueButton eabled:NO title:@"无可用" titleColor:KWeakTextColor];
    }
    
    //配置选中信息
    self.currentSelectTicketType = totalAmountMaxTicketType;
    self.currentIsUseTicket = YES;
    if (maxAmountModel) {
        self.curerentSelectTickets = @[maxAmountModel];
    }
    if (totalAmountMaxTicketType != UnknownTicket) {
        self.systemFirstAutoSelectTicket = YES;
    }
    //设置当前选择券button
    UIColor *selecteButtonColor = nil;
    BOOL selecteButtonEabled = NO;
    if (totalAmountMaxTicketType == UnknownTicket) {
        selecteButtonColor = KWeakTextColor;
        selecteButtonEabled = NO;
        [self.currentSelectButton setTitle:jFormat(@"无可用") forState:UIControlStateNormal];
    }else {
        //这里标题在另外地方设置了
        selecteButtonColor = KCOLOR_PROJECT_RED;
        selecteButtonEabled = YES;
        [self _setTotalAmountForCurrentSelectTicketButton];
    }
    [self.currentSelectButton setTitleColor:selecteButtonColor forState:UIControlStateNormal];
    self.currentSelectButton.enabled = selecteButtonEabled;
}




- (void)_setButton:(UIButton *)button eabled:(BOOL)eabled title:(NSString *)title titleColor:(UIColor *)titleColor{
    button.enabled = eabled;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
}

#pragma mark -  得到券金额总和最大的那种类型
- (SelectTicketType)_getMaxTotalTicketAmountTicketType{
    CGFloat couponTotalAmount = [self _avalialbeTotalAmountForTickets:self.totalCouponList];
    CGFloat pledgeTicketTotalAmount = [self _avalialbeTotalAmountForTickets:self.totalPledgeTicketsList];
    if (!couponTotalAmount && !pledgeTicketTotalAmount) {
        return UnknownTicket;
    }else if (couponTotalAmount >= pledgeTicketTotalAmount) {
        return CouponTicket;
    }else {
        return PledgeTicket;
    }
}


#pragma mark -  得到一种券中数量最大，时间最近的券，优先数量最大，其次时间最近
- (DLCouponModel *)_getMaxTicketModelInOneTypeTicketForTickets:(NSArray *)tickets {
    
    NSArray *sortedCouponModels = [tickets sortedArrayUsingComparator:^NSComparisonResult(DLCouponModel* obj1, DLCouponModel* obj2) {
        if (obj1.ticketAmount >= obj2.ticketAmount) {
            if (obj1.ticketAmount == obj2.ticketAmount) {
                if ([obj1 validTicketEndTime]<= [obj2 validTicketEndTime]) {
                    return NSOrderedAscending;
                }else {
                    return NSOrderedDescending;
                }
            }else {
                return NSOrderedAscending;
            }
        }
        return NSOrderedDescending;
    }];
    return (DLCouponModel *)sortedCouponModels.firstObject;
    
}
#pragma mark -   选择券之后更新当前选择券button
- (void)_configureCurrentSelectTicketButtonAfterSelectTickes:(NSArray *)selectTickets useTicket:(BOOL)useTicket {
    if (selectTickets.count > 0) {//选择了券
        //设置数量标题
        [self _setTotalAmountForCurrentSelectTicketButton];
        [self.currentSelectButton setTitleColor:KCOLOR_PROJECT_RED forState:UIControlStateNormal];
    }else {//没有选择券
        UIColor *selectTicketButtonColor = nil;
        NSString *selectTicketButtonTitle = nil;
        if (!useTicket) {//选择了不使用券
            selectTicketButtonTitle = [NSString stringWithFormat:@"不使用%@",  [self _ticketTypeStrForTicketType:self.currentSelectTicketType]];
            selectTicketButtonColor = DonotUseTicketButtonTitleColor;
        }else {//什么都没选
            selectTicketButtonTitle = jFormat(@"%ld张可用",[self _leftAvaliableTicketCountForTicketType:self.currentSelectTicketType]);
            selectTicketButtonColor = KCOLOR_PROJECT_RED;
        }
        [self.currentSelectButton setTitle:selectTicketButtonTitle forState:UIControlStateNormal];
        [self.currentSelectButton setTitleColor:selectTicketButtonColor forState:UIControlStateNormal];
    }
}

#pragma mark -   选择券之后配置信息
- (void)_configureAfterSelectTickes:(NSArray *)selectTickets useTicket:(BOOL)useTicket{
    if (!selectTickets.count) {
        selectTickets = nil;
    }
    self.curerentSelectTickets = selectTickets;
    self.currentIsUseTicket = useTicket;
    [self _ticketType:self.currentSelectTicketType useTicket:useTicket];
}

#pragma mark -  清除系统默认选择的券的一些信息
- (void)_clearSystemDefaultSelectedTicketInfo {
    self.systemFirstAutoSelectTicket = NO;
    //取消券list里面的默认选择
    //    [self _selectAllTickets:self.totalCouponList select:NO];
    //    [self _selectAllTickets:self.totalPledgeTicketsList select:NO];
    [self _clearLastSelectTicketInfo];
}

- (void)_clearLastSelectTicketInfo {
    if (self.currentSelectTicketType == CouponTicket) {
        [self _selectAllTickets:self.totalCouponList select:NO];
    }else if (self.currentSelectTicketType == PledgeTicket) {
        [self _selectAllTickets:self.totalPledgeTicketsList select:NO];
    }
    
}

#pragma mark -  清除系统默认选择的券的一些信息之后第一次重新选中
- (void)_reselectTicketsInCurrentTickesForTheFirstTime {
    if (self.curerentSelectTickets.count) {
        NSArray *currentSelectTotalTickets = nil;
        if (self.currentSelectTicketType == CouponTicket) {
            currentSelectTotalTickets = self.totalCouponList;
        }else if (self.currentSelectTicketType == PledgeTicket) {
            currentSelectTotalTickets = self.totalPledgeTicketsList;
        }
        [self setSelectedUseNowTickes:self.curerentSelectTickets forOriginalTickets:currentSelectTotalTickets];
    }
}

- (void)_assignAmountWithDataDic:(NSDictionary *)dataDic {
    CGFloat shouldPayPrice = [dataDic[@"payableAmount"] floatValue];
    self.real_shouldPayAmount = shouldPayPrice;
    CGFloat shipPrice = [dataDic[@"transferFee"] floatValue];
    self.shouldPayPriceLabel.text = jFormat(@"￥%.2f",shouldPayPrice/1000);
    self.totalAmountLabel.text = jFormat(@"￥%.2f",shouldPayPrice/1000);
    self.shipPriceLabel.text = jFormat(@"￥%.2f",shipPrice/1000);
}

#pragma mark ---------------------Action Method------------------------------
- (IBAction)selectPayAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.selected) {
        return;
    }
    
    button.selected = YES;
    if (button.tag == wxinPayButtonTag) {
        self.payType = PayType_WxPay;
        UIButton *alipayButton = (UIButton *)[self.view viewWithTag:aliPayButtonTag];
        alipayButton.selected = NO;
    }else if (button.tag == aliPayButtonTag){
        self.payType = PayType_Alipay;
        UIButton *wxinpayButton = (UIButton *)[self.view viewWithTag:wxinPayButtonTag];
        wxinpayButton.selected = NO;
    }
}
- (IBAction)selectCouponAction:(id)sender {
    [self _showTicketsLogicWithTicketType:CouponTicket];
}

- (IBAction)selectPledgeAction:(id)sender {
    [self _showTicketsLogicWithTicketType:PledgeTicket];
}

#pragma mark -------------------ScrollView Delegate Method----------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > 0) {
        [self.view endEditing:YES];
    }
}

#pragma mark -------------------PageNavigate Method----------------------
- (void)_enterPayResultPage {
    DLPaySuccessVC *payResultPage = [[DLPaySuccessVC alloc] init];
    payResultPage.couponAmount = @(self.selectedTicketTotalAmount);
    payResultPage.isComeFromSettleAcount = YES;
    payResultPage.orderAmount = self.producedOrderAmount;
    payResultPage.orderNo = self.producedOrderNo;
    [self navigatePushViewController:payResultPage animate:YES];
}

- (void)_enterUpdateVipGoodsPage {
    DLUpgradeSuccessVC *updateVipPage = [[DLUpgradeSuccessVC alloc] init];
    [self navigatePushViewController:updateVipPage animate:YES];
}

- (void)_enterOrderDetailPageWithOrderNo:(NSString *)orderNo {
    DLOrderDetailsVC *orderDetailVC = [[DLOrderDetailsVC alloc] init];
    WEAK_SELF
    orderDetailVC.popToLastPageBlock = ^{
        emptyBlock(weak_self.backReloadBlock);
        [weak_self goBack];
    };
    orderDetailVC.orderNo = orderNo;
    [self navigatePushViewController:orderDetailVC animate:YES];
}

- (void)_enterSelfTakeOrderPayResultPage {
    DLOrderPaySuccessVC *selfTakeOrderPayResultPage = [[DLOrderPaySuccessVC alloc] init];
    selfTakeOrderPayResultPage.orderNo = self.producedOrderNo;
    selfTakeOrderPayResultPage.isComeFromSettleAcount = YES;
    [self navigatePushViewController:selfTakeOrderPayResultPage animate:YES];
}

#pragma mark -------------------Notification Method----------------------
- (void)appEnterForeGround:(NSNotification *)info {
    if (!isEmpty(self.producedOrderNo)) {
        [self _enterOrderDetailPageWithOrderNo:self.producedOrderNo];
    }
}

#pragma mark -------------------Api Method----------------------
- (void)_requestSurePay {
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:0];
    if (!isEmpty(self.commentTextFiled.text)) {
        if (![self.commentTextFiled.text sui_validateCommonInputOne]) {
            [Util ShowAlertWithOnlyMessage:@"订单备注输入不合法，请重新输入"];
            return;
        }
        [requestParam setObject:self.commentTextFiled.text forKey:@"note"];
    }
    NSArray *selectTickets = [self _getRequestParamTicketList];
    if (!isEmpty(selectTickets)) {
        [requestParam setObject:selectTickets forKey:@"tickets"];
    }
    
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_CreateOrder block:^(NSDictionary *resultDic, NSError *error) {
        if (error.code == 1) {
            [self hideHubForText:@"生成订单成功"];
            NSString *orderNo = resultDic[EntityKey][@"saleOrderNo"];
            NSNumber *orderAmount = resultDic[EntityKey][@"paidAmount"];
            NSNumber *orderShipWayNumber = resultDic[EntityKey][@"deliveryModeCode"];
            self.recevierCode = resultDic[EntityKey][@"receiveCode"];
            self.createOrderResultModel = [[CreateOrderResultModel alloc] initWithDefaultDataDic:resultDic[EntityKey]];
            [[ShopCartGoodsManager sharedManager] clearProducedOrderGoods];
            if (isEmpty(orderNo)) {
                [Util ShowAlertWithOnlyMessage:@"生成订单错误"];
                return ;
            }
            self.producedOrderAmount = @(orderAmount.doubleValue/1000);
            self.producedOrderNo = orderNo;
            if (orderShipWayNumber.integerValue == 1) {
                self.orderShipWay = ShipWay_DeliveryGoodsHome;
            }else if (orderShipWayNumber.integerValue == 2){
                self.orderShipWay = ShipWay_SelfTake;
            }
            if (self.real_shouldPayAmount > 0) {//应付金额大于0才进行支付请求
                if (self.payType == PayType_WxPay) {
                    [self _requestWXpayInfoWithOrderNo:orderNo];
                }else if (self.payType == PayType_Alipay) {
                    [self _requestAlipayInfoWithOrderNo:orderNo];
                }
            }else {//应付金额小于等于零，直接跳转
                [self _orderPaySuccessPageSkip];
            }
        }else {
            [self hideLoadingHub];
        }
    }];
}

- (void)_requestCalculateTicketAmountBackBlock:(void(^)(CGFloat ticketAmount))backBlock {
    NSArray *selectTickets = [self _getRequestParamTicketList];
    NSMutableDictionary *ticketsParams = [NSMutableDictionary dictionaryWithCapacity:0];
    if (!isEmpty(selectTickets)) {
        [ticketsParams setObject:selectTickets forKey:@"tickets"];
    }
    [AFNHttpRequestOPManager postWithParameters:ticketsParams subUrl:kUrl_GetTicketTotalAmount block:^(NSDictionary *resultDic, NSError *error) {
        NSDictionary *entity = resultDic[EntityKey];
        if (!isEmpty(entity)) {
            if (!isEmpty(entity[@"orderFeeInfo"])) {
                NSDictionary *orderFeeInfo = entity[@"orderFeeInfo"];
                CGFloat preferentialAmt = [orderFeeInfo[@"preferentialAmt"] floatValue];
                preferentialAmt = preferentialAmt / 1000;
                [self _assignAmountWithDataDic:orderFeeInfo];
                backBlock(preferentialAmt);
            }else {
                backBlock(0.0f);
            }
        }else {
            backBlock(0.0f);
        }
    }];
}

#pragma mark -------------------Pay Method----------------------
- (void)_requestAlipayInfoWithOrderNo:(NSString *)orderNo {
    PayRequestModel *payRequestModel = [[PayRequestModel alloc] init];
    payRequestModel.orderNo = orderNo;
    WEAK_SELF
    [self.payManager requestAliPayInfoWithPayRequestModel:payRequestModel payRequesBack:^(NSDictionary *dic, NSError *error) {
        if (error.code == 1) {
            NSString *alipaySignStr = dic[EntityKey];
            if (isEmpty(alipaySignStr)) {
                [Util ShowAlertWithOnlyMessage:@"获取支付宝支付信息失败"];
                return ;
            }
            [weak_self.payManager startAlipayWithPaySignature:alipaySignStr responseBlock:^(AliPayResponseModel *payResponseModel) {
                [weak_self _dealPayResultWithResponseModel:payResponseModel];
            }];
        }else {
            [self hideLoadingHub];
        }
        
    }];
}

- (void)_requestWXpayInfoWithOrderNo:(NSString *)orderNo {
    PayRequestModel *payRequestModel = [[PayRequestModel alloc] init];
    payRequestModel.orderNo = orderNo;
    WEAK_SELF
    [self.payManager requestWxPayInfoWithPayRequestModel:payRequestModel payRequesBack:^(NSDictionary *dic, NSError *error) {
        if (error.code == 1) {
            NSDictionary *winXinPayDic = dic[EntityKey];
            if (isEmpty(winXinPayDic)) {
                [Util ShowAlertWithOnlyMessage:@"获取微信支付信息失败"];
                return ;
            }
            WXPayRequestModel *wxPayRequestModel = [[WXPayRequestModel alloc] initWithDefaultDataDic:winXinPayDic];
            [weak_self.payManager startWXinpayWithWxinPreparePayModel:wxPayRequestModel responseBlock:^(WXinPayResponseModel *payResponseModel) {
                [weak_self _dealPayResultWithResponseModel:payResponseModel];
            }];
        }else {
            [self hideLoadingHub];
        }
    }];
}

- (void)_orderPaySuccessPageSkip {
    if (self.isVipOrder) {
        [self _enterUpdateVipGoodsPage];
    }else {
        if (self.orderShipWay == ShipWay_DeliveryGoodsHome) {
            [self _enterPayResultPage];
        }else if (self.orderShipWay == ShipWay_SelfTake) {
            [self _enterSelfTakeOrderPayResultPage];
        }
    }
}

- (void)_dealPayResultWithResponseModel:(PayResponseBaseModel *)payResponseModel {
    self.createOrderResultModel.payTypeStr = payResponseModel.payTypeStr;
    if (payResponseModel.payResult == PayResult_Success) {
        [self _orderPaySuccessPageSkip];
        self.hasPayed = YES;
    }else if(payResponseModel.payResult == PayResult_Canceled){
        [self _enterOrderDetailPageWithOrderNo:self.producedOrderNo];
    }else {
        [Util ShowAlertWithOnlyMessage:payResponseModel.statusStr];
    }
}

- (void)_setSelectedTickets:(NSArray *)selectedTickets forTicketType:(SelectTicketType)selectTicketType {
    switch (selectTicketType) {
        case CouponTicket:
            self.selectedCouponList = selectedTickets;
            break;
        case PledgeTicket:
            self.selectedPledgeTicketsList = selectedTickets;
            break;
        default:
            break;
    }
}

#pragma mark -------------------Setter/Getter Method----------------------
- (PayManager *)payManager {
    if (!_payManager) {
        _payManager = [PayManager sharedInstance];
    }
    return _payManager;
}

- (void)setHasPayed:(BOOL)hasPayed {
    _hasPayed = hasPayed;
    [self _configurePayButton];
}

- (IBAction)surePayAction:(id)sender {
    [self _requestSurePay];
}

#pragma mark ----- ticket view
- (DLSelectCouponView *)selectCouponView {
    if (!_selectCouponView) {
        _selectCouponView = BoundNibView(@"DLSelectCouponView", DLSelectCouponView);
        [self.view addSubview:_selectCouponView];
        [_selectCouponView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.bottom.mas_equalTo(self.view);
        }];
        WEAK_SELF
        _selectCouponView.closeSelectCouponBlock = ^(NSArray *selectCoupons,BOOL useTicket){
            [weak_self _configureAfterSelectTickes:selectCoupons useTicket:useTicket];
            [weak_self _configureCurrentSelectTicketButtonAfterSelectTickes:selectCoupons useTicket:useTicket];
        };
        _selectCouponView.userMadeChoiceBlock = ^(BOOL userMadeChoice){
            if (userMadeChoice && weak_self.systemFirstAutoSelectTicket) {
                //用户自己做出了选择，清除系统默认的开始选择
                [weak_self _clearSystemDefaultSelectedTicketInfo];
                //但是如果此时用户选择了券，那么得重新选中当前列表中的券
                [weak_self _reselectTicketsInCurrentTickesForTheFirstTime];
            }
        };
    }
    return _selectCouponView;
}

- (void)setCurerentSelectTickets:(NSArray *)curerentSelectTickets {
    _curerentSelectTickets = curerentSelectTickets;
    [self _calculateSelectedTicketTotalAmount];
}

- (BOOL)_getSelectCouponButtonEabledWithAvaliableTicketCount:(NSInteger)avaliableTicketCount {
    return avaliableTicketCount > 0;
}

- (NSArray *)_getRequestParamTicketList {
    if (!self.curerentSelectTickets) {
        return nil;
    }
    
    NSMutableArray *tickets = [NSMutableArray arrayWithCapacity:self.curerentSelectTickets.count];
    for (DLCouponModel *model in self.curerentSelectTickets) {
        NSDictionary *ticket = @{@"ticketId":model.ticketId,
                                 @"ticketType":@(model.ticketType)};
        [tickets addObject:ticket];
    }
    return [tickets copy];
}

#pragma mark - 计算券列表里面可用的券的个数
- (NSInteger)_getAvaliableTicketCountForTickets:(NSArray *)tickets {
    if (isEmpty(tickets)) {
        return 0;
    }
    NSInteger avaliableTicketCount = 0;
    for (DLCouponModel *couponModel in tickets) {
        if (couponModel.wouldUse) {
            avaliableTicketCount ++;
        }
    }
    return avaliableTicketCount;
}

- (DLCouponModel *)_getMaxTicketAmountModel {
    DLCouponModel *maxCouponAmountModel = nil;
    DLCouponModel *maxPledgeTickeAmountModel = nil;
    
    if (self.avaliableCouponCount) {
        NSArray *avaliableCoupons = [self _getAvaliableTicketsWithTickets:self.totalCouponList];
        maxCouponAmountModel = [self _getMaxTicketModelInOneTypeTicketForTickets:avaliableCoupons];
    }
    
    if (self.avaliablePledgeCount) {
        NSArray *avaliablePledegeTickets = [self _getAvaliableTicketsWithTickets:self.totalPledgeTicketsList];
        maxPledgeTickeAmountModel = [self _getMaxTicketModelInOneTypeTicketForTickets:avaliablePledegeTickets];
    }
    
    
    
    if (!self.avaliableCouponCount && !self.avaliablePledgeCount) {
        return nil;
    }else if (self.avaliableCouponCount&& !self.avaliablePledgeCount){
        return maxCouponAmountModel;
    }else if (!self.avaliableCouponCount&& self.avaliablePledgeCount){
        return maxPledgeTickeAmountModel;
    }else {
        return [self _getMaxTicketModelInOneTypeTicketForTickets:@[maxCouponAmountModel,maxPledgeTickeAmountModel]];
    }
    return nil;
    
}

- (NSArray *)_getAvaliableTicketsWithTickets:(NSArray *)tickets {
    
    if (isEmpty(tickets)) {
        return @[];
    }
    NSMutableArray *avaliableTickets = [NSMutableArray arrayWithCapacity:tickets.count];
    for (DLCouponModel *couponModel in tickets) {
        if (couponModel.wouldUse) {
            [avaliableTickets addObject:couponModel];
        }
    }
    return [avaliableTickets copy];
    
}


#pragma mark - 根据类型得到对于的券button
- (UIButton *)_selectTicketButtonForTicketType:(SelectTicketType)ticketType {
    UIButton *ticketButton = nil;
    switch (ticketType) {
        case CouponTicket:
            ticketButton = self.selectCouponValueButton;
            break;
        case PledgeTicket:
            ticketButton = self.selectPledgeValueButton;
            break;
        default:
            break;
    }
    return ticketButton;
}

#pragma mark - 根据券列表得到可用券总金额
- (CGFloat)_avalialbeTotalAmountForTickets:(NSArray *)tickets {
    if (isEmpty(tickets)) {
        return 0.0f;
    }
    CGFloat avaliableTotalAmount = 0.0f;
    for (DLCouponModel *model in tickets) {
        if (model.wouldUse) {
            avaliableTotalAmount += model.ticketAmount;
        }
    }
    return avaliableTotalAmount;
    
}

#pragma mark - 根据券类型得到它可用的券的个数
- (NSInteger)_leftAvaliableTicketCountForTicketType:(SelectTicketType)ticketType {
    NSInteger _leftAvaliableTicketCount = 0;
    switch (ticketType) {
        case CouponTicket:
            _leftAvaliableTicketCount = self.avaliableCouponCount;
            break;
        case PledgeTicket:
            _leftAvaliableTicketCount = self.avaliablePledgeCount;
            break;
        default:
            break;
    }
    return _leftAvaliableTicketCount;
    
}

- (NSString *)_ticketTypeStrForTicketType:(SelectTicketType)ticketType {
    NSString *ticketTypeStr = nil;
    switch (ticketType) {
        case CouponTicket:
            ticketTypeStr = @"优惠券";
            break;
        case PledgeTicket:
            ticketTypeStr = @"抵用券";
            break;
        default:
            break;
    }
    return ticketTypeStr;
}


@end

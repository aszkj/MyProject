//
//  DLShopCarVC.m
//  YilidiBuyer
//
//  Created by yld on 16/4/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLShopCarVC.h"
#import "DLGotoSetAccountVC.h"
#import "MycommonTableView.h"
#import "ShopCartViewModel.h"
#import "ProjectRelativeMaco.h"
#import "DLShopCartCell.h"
#import "NSObject+setModelIndexPath.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "DLMainTabBarController.h"
#import "UIButton+Block.h"
#import "AdressModel.h"
#import "DLAdressListVC.h"
#import "DLOrderListVC.h"
#import "GoodsModel.h"
#import "UIViewController+unLoginHandle.h"
#import "DLBaseNavController.h"
#import "ProjectRelativeDefineNotification.h"
#import "ShopCartGoodsManager.h"
#import "UINavigationController+SUIAdditions.h"
#import "BaiduLocationManage.h"
#import "ProjectRelativEmerator.h"
#import "ShopCartSectionHeaderView.h"
#import "ProjectRelativeKey.h"
#import "ShopCartGoodsManager+shopCartInfo.h"
#import <Masonry/Masonry.h>

const NSInteger shipHomeBgButtonTag = 1;
const NSInteger selfTakeBgButtonTag = 2;
const NSInteger headerViewTag       = 100;


@interface DLShopCarVC ()
@property (weak, nonatomic) IBOutlet UIView *adressBgView;
@property (weak, nonatomic) IBOutlet UIView *selectShipWayBaseView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *deliveryGoodsHomeButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *selfTakeButtons;
@property (weak, nonatomic) IBOutlet UIButton *deliveryGoodsHomeBgButton;
@property (weak, nonatomic) IBOutlet UIButton *selectShipWayUINotranscosAmountButton;
@property (weak, nonatomic) IBOutlet MycommonTableView *shopCartTableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *deduceTransCostAmountLabel;
@property (weak, nonatomic) IBOutlet UIButton *allSelectedButton;
@property (weak, nonatomic) IBOutlet UIView *hidePriceView;
@property (weak, nonatomic) IBOutlet UIButton *gotoPayOrderButton;
@property (nonatomic,strong)AdressModel *adressModel;
@property (nonatomic, strong)UIView *noDefaultAdressShowView;
@property (nonatomic, strong)UIView *emptyShopCartView;
@property (nonatomic, strong)ShopCartViewModel *shopCartViewModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *totalLabelToTopConstraint;
@property (nonatomic, assign)NSInteger lastHomeIndex;
@property (nonatomic,copy)ComfromPerHomePageBlock comfromPerHomePageBlock;
@property (nonatomic,assign)SelectShipWay selectShipWay;
@property (nonatomic,strong)AdressModel *selectedAdressModel;
@property (nonatomic, assign)BOOL selectAdressed;
@property (nonatomic, assign)BOOL hasRequestTheDefaultAdress;

@end

@implementation DLShopCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self bindViewModel];
    
    WEAK_SELF
    [self.shopCartTableView headerAutoRreshRequestBlock:^{
        [weak_self _requestShopCartList];
    }];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
//    if (!self.selectAdressed) {
        if (isEmpty(self.selectedAdressModel) || isEmpty(self.selectedAdressModel.consigneAdressId)) {
            return;
        }
        if (!self.hasRequestTheDefaultAdress) {
            return;
        }
        [self _requestDefaultAdressDetail];
//    }
}


#pragma mark ------------------------Init---------------------------------
-(void)_init {
    self.pageTitle = @"购物车";
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.selectShipWay = kCurrentShipWay;
    self.deliveryGoodsHomeBgButton.enabled = self.selectShipWay == ShipWay_DeliveryGoodsHome;
    [self _configureSelectShipWayUI];
    [self _initShopCartTableView];
}


-(void)_confirgureRightItem {
    
    UIBarButtonItem *flexBarbuttonItem = [UIBarButtonItem barButtonItemSpace:-12];
    NSArray *rightItems =nil;
    if (self.shopCartViewModel.shopCartIsEmpty) {
        rightItems = @[flexBarbuttonItem];
    }else {
        NSString *rightTitle = self.shopCartViewModel.isEditing ? @"完成" : @"编辑";
        UIBarButtonItem *rightBarbuttonItem = [UIBarButtonItem initWithTitle:rightTitle titleColor:[UIColor whiteColor] target:self action:@selector(rightItemOperatorShopCartAction)];
        rightItems = @[flexBarbuttonItem,rightBarbuttonItem];
    }
    self.navigationItem.rightBarButtonItems = rightItems;
}

- (void)_initShopCartTableView {
    self.shopCartTableView.backgroundColor = [UIColor clearColor];
    WEAK_SELF
    [self.shopCartTableView configurecellNibName:@"DLShopCartCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        DLShopCartCell *shopCartCell = (DLShopCartCell *)cell;
        GoodsModel *shopCartModel = (GoodsModel *)cellModel;
        [shopCartCell setShopCartCellModel:shopCartModel];
        WEAK_OBJ(shopCartModel)
        shopCartCell.deleteShopCartGoodsBlock = ^{
            [weak_self _deleteGoods:@[weak_shopCartModel]];
        };
        
        shopCartCell.deleteShopCartGoodsFromSubBlock = ^{
            [weak_self _requestDeleteGoods:@[weak_shopCartModel]];
        };

        shopCartCell.selectShopCartGoodsBlock = ^(UIButton *selectedButton){
            weak_shopCartModel.selected = selectedButton.selected;
            [weak_self _setGoods:@[weak_shopCartModel] selected:selectedButton.selected isAllGoods:NO];
        };
        
        shopCartCell.changeShopCartGoodsCountBlock = ^(NSInteger nowCount,BOOL isAdd){
            if (nowCount) {
                weak_shopCartModel.goodsNumber = @(nowCount);
                [weak_self _requesGoodsCountChange:weak_shopCartModel];
            }else{
                [weak_self _requestDeleteGoods:@[weak_shopCartModel]];
//                [weak_self _deleteGoods:@[weak_shopCartModel]];

            }
            //通知购物车视图更新购物车总数量
            [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(isAdd)];
        };
    }];
    self.shopCartTableView.firstSectionHeaderHeight = KShopCartSectionHeaderViewHeight;
    [self.shopCartTableView configureFirstSectioHeaderNibName:@"ShopCartSectionHeaderView" ConfigureTablefirstSectionHeaderBlock:^(UITableView *tableView,id cellModel, UIView *firstSectionHeaderView) {
        ShopCartSectionHeaderView *shopCartSectionHeaderView = (ShopCartSectionHeaderView *)firstSectionHeaderView;
        shopCartSectionHeaderView.enterAdressPageBlock = ^{
            [weak_self _comToAdressListPage];
        };
        [weak_self _configureHeaderViewButNotAdressPart:firstSectionHeaderView];
    }];
    self.shopCartTableView.cellHeight = kShopCartCellHeight;
    self.shopCartTableView.editingStyle = UITableViewCellEditingStyleDelete;
    self.shopCartTableView.editingCellBlock = ^(UITableView *tableView, UITableViewCellEditingStyle editingStyle,NSIndexPath *editingIndexPath, id cellModel){
        GoodsModel *shopCartModel = (GoodsModel *)cellModel;
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [weak_self _deleteGoods:@[shopCartModel]];
        }
    };
    //不分页
    self.shopCartTableView.dataLogicModule.isRequestByPage = NO;
    
}

- (void)bindViewModel {
    
    self.shopCartViewModel = [[ShopCartViewModel alloc] init];
    @weakify(self);
    [RACObserve(self.shopCartViewModel, totalPrice) subscribeNext:^(NSNumber* totalPrice) {
        @strongify(self);
        self.totalPriceLabel.text = kPriceFloatValueToRMB(totalPrice.floatValue);
    }];
    RAC(self.allSelectedButton,selected) = RACObserve(self.shopCartViewModel, allSelected);
    [RACObserve(self.shopCartViewModel, shopCartIsEmpty) subscribeNext:^(NSNumber *isEmpty) {
        @strongify(self);
        [self _shopCartPageUiConfigureIsEmpty:isEmpty.integerValue];
    }];
    [RACObserve(self.shopCartViewModel, isEditing) subscribeNext:^(NSNumber *isEditing) {
        @strongify(self);
        [self _shopCartPageUiConfigureIsEditing:isEditing.integerValue];
    }];
    [RACObserve(self.shopCartViewModel, shopCartTotalNumber) subscribeNext:^(NSNumber *totoalNumber) {
        @strongify(self);
        [self _setMainTabbarShopCartBadgeNumber:totoalNumber.integerValue];
    }];
    [RACObserve(self.shopCartViewModel, selectedShopCartGoodsNumber) subscribeNext:^(NSNumber *selectedShopCartGoodsNumber) {
        @strongify(self);
        NSString *title = [NSString stringWithFormat:@"结算(%ld)",        selectedShopCartGoodsNumber.integerValue];
        [self.gotoPayOrderButton setTitle:title forState:UIControlStateNormal];
    }];

}

#pragma mark -------------------Public Method----------------------
-(void)comFromPerHomePageOfIndex:(NSInteger)lastHomePageIndex
                       backBlock:(ComfromPerHomePageBlock)comfromPerHomePageBlock
{
    self.lastHomeIndex = lastHomePageIndex;
    self.comfromPerHomePageBlock = comfromPerHomePageBlock;
}


#pragma mark ------------------------Private-------------------------
- (void)_assignOtherData {
    self.selectedAdressModel = self.shopCartViewModel.defaultAdressModel;
    self.hasRequestTheDefaultAdress = YES;
}

- (void)_refreshTableWhenDeleteGoods{
    
    if (self.shopCartViewModel.willFreshIndexPaths.count > 0) {
        [self.shopCartTableView deleteRowsAtIndexPaths:self.shopCartViewModel.willFreshIndexPaths withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (void)_setGoods:(NSArray *)selectedGoods selected:(BOOL)selected isAllGoods:(BOOL)isAllGoods{
    if (isAllGoods) {
        [self.shopCartViewModel trigerAllSelectedDeselectedSignalWithParamSelected:selected];
    }else {
        [self.shopCartViewModel trigerSelectDeselctGoodsSignalWithParamGoods:selectedGoods selected:selected];
    }
    [self _refreshTalbeWhenSelecteGoods];
}

- (void)_selecteAllGoodsWhenEnterShopCartPage {
    self.allSelectedButton.selected = YES;
    [self _setGoods:self.shopCartViewModel.shopCartList selected:self.allSelectedButton.selected isAllGoods:YES];
}

-(void)_setMainTabbarShopCartBadgeNumber:(NSInteger)shopCartBadgeNumber {
    
    UIViewController *rootVC = rootController;
    if ([rootVC isMemberOfClass:[DLMainTabBarController class]]) {
        DLMainTabBarController *mainVC = (DLMainTabBarController *)rootController;
        mainVC.shopCartBadgeNumber = shopCartBadgeNumber;
    }
}
- (void)_shopCartPageUiConfigureIsEditing:(BOOL)isEditing {
    self.gotoPayOrderButton.selected = isEditing;
    self.hidePriceView.hidden = !isEditing;
//    [self _confirgureRightItem];
}

- (void)_shopCartPageUiConfigureIsEmpty:(BOOL)isEmpty {
    self.shopCartTableView.hidden = isEmpty;
    self.bottomView.hidden = isEmpty;
    self.selectShipWayBaseView.hidden = isEmpty;
    self.adressBgView.hidden = isEmpty;
    self.emptyShopCartView.hidden = !isEmpty;
//    [self _confirgureRightItem];
}

- (void)_configureUIWhenShipWayChanged {
    [self _configureSelectShipWayUI];
    [self _configureHeaderViewButNotAdressPart:[self shopCartHeaderView]];
    [self _configureAdressUiWithHeaderView:[self shopCartHeaderView]];
    [self _configureDeduceTransCostUI];
}

- (UIView *)shopCartHeaderView {
    return [self.shopCartTableView viewWithTag:headerViewTag];
}

- (void)_configureDeduceTransCostUI {
    NSString *deduceTransCostStr =  jFormat(@"本店满%.1f免运费",self.shopCartViewModel.shopCartStoreModel.deduceTransCostAmount.floatValue/1000);
    NSString *deduceTransCostDisplayStr = self.selectShipWay == ShipWay_SelfTake ? @"门店自提免运费": deduceTransCostStr;
    self.deduceTransCostAmountLabel.text = deduceTransCostDisplayStr;
    NSInteger deduceTransCostAmount = self.shopCartViewModel.shopCartStoreModel.deduceTransCostAmount.integerValue;
    self.deduceTransCostAmountLabel.hidden = !deduceTransCostAmount;
    self.totalLabelToTopConstraint.constant = deduceTransCostAmount ? 8 : 15;
    NSString *deduceTransCostAmountDisplayStr = !deduceTransCostAmount ? @"暂不免运费" : jFormat(@"(满%.1f免运费)",self.shopCartViewModel.shopCartStoreModel.deduceTransCostAmount.floatValue/1000);
    [self.selectShipWayUINotranscosAmountButton setTitle:deduceTransCostAmountDisplayStr forState:UIControlStateNormal];
}

- (void)_configureSelectShipWayUI {
    
    BOOL isSelfTake = self.selectShipWay == ShipWay_SelfTake;
    [self.deliveryGoodsHomeButtons enumerateObjectsUsingBlock:^(UIButton *deliveryHomeButton, NSUInteger idx, BOOL * _Nonnull stop) {
        deliveryHomeButton.selected = !isSelfTake;
    }];
    [self.selfTakeButtons enumerateObjectsUsingBlock:^(UIButton *selfTakeButton, NSUInteger idx, BOOL * _Nonnull stop) {
        selfTakeButton.selected = isSelfTake;
    }];
}

- (void)_configureHeaderViewButNotAdressPart:(UIView *)headerView {
    ShopCartSectionHeaderView *shopCartSectionHeaderView = (ShopCartSectionHeaderView *)headerView;
    shopCartSectionHeaderView.storeNameLabel.text = self.shopCartViewModel.shopCartStoreModel.storeName;
    NSString *recipeTimeStr = self.selectShipWay == ShipWay_DeliveryGoodsHome ? self.shopCartViewModel.shopCartStoreModel.deliveryTimeNote:self.shopCartViewModel.shopCartStoreModel.pickUpTimeNote;
    shopCartSectionHeaderView.reciepeTimeLabel.text = recipeTimeStr;
    NSString *deliveryTimeStr = nil;
    deliveryTimeStr = self.selectShipWay == ShipWay_DeliveryGoodsHome ? @"收货时间":@"自提时间";
    shopCartSectionHeaderView.deliveryTimeWayLabel.text = deliveryTimeStr;
    [self _configureAdressUiWithHeaderView:headerView];
}

- (void)_configureAdressUiWithHeaderView:(UIView *)headerView{
    ShopCartSectionHeaderView *shopCartSectionHeaderView = (ShopCartSectionHeaderView *)headerView;
    shopCartSectionHeaderView.selectShipWay = self.selectShipWay;
    if (self.selectShipWay == ShipWay_DeliveryGoodsHome) {
        shopCartSectionHeaderView.adressModel = self.selectedAdressModel;
    }else if (self.selectShipWay == ShipWay_SelfTake) {
        shopCartSectionHeaderView.storeModel = self.shopCartViewModel.shopCartStoreModel;
    }
}

- (void)_refreshTalbeWhenSelecteGoods {
    if (self.shopCartViewModel.willFreshIndexPaths.count > 0) {
        [self.shopCartTableView reloadRowsAtIndexPaths:self.shopCartViewModel.willFreshIndexPaths withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)_deleteGoods:(NSArray *)goods {
    WEAK_SELF
    [self showSimplyAlertWithTitle:@"提示" message:@"确认删除该商品?" sureAction:^(UIAlertAction *action) {
        [weak_self _requestDeleteGoods:goods];
    } cancelAction:^(UIAlertAction *action) {
        
    }];
}

- (BOOL)_checkErrorWhenSubbmitOrder {
    
    if (![ShopCartGoodsManager sharedManager].selectedGoodsIdToNumberArr.count) {
        [self hideHubWithOnlyText:@"你还未选择商品，请先选择商品"];
        return YES;
    }
    
    if (self.selectShipWay == ShipWay_SelfTake) {
        return NO;
    }
    
    if (isEmpty(self.selectedAdressModel.consigneAdressId)) {
        [self hideHubWithOnlyText:@"你还未选择收货地址"];
        return YES;
    }
    
    return NO;
}

#pragma mark ------------------------Api-------------------------------------
- (void)_requestShopCartTotalNumber {
    
    [[self.shopCartViewModel trigerShopCartTotalNumberSignal] subscribeNext:^(NSNumber *totalNumber) {
        
    }];
}

- (void)_requestShopCartList {
    NSArray *shopCartGoods = [ShopCartGoodsManager sharedManager].allGoodsIdToNumberArr;
    if (!shopCartGoods.count) {
        self.shopCartViewModel.shopCartIsEmpty = YES;
        return;
    }
    [self showHubWithStatus:@"正在获取购物车数据.."];
    @weakify(self);
    [[self.shopCartViewModel trigerShopCartlistRequestSignal] subscribeNext:^(NSArray* shopCartList) {
        @strongify(self);
        [self _assignOtherData];
        [self.shopCartTableView configureTableAfterRequestData:shopCartList];
        self.shopCartViewModel.shopCartList = self.shopCartTableView.dataLogicModule.currentDataModelArr;
        [self.shopCartViewModel.shopCartList setIndexPathInselfContainer];
        [self _selecteAllGoodsWhenEnterShopCartPage];
        [self _configureHeaderViewButNotAdressPart:[self shopCartHeaderView]];
        [self _configureDeduceTransCostUI];
        [self dissmiss];
    }];
}

- (void)_requestDeleteGoods:(NSArray *)deleteGoods {
    @weakify(self);
    [[self.shopCartViewModel trigerDeleteGoodsSignalWithParamGoods:deleteGoods] subscribeNext:^(NSDictionary *resultDic) {
        @strongify(self);
        //通知购物车视图更新购物车总数量
        [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(NO)];
        [self _refreshTableWhenDeleteGoods];
    }];
}

- (void)_requestOrderConfirm {
    
    CGFloat currentLatitude = [[BaiduLocationManage shareManage] latitude];
    CGFloat currentLongtitude = [[BaiduLocationManage shareManage] longtitude];
    NSArray *selectedGoodsIdToNumberArr = [ShopCartGoodsManager sharedManager].selectedGoodsIdToNumberArr;
    NSInteger deliveryNumber = self.selectShipWay == ShipWay_SelfTake ? kDeliveryNumberSelfTake : kDeliveryNumberShipHome;
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:selectedGoodsIdToNumberArr forKey:@"cartInfo"];
    [param setObject:@(deliveryNumber) forKey:@"deliveryModeCode"];
    [param setObject:kCommunityStoreId forKey:KStoreIdKey];
    [param setObject:@(currentLongtitude) forKey:@"longitude"];
    [param setObject:@(currentLatitude) forKey:@"latitude"];
    if (self.selectShipWay == ShipWay_DeliveryGoodsHome) {
        [param setObject:self.selectedAdressModel.consigneAdressId forKey:@"addressId"];
    }

    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:param subUrl:kUrl_SubmmitOrder block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        if (error.code == 1) {
            [self performSelector:@selector(_comToSetAccountPageWithData:) withObject:resultDic afterDelay:0.2];
          
        }
    }];
}

- (void)_requesGoodsCountChange:(GoodsModel *)goodsModel {
    [[self.shopCartViewModel trigerShopCartGoodsNumberChangeSignalWithParamGoodsModel:goodsModel] subscribeNext:^(NSDictionary* resultDic) {
        
    }];
}

- (void)_requestDefaultAdressDetail {
    
    self.requestParam = @{@"addressId":self.selectedAdressModel.consigneAdressId};
    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_GetAdressDetail parameters:self.requestParam block:^(id result, NSError *error) {
        NSDictionary *dic = result[EntityKey];
        AdressModel *model = [[AdressModel alloc] initWithDefaultDataDic:dic];
        model.consigneePersonalDetailAdress = dic[@"addressDetail"];
        self.selectedAdressModel = model;
        [self _configureAdressUiWithHeaderView:[self shopCartHeaderView]];
    }];
}

#pragma mark ------------------------Page Navigate---------------------------
- (void)_comToSetAccountPageWithData:(NSDictionary *)needDataDic {
    DLGotoSetAccountVC *gotoSetAccountVC = [[DLGotoSetAccountVC alloc] init];
    gotoSetAccountVC.setAccountGoodsType = [[ShopCartGoodsManager sharedManager] shopCartGoodsType];
    gotoSetAccountVC.orderSetAcountDic = needDataDic;
    gotoSetAccountVC.selectShipWay = self.selectShipWay;
    WEAK_SELF
    gotoSetAccountVC.backReloadBlock = ^{
        [weak_self _requestShopCartList];
    };
    [self navigatePushViewController:gotoSetAccountVC animate:YES];
}

- (void)_comToAdressListPage {
    DLAdressListVC *adressListVC = [[DLAdressListVC alloc] init];
    adressListVC.comeToAdresModuleType = ComeToAdresModule_FromShopCart;
    WEAK_SELF
    adressListVC.selectAdressBlock = ^(AdressModel *selectAdressModel){
        weak_self.selectedAdressModel = selectAdressModel;
    };
    [self navigatePushViewController:adressListVC animate:YES];
}

- (void)_comtoHomePage {
    [self.navigationController popViewControllerAnimated:YES];
    if (self.cominFromPerhomePage) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        afterSecondsLoadData(0.5,UIViewController *rootVC = rootController;
                             if ([rootVC isMemberOfClass:[DLMainTabBarController class]]) {
                                 DLMainTabBarController *mainVC = (DLMainTabBarController *)rootController;
                                 [mainVC setTabIndex:MainPageIndex];
                             }
                             )
    }
}

#pragma mark ------------------------View Event---------------------------
- (IBAction)gotoPayAction:(id)sender {
    
    if ([self _checkErrorWhenSubbmitOrder]) {
        return;
    }
    
    [self _requestOrderConfirm];
}

- (IBAction)shipWaySelectAction:(id)sender {
    UIButton *selectShipButton = (UIButton *)sender;
    if (selectShipButton.tag == shipHomeBgButtonTag) {
        if (self.selectShipWay == ShipWay_DeliveryGoodsHome) {
            return;
        }
        self.selectShipWay = ShipWay_DeliveryGoodsHome;
    }else if(selectShipButton.tag == selfTakeBgButtonTag){
        if (self.selectShipWay == ShipWay_SelfTake) {
            return;
        }
        self.selectShipWay = ShipWay_SelfTake;
    }
    [self _configureUIWhenShipWayChanged];
}

- (IBAction)addAdressAction:(id)sender {
    [self _comToAdressListPage];
}

- (void)rightItemOperatorShopCartAction {
    
    self.shopCartViewModel.isEditing = !self.shopCartViewModel.isEditing;
}

- (void)goBack {
    if (self.comfromPerHomePageBlock) {
        [self.navigationController popViewControllerAnimated:YES];
        [self performSelector:@selector(_backBlock) withObject:nil afterDelay:0.2];
        return;
    }
    
    [super goBack];
}

- (void)_backBlock {
    emptyBlock(self.comfromPerHomePageBlock,self.lastHomeIndex);
}

- (IBAction)selectAllAction:(id)sender {
    UIButton *allSelectedButton = (UIButton *)sender;
    allSelectedButton.selected = !allSelectedButton.selected;
    [self _setGoods:self.shopCartViewModel.shopCartList selected:allSelectedButton.selected isAllGoods:YES];
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------
#pragma mark ------------------------Getter / Setter----------------------
- (UIView *)emptyShopCartView {
    if (!_emptyShopCartView) {
        _emptyShopCartView = BoundNibView(@"ShopCartIsEmptyView", UIView);
        [self.view addSubview:_emptyShopCartView];
        WEAK_SELF
        [_emptyShopCartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weak_self.view);
        }];
        UIButton *continueShopButton = (UIButton *)[_emptyShopCartView viewWithTag:1];
        [continueShopButton addActionHandler:^(NSInteger tag) {
            [weak_self _comtoHomePage];
        }];
    }
    return _emptyShopCartView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

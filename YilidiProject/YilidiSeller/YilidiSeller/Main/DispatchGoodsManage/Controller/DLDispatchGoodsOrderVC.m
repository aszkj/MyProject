//
//  DLShopCarVC.m
//  YilidiBuyer
//
//  Created by yld on 16/4/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLDispatchGoodsOrderVC.h"
#import "MycommonTableView.h"
#import "ProjectRelativeMaco.h"
#import "DLShopCartCell.h"
#import "NSObject+setModelIndexPath.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "DisplayAdressView.h"
#import "UIButton+Block.h"
#import "AdressModel.h"
#import "DisplayAdressView.h"
#import "DLOrderListVC.h"
#import "GoodsModel.h"
#import "ProjectRelativeDefineNotification.h"
#import "DispatchGoodsManager.h"
#import "UINavigationController+SUIAdditions.h"
#import "DispatchGoodsOrderVCViewModel.h"
#import <Masonry/Masonry.h>
#import "DLDispatchGoodsCell.h"
#import "DLDispatchGoodsResultVC.h"
#import "DLInvoiceListModel.h"
@interface DLDispatchGoodsOrderVC ()

@property (weak, nonatomic) IBOutlet UIView *adressBgView;
@property (weak, nonatomic) IBOutlet MycommonTableView *shopCartTableView;
@property (nonatomic, strong)DisplayAdressView *displayAdressView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *deduceTransCostAmountLabel;
@property (weak, nonatomic) IBOutlet UIButton *allSelectedButton;
@property (weak, nonatomic) IBOutlet UIView *hidePriceView;
@property (weak, nonatomic) IBOutlet UIButton *gotoPayOrderButton;
@property (nonatomic,strong)AdressModel *adressModel;
@property (nonatomic, strong)UIView *noDefaultAdressShowView;
@property (nonatomic, strong)UIView *emptyShopCartView;
@property (nonatomic, strong)DispatchGoodsOrderVCViewModel *dispatchGoodsOrderVCViewModel;
@property (nonatomic, assign)NSInteger lastHomeIndex;
@property (nonatomic,copy)ComfromPerHomePageBlock comfromPerHomePageBlock;

@end

@implementation DLDispatchGoodsOrderVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self _init];
    
    [self bindViewModel];
    
    [self _registerNotification];
    
    WEAK_SELF
    [self.shopCartTableView headerAutoRreshRequestBlock:^{
        [weak_self _requestShopCartList];
    }];

}



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}


#pragma mark ------------------------Init---------------------------------
-(void)_init {
    self.pageTitle = @"购物车";
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    [self _assignAdressData];
    [self _assingStoreAdressData];
    [self _initShopCartTableView];
}

- (void)_assingStoreAdressData {
    
    self.displayAdressView.adressLabel.text = jFormat(@"%@ %@",self.confiureDispatchGoodsResultInfo[@"storeAddress"],self.confiureDispatchGoodsResultInfo[@"storeName"]);
}

- (void)_initShopCartTableView {
    self.shopCartTableView.backgroundColor = [UIColor clearColor];
    CGFloat cellHeight = DispatchGoodsCellHeight;
    //    if (kScreenWidth == iPhone5_width) {//屏幕宽度为32
    //        cellHeight = ADAPT_SCREEN_WIDTH(70) + 50;
    //    }
    self.shopCartTableView.cellHeight = cellHeight;

    [self.shopCartTableView configurecellNibName:@"DLDispatchGoodsCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        
        DLDispatchGoodsCell *goodsCell = (DLDispatchGoodsCell *)cell;
        CGFloat cellImgBgWidthHeight = DispatchGoodsCellImgWidth;
        //        if (kScreenWidth ==iPhone5_width ) {
        //            cellImgBgWidthHeight = ADAPT_SCREEN_WIDTH(70);
        //        }
        goodsCell.imgBgViewWidthConstraint.constant = cellImgBgWidthHeight ;
        goodsCell.imgBgViewHeightConstraint.constant = cellImgBgWidthHeight ;
        goodsCell.selecteButton.hidden = NO;
        goodsCell.imgBgViewToLeftConstraint.constant = 45;
        GoodsModel *model = (GoodsModel *)cellModel;
        goodsCell.selecteButton.selected = model.selected;
        [goodsCell setCellModel:model];
        for (NSLayoutConstraint *imgViewToSide in goodsCell.imgViewToSideEdges) {
            imgViewToSide.constant = 10;
        }
        WEAK_SELF
        WEAK_OBJ(model)
        goodsCell.selectDispatchGoodsBlock = ^(UIButton *selectedButton){
            weak_model.selected = selectedButton.selected;
            [weak_self _requestSelecteGoods:@[weak_model] selected:selectedButton.selected isAllGoods:NO];
        };
        
        goodsCell.changeDispatchGoodsCountBlock = ^(NSInteger nowCount,BOOL isAdd){
            if (nowCount) {
                weak_model.goodsNumber = @(nowCount);
                [weak_self _requesGoodsCountChange:weak_model];
            }else{
                [weak_self _requestDeleteGoods:@[weak_model]];
            }
        };
    }];
    WEAK_SELF
    self.shopCartTableView.firstSectionHeaderHeight = 36;
    [self.shopCartTableView configureFirstSectioHeaderNibName:@"ShopCartSectionHeaderView" ConfigureTablefirstSectionHeaderBlock:^(UITableView *tableView,id cellModel, UIView *firstSectionHeaderView) {
        UILabel *storeNameLabel = (UILabel *)[firstSectionHeaderView viewWithTag:1];
        storeNameLabel.text = weak_self.confiureDispatchGoodsResultInfo[@"warehouseName"];
    }];
    self.shopCartTableView.firstSectionFooterHeight = 50;
    [self.shopCartTableView configureFirstSectioFooterNibName:@"DispatchGoodsOrderTableFooterView" ConfigureTablefirstSectionFooterBlock:^(UITableView *tableView, id cellModel, UIView *firstSectionFooterView) {
        
    }];

    //不分页
    self.shopCartTableView.dataLogicModule.isRequestByPage = NO;
    
}

- (void)bindViewModel {
    
    self.dispatchGoodsOrderVCViewModel = [[DispatchGoodsOrderVCViewModel alloc] init];
    @weakify(self);
    [RACObserve(self.dispatchGoodsOrderVCViewModel, totalPrice) subscribeNext:^(NSNumber* totalPrice) {
        @strongify(self);
        self.totalPriceLabel.text = kPriceFloatValueToRMB(totalPrice.floatValue);
    }];
    RAC(self.allSelectedButton,selected) = RACObserve(self.dispatchGoodsOrderVCViewModel, allSelected);
    [RACObserve(self.dispatchGoodsOrderVCViewModel, shopCartIsEmpty) subscribeNext:^(NSNumber *isEmpty) {
        @strongify(self);
        [self _shopCartPageUiConfigureIsEmpty:isEmpty.integerValue];
    }];
  
    [RACObserve(self.dispatchGoodsOrderVCViewModel, selectedShopCartGoodsNumber) subscribeNext:^(NSNumber *selectedShopCartGoodsNumber) {
        @strongify(self);
        NSString *title = [NSString stringWithFormat:@"生成调拨单(%ld)",        selectedShopCartGoodsNumber.integerValue];
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
- (void)_registerNotification {
    NSLog(@"");
}

- (void)_assignAdressData {
    self.displayAdressView.hidden = NO;
}

- (void)_refreshTableWhenDeleteGoods{
    
    if (self.dispatchGoodsOrderVCViewModel.willFreshIndexPaths.count > 0) {
        [self.shopCartTableView deleteRowsAtIndexPaths:self.dispatchGoodsOrderVCViewModel.willFreshIndexPaths withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (void)_selecteAllGoodsWhenEnterShopCartPage {
    self.allSelectedButton.selected = YES;
    [self _requestSelecteGoods:self.dispatchGoodsOrderVCViewModel.shopCartList selected:self.allSelectedButton.selected isAllGoods:YES];
}


- (void)_shopCartPageUiConfigureIsEmpty:(BOOL)isEmpty {
    self.shopCartTableView.hidden = isEmpty;
    self.bottomView.hidden = isEmpty;
    self.emptyShopCartView.hidden = !isEmpty;
}

- (void)_refreshTalbeWhenSelecteGoods {
    if (self.dispatchGoodsOrderVCViewModel.willFreshIndexPaths.count > 0) {
        [self.shopCartTableView reloadRowsAtIndexPaths:self.dispatchGoodsOrderVCViewModel.willFreshIndexPaths withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)_deleteGoods:(NSArray *)goods {
    WEAK_SELF
    [self showSimplyAlertWithTitle:@"提示" message:@"确认删除该商品?" sureAction:^(UIAlertAction *action) {
        [weak_self _requestDeleteGoods:goods];
    } cancelAction:^(UIAlertAction *action) {
        
    }];
}

- (void)_configureAdressUiWhenConfirmAdressInfo:(AdressModel *)confirmAdress {
    if (!confirmAdress.consigneAdressId) {//删了
        self.displayAdressView.hidden = YES;
    }else {
        self.displayAdressView.hidden = NO;
        self.displayAdressView.adressModel = confirmAdress;
    }
    self.adressModel = confirmAdress;
}

- (BOOL)_checkErrorWhenSubbmitOrder {
    
    if (![DispatchGoodsManager sharedManager].selectedGoodsIdToNumberArr.count) {
        [self hideHubWithOnlyText:@"你还未选择调货商品，请先选择调货商品"];
        return YES;
    }
    
    return NO;
}

#pragma mark ------------------------Api-------------------------------------
- (void)_requestShopCartTotalNumber {
    
    [[self.dispatchGoodsOrderVCViewModel trigerShopCartTotalNumberSignal] subscribeNext:^(NSNumber *totalNumber) {
        
    }];
}

- (void)_requestShopCartList {
    
    @weakify(self);
    [[self.dispatchGoodsOrderVCViewModel trigerShopCartlistRequestSignal] subscribeNext:^(NSArray* shopCartList) {
        @strongify(self);
        [self.shopCartTableView configureTableAfterRequestPagingData:shopCartList];
        self.dispatchGoodsOrderVCViewModel.shopCartList = self.shopCartTableView.dataLogicModule.currentDataModelArr;
        [self.dispatchGoodsOrderVCViewModel.shopCartList setIndexPathInselfContainer];
        [self _selecteAllGoodsWhenEnterShopCartPage];
        [self _assignAdressData];
    }];
}

- (void)_requestDeleteGoods:(NSArray *)deleteGoods {
    @weakify(self);
    [[self.dispatchGoodsOrderVCViewModel trigerDeleteGoodsSignalWithParamGoods:deleteGoods] subscribeNext:^(NSDictionary *resultDic) {
        @strongify(self);
        [self _refreshTableWhenDeleteGoods];
    }];
}

- (void)_requestOrderConfirm {
    
    NSArray *selectedGoodsIdToNumberArr = [DispatchGoodsManager sharedManager].selectedGoodsIdToNumberArr;
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:0];
    [requestParam setObject:selectedGoodsIdToNumberArr forKey:@"allotInfo"];
    UITextField *noteTextField = (UITextField *)[self.shopCartTableView viewWithTag:17];
    if (!isEmpty(noteTextField.text)) {
        [requestParam setObject:noteTextField.text forKey:@"allotNote"];
    }
    
    [self showLoadingHubWithText:@"正在生成调货单.."];
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_CreateDispatchGoodsOrder block:^(NSDictionary *resultDic, NSError *error) {
        if (error.code == 1) {
            [self hideHubForText:@"生成调货单成功"];
            [[DispatchGoodsManager sharedManager] clearProducedOrderGoods];
            DLInvoiceListModel *dispatchGoodsOrderModel = [[DLInvoiceListModel alloc] initWithDefaultDataDic:resultDic[EntityKey]];
            [self _enterDispatchGoodsResultPageWithDispatchOrderModel:dispatchGoodsOrderModel];
        }else {
            [self hideLoadingHub];
            [Util ShowAlertWithOnlyMessage:error.localizedDescription];
        }
    }];
}

- (void)_requestSelecteGoods:(NSArray *)selectedGoods selected:(BOOL)selected isAllGoods:(BOOL)isAllGoods{
    if (isAllGoods) {
        [self.dispatchGoodsOrderVCViewModel trigerAllSelectedDeselectedSignalWithParamSelected:selected];
    }else {
        [self.dispatchGoodsOrderVCViewModel trigerSelectDeselctGoodsSignalWithParamGoods:selectedGoods selected:selected];
    }
    [self _refreshTalbeWhenSelecteGoods];
}

- (void)_requesGoodsCountChange:(GoodsModel *)goodsModel {

}

- (void)_requestTheDefaultAdress {
    
//    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_GetDefaultAdress parameters:nil block:^(id result, NSError *error) {
//        if (isEmpty(result[@"data"][@"shippingAddressId"])) {
//            self.adressModel = nil;
//            self.shopCartTableView.firstSectionHeaderHeight = kNoDefaultAdressViewHeight;
//        }else {
//           self.adressModel = [[AdressModel alloc] initWithDefaultDataDic:result[@"data"]];
//            self.shopCartTableView.firstSectionHeaderHeight = kDefaultAdressViewHeight;
//        }
//        [self.shopCartTableView reloadData];
//    }];
}

#pragma mark ------------------------Page Navigate---------------------------
- (void)_enterDispatchGoodsResultPageWithDispatchOrderModel:(DLInvoiceListModel *)dispatchOrderModel {
    DLDispatchGoodsResultVC *dispatchGoodsResultVC = [[DLDispatchGoodsResultVC alloc] init];
    dispatchGoodsResultVC.dispatchGoodsOrderModel = dispatchOrderModel;
    [self navigatePushViewController:dispatchGoodsResultVC animate:YES];
}

#pragma mark ------------------------View Event---------------------------
- (IBAction)gotoPayAction:(id)sender {
    
    if ([self _checkErrorWhenSubbmitOrder]) {
        return;
    }
    
    [self _requestOrderConfirm];
  
}

- (IBAction)addAdressAction:(id)sender {
}

- (void)goBack {
    
    [super goBack];
}

- (void)_backBlock {
    emptyBlock(self.comfromPerHomePageBlock,self.lastHomeIndex);

}

- (IBAction)selectAllAction:(id)sender {
    UIButton *allSelectedButton = (UIButton *)sender;
    allSelectedButton.selected = !allSelectedButton.selected;
    [self _requestSelecteGoods:self.dispatchGoodsOrderVCViewModel.shopCartList selected:allSelectedButton.selected isAllGoods:YES];
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

- (UIView *)noDefaultAdressShowView {

    if (!_noDefaultAdressShowView) {
        _noDefaultAdressShowView = BoundNibView(@"DLNoDefaltAdressView", UIView);
    }
    return _noDefaultAdressShowView;
}

- (DisplayAdressView *)displayAdressView {
    
    if (!_displayAdressView) {
        _displayAdressView = BoundNibView(@"DisplayAdressView", DisplayAdressView);
        [self.adressBgView addSubview:_displayAdressView];
        [_displayAdressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.adressBgView);
        }];
        WEAK_SELF
        _displayAdressView.clickAdressBlock = ^(){
        };
    }
    return _displayAdressView;

}

- (UIView *)emptyShopCartView {
    
    if (!_emptyShopCartView) {
        _emptyShopCartView = BoundNibView(@"ShopCartIsEmptyView", UIView);
        [self.view addSubview:_emptyShopCartView];
        [_emptyShopCartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.shopCartTableView);
        }];
        WEAK_SELF
        UIButton *continueShopButton = (UIButton *)[_emptyShopCartView viewWithTag:1];
        [continueShopButton addActionHandler:^(NSInteger tag) {

        }];
    }
    return _emptyShopCartView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

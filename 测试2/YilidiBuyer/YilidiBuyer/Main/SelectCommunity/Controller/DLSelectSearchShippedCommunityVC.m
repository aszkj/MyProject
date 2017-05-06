//
//  DLSelectSearchShippedCommunityVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/26.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLSelectSearchShippedCommunityVC.h"
#import "MycommonTableView.h"
#import "DLShipAdressCell.h"
#import "DLGoodsSearchTopView.h"
#import "DLSearchAdressCell.h"
#import "DLSearchAdressKeyWordsListView.h"
#import "DLSearchNearbyRegionVC.h"
#import "DLLocationNearByRegionListVC.h"
#import "DLAdressListCell.h"
#import "ProjectRelativeKey.h"
#import "NSArray+extend.h"
#import "GlobleConst.h"
#import "ProjectRelativeDefineNotification.h"
#import "UIButton+Block.h"
#import "DLAdressListVC.h"
#import "BaseTableView+nodataShow.h"
#import "SegementView.h"
#import <Masonry/Masonry.h>
#import "ProjectStandardUIDefineConst.h"
#import "DLStoreCell.h"
#import "DLAddEditAdressVC.h"
#import "SUIMacro.h"
#import "BaiduLocationManage.h"
@interface DLSelectSearchShippedCommunityVC ()

@property (weak, nonatomic) IBOutlet MycommonTableView *shipAdressTableView;
@property (strong, nonatomic)MycommonTableView *selfTakeTableView;

@property (nonatomic, strong)DLGoodsSearchTopView *goodsSearchTopView;
@property (weak, nonatomic) IBOutlet UIView *addressAndSelfTakeSwitchBgView;
@property (weak, nonatomic) IBOutlet SegementView *addressAndSelfTakeSwitchView;
@property (nonatomic, assign)BOOL hasLoadStoreData;

@end

@implementation DLSelectSearchShippedCommunityVC

- (void)viewDidLoad {
    self.doNotNeedBaseBackItem = YES;
    [super viewDidLoad];
    
    [self _init];
    
    [self _initShipAdressTableView];
    
    [self _initaddressAndSelfTakeSwitchView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (!_goodsSearchTopView) {
        [self _initGoodsSearchTopView];
    }else {
        _goodsSearchTopView.hidden = NO;
    }
    if (SESSIONID) {
        [self _requestAdressList];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.goodsSearchTopView.hidden = YES;
}


#pragma mark ------------------------Init---------------------------------
-(void)_init {
    
    self.navigationController.view.backgroundColor = self.view.backgroundColor;
}

-(void)_initaddressAndSelfTakeSwitchView {
    
    self.addressAndSelfTakeSwitchView.textFont = kSystemFontSize(14.0);
    self.addressAndSelfTakeSwitchView.selectedBackGroundColor = KSelectedBgColor;
    self.addressAndSelfTakeSwitchView.segementLayerBorderWidth = 1.0f;
    self.addressAndSelfTakeSwitchView.segementLayerCornerRadius = 5.0f;
    self.addressAndSelfTakeSwitchView.selectedTextColor = [UIColor whiteColor];
    self.addressAndSelfTakeSwitchView.segementLayerBorderColor = KSelectedBgColor;
    self.addressAndSelfTakeSwitchView.segementTitles = @[@"我的收货地址",@"附近自提门店"];
    WEAK_SELF
    self.addressAndSelfTakeSwitchView.selectedSegementBlock = ^(NSInteger selectIndex){
        if (selectIndex == 0) {
            weak_self.shipAdressTableView.hidden = NO;
            weak_self.selfTakeTableView.hidden = YES;
        }else {
            weak_self.shipAdressTableView.hidden = YES;
            weak_self.selfTakeTableView.hidden = NO;
            if (!weak_self.hasLoadStoreData) {
                [self _requestNearbyStoreList];
            }
        }
    };
    
}


-(void)_initGoodsSearchTopView {
    
    self.goodsSearchTopView = BoundNibView(@"DLGoodsSearchTopView", DLGoodsSearchTopView);
    [self.navigationController.view addSubview:self.goodsSearchTopView];
    WEAK_SELF
    [self.goodsSearchTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.navigationController.view.mas_top).with.offset(20);
        make.left.right.mas_equalTo(weak_self.navigationController.view);
        make.height.mas_equalTo(44);
    }];
    
    self.goodsSearchTopView.searchType = SearchType_Area;
    self.goodsSearchTopView.clickToBeginSearchBlock = ^{
        [weak_self _comtoNearbyRegionPage];
    };

    self.goodsSearchTopView.searchBackBlock = ^{
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
    
    self.goodsSearchTopView.cancelSearchBlock = ^(){
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
    
}

-(void)_initShipAdressTableView {

    WEAK_SELF
    self.shipAdressTableView.cellHeight = kAdressListCellHeight;
     self.shipAdressTableView.nodataAlertTitle = @"抱歉，你还没有添加收货地址";
    [self.shipAdressTableView configurecellNibName:@"DLAdressListCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        AdressModel *model = (AdressModel *)cellModel;
        DLAdressListCell *shipCell = (DLAdressListCell *)cell;
        [shipCell setAdressCellData:model];
//        uBlock(model);
        WEAK_OBJ(model)
        shipCell.editAdressBlock = ^{
            [weak_self _comToEditAddressPageWithType:EditAdressType addressModel:weak_model];
        };

    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        AdressModel *model = (AdressModel *)cellModel;
        [weak_self _judgeWhetherIntheShipRangeOfSelectedCommunityModel:model.communityModel];
    }];
    
//    self.shipAdressTableView.firstSectionHeaderHeight = 33;
//    [self.shipAdressTableView configureFirstSectioHeaderNibName:@"ShipAdressSectionHeader" ConfigureTablefirstSectionHeaderBlock:^(UITableView *tableView, id cellModel, UIView *firstSectionHeaderView) {
//        UIButton *manageAdressButton = (UIButton *)[firstSectionHeaderView viewWithTag:1];
//
//        [manageAdressButton addActionHandler:^(NSInteger tag) {
//            [weak_self _enterAdressListPage];
//        }];
//    }];
    
}

- (void)_initSelfTakeTableView {
    WEAK_SELF
    self.selfTakeTableView.cellHeight = kStoreCellHeight;
    self.selfTakeTableView.nodataAlertTitle = @"附近没有相关自提门店";
    [self.selfTakeTableView configurecellNibName:@"DLStoreCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        
        StoreModel *model = (StoreModel *)cellModel;
        DLStoreCell *storeCell = (DLStoreCell *)cell;
        [storeCell setCellModel:model];
        
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        StoreModel *storeModel = (StoreModel *)cellModel;
        [weak_self _alertSwitchSelfTakeStoreWithStoreModel:storeModel alertStr:kAlertTitleSwitchSelfTakeStore];
    }];
}

- (NSArray *)_getTestStoreDatas {
    StoreModel *model1 = [[StoreModel alloc] init];
    model1.storeName = @"科技园店";
    model1.storeAdress = @"深圳市南山区科兴科学园";
    model1.storeBusinessBeginTime = @"08:30";
    
    StoreModel *model2 = [[StoreModel alloc] init];
    model2.storeName = @"科技园店";
    model2.storeAdress = @"深圳市南山区科兴科学园";
    model2.storeBusinessBeginTime = @"19:30";
    self.hasLoadStoreData = YES;
    return @[model1,model2];
}


- (void)_selectCommunityBackWithCommunityModel:(CommunityModel *)communityModel {
    
    afterSecondsLoadData(0.5, [kNotification postNotificationName:KNotificationSwitchCommunity object:communityModel];)
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)_selectSelfTakeStoreBackWithStoreModel:(StoreModel *)storeModel {
    
    afterSecondsLoadData(0.5, [kNotification postNotificationName:KNotificationSwitchStoreSelfTake object:storeModel];)
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)_judgeWhetherIntheShipRangeOfSelectedCommunityModel:(CommunityModel *)communityModel {
    
    if (![self _judgeRelevanceStoreOfCommunity:communityModel]) {
        [self _alertSwitchCommunityWithCommunityModel:communityModel alertStr:kAlertTitleSwitchCommunityNoStoreAndNotInShipRange];
        return;
    }
    
    if (![communityModel.communityStore.storeId isEqualToString:kCommunityStoreId]) {
       [self _alertSwitchCommunityWithCommunityModel:communityModel alertStr:kAlertTitleSwitchCommunityNotInShipRange];
    }else{
        [self _selectCommunityBackWithCommunityModel:communityModel];
    }
}

- (void)_alertSwitchSelfTakeStoreWithStoreModel:(StoreModel *)storeModel alertStr:(NSString *)alertStr{
    [self showSimplyAlertWithTitle:@"提示" message:alertStr sureAction:^(UIAlertAction *action) {
        [self _selectSelfTakeStoreBackWithStoreModel:storeModel];
    } cancelAction:^(UIAlertAction *action) {
        
    }];
}



- (void)_alertSwitchCommunityWithCommunityModel:(CommunityModel *)communityModel alertStr:(NSString *)alertStr{
    [self showSimplyAlertWithTitle:@"提示" message:alertStr sureAction:^(UIAlertAction *action) {
        [self _selectCommunityBackWithCommunityModel:communityModel];
    } cancelAction:^(UIAlertAction *action) {
        
    }];
}

- (BOOL)_judgeRelevanceStoreOfCommunity:(CommunityModel *)communityModel {
    BOOL hasCommunityRelevanceStore = YES;
    if (isEmpty(communityModel)) {
        return NO;
    }
    
    if (isEmpty(communityModel.communityStore)) {
        hasCommunityRelevanceStore = NO;
    }else {
        if (isEmpty(communityModel.communityStore.storeId)) {
            hasCommunityRelevanceStore = NO;
        }else {
            hasCommunityRelevanceStore = YES;
        }
    }
    return hasCommunityRelevanceStore;
}



#pragma mark ------------------------Private-------------------------

#pragma mark ------------------------Api----------------------------------
- (void)_requestAdressList {
    [self showHubWithStatus:@"正在加载地址列表.."];
    [AFNHttpRequestOPManager postWithParameters:nil subUrl:kUrl_GetAdressList block:^(NSDictionary *resultDic, NSError *error) {
        [self dissmiss];
        NSArray *resultArr = resultDic[EntityKey];
        if (isEmpty(resultArr)) {
            return ;
        }
        NSArray *transferedArr = [resultArr transferDicArrToModelArrWithModelClass:[AdressModel class]];
        self.shipAdressTableView.dataLogicModule.currentDataModelArr = [transferedArr mutableCopy];
        [self.shipAdressTableView nodataShowDeal];
        [self.shipAdressTableView reloadData];
    }];
}

- (void)_requestNearbyStoreList {
    [self showHubWithStatus:@"正在加载附近店铺列表.."];
    BaiduLocationManage *baiduLocationManager = [BaiduLocationManage shareManage];
    [self _requestNearbyStoreListWithLogintitude:baiduLocationManager.longtitude latitude:baiduLocationManager.latitude];
}


- (void)_requestNearbyStoreListWithLogintitude:(CGFloat)longtitude latitude:(CGFloat)latitude {
    self.requestParam = @{@"longitude":@(longtitude),
                          @"latitude":@(latitude)};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_GetNearbyStoreList block:^(NSDictionary *resultDic, NSError *error) {
        [self dissmiss];
        self.hasLoadStoreData = YES;
        NSArray *resultArr = resultDic[EntityKey];
        if (isEmpty(resultArr)) {
            return ;
        }
        NSArray *transferedArr = [resultArr transferDicArrToModelArrWithModelClass:[StoreModel class]];
        self.selfTakeTableView.dataLogicModule.currentDataModelArr = [transferedArr mutableCopy];
        [self.selfTakeTableView nodataShowDeal];
        [self.selfTakeTableView reloadData];
    }];
}


#pragma mark ------------------------Page Navigate---------------------------
- (void)_comtoNearbyRegionPage {
    DLSearchNearbyRegionVC *searchNearbyRegionVC = [[DLSearchNearbyRegionVC alloc] init];
    WEAK_SELF
    searchNearbyRegionVC.popToLastPageBlock = ^{
        [weak_self goBack];
    };
    searchNearbyRegionVC.comeToNearBySearchPageType = ComeToNearBySearchPage_FromSwicthCommunity;
    [self navigatePushViewController:searchNearbyRegionVC animate:YES];
}

- (void)_comtoLocationNearbyRegionlistPage {
    DLLocationNearByRegionListVC *locationNearByRegionListVC = [[DLLocationNearByRegionListVC alloc] init];
    WEAK_SELF
    locationNearByRegionListVC.popToLastPageBlock = ^{
        [weak_self goBack];
    };
    [self navigatePushViewController:locationNearByRegionListVC animate:YES];
}

- (void)_enterAdressListPage {
    DLAdressListVC *adressList = [[DLAdressListVC alloc] init];
    adressList.comeToAdresModuleType = ComeToAdresModule_FromManageAdress;
    [self navigatePushViewController:adressList animate:YES];
}

- (void)_comToEditAddressPageWithType:(OperatorAddressType)operatorAddressType addressModel:(AdressModel *)addressModel{
    DLAddEditAdressVC *editAddressVC = [[DLAddEditAdressVC alloc] init];
    editAddressVC.operatorAddressType = operatorAddressType;
    if (addressModel) {
        editAddressVC.shippingAddressId = addressModel.consigneAdressId;
    }
    [self.navigationController pushViewController:editAddressVC animated:YES];
}



#pragma mark ------------------------View Event---------------------------
- (IBAction)locationNearbyCommunityAction:(id)sender {
    [self _comtoLocationNearbyRegionlistPage];
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

-(MycommonTableView *)selfTakeTableView {
    
    if (!_selfTakeTableView) {
        _selfTakeTableView = [[MycommonTableView alloc] initWithFrame:self.shipAdressTableView.frame];
        [self.view addSubview:_selfTakeTableView];
        _selfTakeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self _initSelfTakeTableView];
    }
    return _selfTakeTableView;
}

@end

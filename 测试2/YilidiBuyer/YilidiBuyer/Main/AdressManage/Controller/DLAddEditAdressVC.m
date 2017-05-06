//
//  DLAddEditAdressVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLAddEditAdressVC.h"
#import "UITextField+placeHolderSetting.h"
#import "DLEditAdressViewModel.h"
#import "DLLocationNearByRegionListVC.h"
#import "DLShopCarVC.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "DLGlobleRequestApiManager.h"
#import "ActionSheetPicker.h"
#import "AdressModel.h"
#import "CommunityDataManager.h"
#import "GlobleConst.h"
#import "ProjectRelativeDefineNotification.h"
#import "DLSearchNearbyRegionVC.h"
@interface DLAddEditAdressVC ()
@property (weak, nonatomic) IBOutlet UITextField *consigneePersonNameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *consigneePersonNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *consigneeAddressButton;
@property (weak, nonatomic) IBOutlet UITextField *consigneeBuidingRoomNumberTextField;

@property (nonatomic, copy)NSString *communityId;
@property (nonatomic, copy)NSString *cityCode;
@property (nonatomic, copy)NSString *provinceCode;
@property (nonatomic, copy)NSString *countyCode;

@property (nonatomic, strong)DLEditAdressViewModel *editAdressViewModel;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet UIButton *manButton;
@property (weak, nonatomic) IBOutlet UIButton *womenButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteSaveAdressButton;
@property (nonatomic, strong)NSMutableDictionary *canBeShippedCityDic;



/**
 *  0-女生，1-男生
 */
@property (nonatomic, strong)NSNumber *genderNumber;


@end

@implementation DLAddEditAdressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
//    [self _requestCanbeShippedCityList];
    
    if (self.isComeForQuilocate) {
        [self _comtoSelectedNeartyAdressPage];
    }
}

#pragma mark ------------------------Init---------------------------------
-(void)_init {
    
    NSString *deleteSaveAdressButtonTitle = nil;
    if (self.operatorAddressType == EditAdressType) {
        self.pageTitle = @"编辑收货地址";
        deleteSaveAdressButtonTitle = @"删除当前地址";
        [self _requestAdressDetailInfo];
        [self _initRightItem];
    }else {
        deleteSaveAdressButtonTitle = @"保存";
        self.pageTitle = @"新增收货地址";
        [self _initAddAdressDefaultUIInfo];
        [self _initSomeCanBeChangedAdressInfoWithAdressModel:nil];
    }
    
    [self.deleteSaveAdressButton setTitle:deleteSaveAdressButtonTitle forState:UIControlStateNormal];
    [self.consigneePersonNameTextFiled setTextPlaceHolderFont:kSystemFontSize(14) placeHolderTextColor:nil];
    [self.consigneePersonNumberTextField setTextPlaceHolderFont:kSystemFontSize(14) placeHolderTextColor:nil];
    [self.consigneeBuidingRoomNumberTextField setTextPlaceHolderFont:kSystemFontSize(14) placeHolderTextColor:nil];
}

- (void)_initAddAdressDefaultUIInfo {
    NSString *cityName = nil;
    if (kCurrentShipWay == ShipWay_DeliveryGoodsHome) {
        [self.consigneeAddressButton setTitle:[CommunityDataManager sharedManager].communityModel.communityName forState:UIControlStateNormal];
        cityName = kCurrentCummunity.cityName;
    }else {
        cityName = kCurrentStore.cityName;
    }
    [self.cityButton setTitle:cityName forState:UIControlStateNormal];
//    self.consigneeBuidingRoomNumberTextField.text = [CommunityDataManager sharedManager].communityModel.communityAdressDetail;
}

-(void)_initRightItem {
    
    UIBarButtonItem *rightItem = [UIBarButtonItem initWithTitle:@"保存" titleColor:[UIColor whiteColor] target:self action:@selector(save)];
    UIButton *rightItemButton = (UIButton *)rightItem.customView;
    [rightItemButton setTitleColor:KSelectedBgColor forState:UIControlStateNormal];
    rightItemButton.titleLabel.font = kSystemFontSize(16.0f);
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem barButtonItemSpace:-12],rightItem];
    
}

- (void)_initSomeCanBeChangedAdressInfoWithAdressModel:(AdressModel *)adressModel {
    
    if (self.operatorAddressType == EditAdressType) {
        self.communityId = adressModel.communityModel.communityId;
        self.provinceCode = adressModel.communityModel.provinceCode;
        self.cityCode = adressModel.communityModel.cityCode;
        self.countyCode = adressModel.communityModel.countyCode;
    }else {
        if (kCurrentShipWay == ShipWay_SelfTake) {
            return;
        }
        CommunityModel *communtiyModel = [CommunityDataManager sharedManager].communityModel;
        self.communityId = communtiyModel.communityId;
        self.provinceCode = communtiyModel.provinceCode;
        self.cityCode = communtiyModel.cityCode;
        self.countyCode = communtiyModel.countyCode;
    }
}


#pragma mark ------------------------Private-------------------------
- (void)_asignUiWithData:(AdressModel *)model{
    self.consigneePersonNameTextFiled.text = model.consigneePersonName;
    self.consigneePersonNumberTextField.text = model.consigneePersonPhoneNumber;
    [self.consigneeAddressButton setTitle:model.communityModel.communityName forState:UIControlStateNormal];
     self.consigneeBuidingRoomNumberTextField.text = model.consigneePersonalDetailAdress;
    [self.cityButton setTitle:model.communityModel.cityName forState:UIControlStateNormal];
    self.cityCode = model.communityModel.cityCode;
}

- (void)_notifyShopCartPageWithResultDic:(NSDictionary *)resultDic isDeleteAdress:(BOOL)isDeleteAdress{
//    AdressModel *adressModel = nil;
//    if (!isDeleteAdress) {
//        adressModel = [[AdressModel alloc] initWithDefaultDataDic:resultDic[EntityKey]];
//    }else {
//        adressModel.consigneAdressId = nil;
//    }
//    afterSecondsLoadData(1.0f,
//                         [kNotification postNotificationName:KNotificationShopCartConfirmAdress object:adressModel];
//                         )
}

- (void)_assignSelectedAddressInfo:(CommunityModel *)selectAdressModel {
    
    [self.consigneeAddressButton setTitle:selectAdressModel.communityName forState:UIControlStateNormal];
    self.consigneeBuidingRoomNumberTextField.text = nil;
    self.communityId = selectAdressModel.communityId;
    self.provinceCode = selectAdressModel.provinceCode;
    self.cityCode = selectAdressModel.cityCode;
    self.countyCode = selectAdressModel.countyCode;
}

- (void)_showAlertWhenSelectNotInTheShipRangeWithSelecteCommunityModel:(CommunityModel *)adressModel {
    WEAK_SELF
    [self showSimplyAlertWithTitle:@"提示" message:@"你所选的小区不在当前当铺的配送范围内，是否继续？" sureAction:^(UIAlertAction *action) {
        [weak_self _assignSelectedAddressInfo:adressModel];
    } cancelAction:^(UIAlertAction *action) {
        
    }];
}

- (void)_selecteNearbyAddress:(CommunityModel *)adressModel {
    if ([adressModel.communityStore.storeId isEqualToString:kCommunityStoreId]) {
        [self _assignSelectedAddressInfo:adressModel];
    }else {
        if (self.comeToAdresModuleType == ComeToAdresModule_FromShopCart) {
            [self _showAlertWhenSelectNotInTheShipRangeWithSelecteCommunityModel:adressModel];
        }else {
            [self _assignSelectedAddressInfo:adressModel];
        }
    }
}

- (void)_modifyEdressLogic {
    [self showLoadingHubWithText:@"正在保存.."];
    if (self.operatorAddressType == AddAdressType) {
        [self _requestAddAdress];
    }else {
        [self _requestEditAdress];
    }
}

#pragma mark -------------------PageNaviGate Method----------------------
- (void)_comtoSelectedNeartyAdressPage {
    DLLocationNearByRegionListVC *adressSearchVC = [[DLLocationNearByRegionListVC alloc] init];
    WEAK_SELF
    adressSearchVC.selecteOneCanbeShipedRegionAdressBlock = ^(CommunityModel *addressModel){
        [weak_self performSelector:@selector(_selecteNearbyAddress:) withObject:addressModel afterDelay:0.2];
    };
    [self.navigationController pushViewController:adressSearchVC animated:YES];
}

- (void)_popToShopCartVC {
//    if (self.navigationController.viewControllers.count) {
//        for (UIViewController *controller in self.navigationController.viewControllers) {
//            if ([controller isMemberOfClass:[DLShopCarVC class]]) {
//                DLShopCarVC *makeSureOrderVC = (DLShopCarVC *)controller;
//                [self.navigationController popToViewController:makeSureOrderVC animated:YES];
//                break;
//            }
//        }
//    }
//    emptyBlock(self.popToLastPageBlock);
    [self goBack];
}

- (void)_enterSearchNearbyRegionPage {
    DLSearchNearbyRegionVC *searchNearbyRegionVC = [[DLSearchNearbyRegionVC alloc] init];
    searchNearbyRegionVC.comeToNearBySearchPageType = ComeToNearBySearchPage_FromEditAddAdress;
    WEAK_SELF
    searchNearbyRegionVC.searchNearbyRegionResultBlock = ^(CommunityModel *communityModel){
        [weak_self performSelector:@selector(_selecteNearbyAddress:) withObject:communityModel afterDelay:0.2];
    };
    [self navigatePushViewController:searchNearbyRegionVC animate:YES];
}

#pragma mark ------------------------Api----------------------------------
- (void)_requestAdressDetailInfo {
    [self.editAdressViewModel requestAdressDetailInfoWithAdressId:self.shippingAddressId backBlcok:^(id obj, NSError *error) {
        AdressModel *model = (AdressModel *)obj;
        [self _asignUiWithData:model];
        [self _initSomeCanBeChangedAdressInfoWithAdressModel:model];
    }];
}

- (void)_requestCanbeShippedCityList {
    DLGlobleRequestApiManager *globalRequestManager = [DLGlobleRequestApiManager sharedManager];
    if (!globalRequestManager.canbeShippedCityList.count) {
        [globalRequestManager requestCanbeShippedCityListWithBackBlock:^(NSArray*result, NSError *error) {
            [self _dealTheResultCitys:result];
        }];
    }else {
        [self _dealTheResultCitys:globalRequestManager.canbeShippedCityList];
    }
    
}

- (void)_dealTheResultCitys:(NSArray *)resultCitys {
    self.canBeShippedCityDic = [NSMutableDictionary dictionaryWithCapacity:resultCitys.count];
    for (NSDictionary *dic in resultCitys) {
        [self.canBeShippedCityDic setObject:dic[@"code"] forKey:dic[@"name"]];
    }
}

- (void)_showCancelOrderPicker {
    
    ActionSheetStringPicker *actionPicker = [[ActionSheetStringPicker alloc]initWithTitle:@"选择城市" rows:self.canBeShippedCityDic.allKeys initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        self.cityCode = self.canBeShippedCityDic[selectedValue];
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:self.view];
    [actionPicker showActionSheetPicker];
}



- (void)_requestDeleteShipAdress {
    [self showLoadingHubWithText:@"正在删除地址.."];
    [self.editAdressViewModel requestDeleteAdressWithAdressId:self.shippingAddressId BackBlock:^(NSDictionary *backDic, NSError *error) {
        [self hideLoadingHub];
        [self _notifyShopCartPageWithResultDic:backDic isDeleteAdress:YES];
        [self performSelector:@selector(goBack) withObject:nil afterDelay:0.2];
    }];
}

- (void)_requestEditAdress{
    
    [self.editAdressViewModel requestEditAdressWithAdressParam:[self _getEditAddAdressParam] backBlcok:^(NSDictionary *backDic, NSError *error) {
        [self hideLoadingHub];
        
        if (self.comeToAdresModuleType == ComeToAdresModule_FromShopCart) {
            [self _notifyShopCartPageWithResultDic:backDic isDeleteAdress:NO];
            [self performSelector:@selector(_popToShopCartVC) withObject:nil afterDelay:0.2];
        }else {
            [self goBack];
        }
    }];
}

- (void)_requestAddAdress {
    
    [self.editAdressViewModel requestAddAdressWithAdressParam:[self _getEditAddAdressParam] backBlcok:^(NSDictionary *backDic, NSError *error) {
        [self hideLoadingHub];
        if (error.code != 1) {
            return ;
        }
        if (self.comeToAdresModuleType == ComeToAdresModule_FromShopCart) {
            [self _notifyShopCartPageWithResultDic:backDic isDeleteAdress:NO];
            [self performSelector:@selector(_popToShopCartVC) withObject:nil afterDelay:0.2];
        }else {
            [self goBack];
        }
    }];
}

- (NSDictionary *)_getEditAddAdressParam {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:self.consigneePersonNameTextFiled.text forKey:@"consigneeName"];
    [param setObject:self.consigneePersonNumberTextField.text forKey:@"phoneNo"];
    [param setObject:self.consigneeBuidingRoomNumberTextField.text forKey:@"addressDetail"];
    
    if (!isEmpty(self.communityId)) {
        [param setObject:self.communityId forKey:@"communityId"];
    }
    if (!isEmpty(self.cityCode)) {
        [param setObject:self.cityCode forKey:@"cityCode"];
    }
    if (!isEmpty(self.provinceCode)) {
        [param setObject:self.provinceCode forKey:@"provinceCode"];
    }
    if (!isEmpty(self.countyCode)) {
        [param setObject:self.countyCode forKey:@"countyCode"];
    }
    
    if (!isEmpty(self.shippingAddressId)) {
        [param setObject:self.shippingAddressId forKey:@"addressId"];
    }

    return [param copy];
}

- (NSString *)_varyFyInput {
    NSString *errorStr = [self.editAdressViewModel varyFyEditAdressInputPersonName:self.consigneePersonNameTextFiled.text personNumber:self.consigneePersonNumberTextField.text adress:self.consigneeAddressButton.titleLabel.text detailAress:self.consigneeBuidingRoomNumberTextField.text];
    return errorStr;
}

#pragma mark ------------------------View Event---------------------------
- (void)save {
    NSString *errorStr = [self _varyFyInput];
    if (errorStr) {
        [Util ShowAlertWithOnlyMessage:errorStr];
        return;
    }
    [self _modifyEdressLogic];
}

- (IBAction)deleteSaveAdressAction:(id)sender {
    if (self.operatorAddressType == EditAdressType) {
        [self _requestDeleteShipAdress];
    }else {
        [self save];
    }
}

- (IBAction)comtoSearchNearbyRegionAction:(id)sender {
    [self _enterSearchNearbyRegionPage];
}

- (IBAction)selectCityAction:(id)sender {
//    [self _showCancelOrderPicker];
}

- (IBAction)selectManAction:(id)sender {
    if (self.manButton.selected) {
        return;
    }
    self.manButton.selected = YES;
    self.womenButton.selected = NO;
    self.genderNumber = @1;
}
- (IBAction)autoLocateAction:(id)sender {
    [self _comtoSelectedNeartyAdressPage];
}

- (IBAction)selecteWomenAction:(id)sender {
    if (self.womenButton.selected) {
        return;
    }
    self.womenButton.selected = YES;
    self.manButton.selected = NO;
    self.genderNumber = @0;

}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

-(DLEditAdressViewModel *)editAdressViewModel {
    
    if (!_editAdressViewModel) {
        _editAdressViewModel = [[DLEditAdressViewModel alloc] init];
    }
    return _editAdressViewModel;
}

@end

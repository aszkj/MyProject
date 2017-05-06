//
//  DLEditAdressVC.m
//  YilidiBuyer
//
//  Created by yld on 16/4/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLEditAdressVC.h"
#import "UITextField+placeHolderSetting.h"
#import "DLEditAdressViewModel.h"
#import "DLLocationNearByRegionListVC.h"
#import "DLShopCarVC.h"
#import "AdressModel.h"
#import "UINavigationController+SUIAdditions.h"
@interface DLEditAdressVC ()
@property (weak, nonatomic) IBOutlet UITextField *consigneePersonNameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *consigneePersonNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *consigneeAddressButton;
@property (weak, nonatomic) IBOutlet UITextField *consigneeBuidingRoomNumberTextField;
@property (nonatomic, strong)DLEditAdressViewModel *editAdressViewModel;

@end

@implementation DLEditAdressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
}

#pragma mark ------------------------Init---------------------------------
-(void)_init {
    
    if (self.operatorAddressType == EditAdressType) {
        self.pageTitle = @"编辑地址";
        [self _requestAdressDetailInfo];
    }else {
        self.pageTitle = @"新增地址";
    }
    [self.consigneePersonNameTextFiled setTextPlaceHolderFont:kSystemFontSize(12) placeHolderTextColor:nil];
    [self.consigneePersonNumberTextField setTextPlaceHolderFont:kSystemFontSize(12) placeHolderTextColor:nil];
    [self.consigneeBuidingRoomNumberTextField setTextPlaceHolderFont:kSystemFontSize(12) placeHolderTextColor:nil];
}

#pragma mark ------------------------Private-------------------------
- (void)_asignUiWithData:(AdressBaseModel *)model{
    self.consigneePersonNameTextFiled.text = model.consigneePersonName;
    self.consigneePersonNumberTextField.text = model.consigneePersonPhoneNumber;
    [self.consigneeAddressButton setTitle:model.consigneePersonAdress forState:UIControlStateNormal];
    self.consigneeBuidingRoomNumberTextField.text = model.consigneePersonalDetailAdress;
}

- (void)_comtoSelectedNeartyAdressPage {
    DLLocationNearByRegionListVC *adressSearchVC = [[DLLocationNearByRegionListVC alloc] init];
    [self.navigationController pushViewController:adressSearchVC animated:YES];
}

- (void)_popToShopCartVC {
    if (self.navigationController.viewControllers.count) {
//        [self.navigationController sui_popToVC:@"DLShopCarVC" animated:YES];
        emptyBlock(self.popToLastPageBlock);
        [self goBack];
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

#pragma mark ------------------------Api----------------------------------
- (void)_requestAdressDetailInfo {
    [self.editAdressViewModel requestAdressDetailInfoWithAdressId:self.shippingAddressId backBlcok:^(id obj, NSError *error) {
        AdressModel *model = (AdressModel *)obj;
        [self _asignUiWithData:model];
    }];
}

- (void)_requestEditAdress{

    [self.editAdressViewModel requestEditAdressWithAdressParam:[self _getEditAdressParam] backBlcok:^(NSDictionary *backDic, NSError *error) {
        [self hideLoadingHub];
        [self performSelector:@selector(_popToShopCartVC) withObject:nil afterDelay:0.2];
    }];
}

- (void)_requestAddAdress {
    
    [self.editAdressViewModel requestAddAdressWithAdressParam:[self _getEditAdressParam] backBlcok:^(NSDictionary *backDic, NSError *error) {
        [self hideLoadingHub];
        [self performSelector:@selector(_popToShopCartVC) withObject:nil afterDelay:0.2];
    }];
}

- (NSDictionary *)_getEditAdressParam {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:self.consigneePersonNameTextFiled.text forKey:@"takegoodsName"];
    [param setObject:self.consigneePersonNumberTextField.text forKey:@"mobile"];
    [param setObject:self.consigneeBuidingRoomNumberTextField.text forKey:@"takegoodsAddr"];
    [param setObject:@1 forKey:@"status"];
    [param setObject:@0 forKey:@"province"];
    [param setObject:@0 forKey:@"city"];
    [param setObject:@0 forKey:@"township"];
    if (self.shippingAddressId) {
        [param setObject:self.shippingAddressId forKey:@"shippingAddressId"];
    }
    return [param copy];
}

- (NSString *)_varyFyInput {
    NSString *errorStr = [self.editAdressViewModel varyFyEditAdressInputPersonName:self.consigneePersonNameTextFiled.text personNumber:self.consigneePersonNumberTextField.text adress:self.consigneeAddressButton.titleLabel.text detailAress:self.consigneeBuidingRoomNumberTextField.text];
    return errorStr;
}

#pragma mark ------------------------View Event---------------------------
- (IBAction)saveAction:(id)sender {
    NSString *errorStr = [self _varyFyInput];
    if (errorStr) {
        [Util ShowAlertWithOnlyMessage:errorStr];
        return;
    }
    [self _modifyEdressLogic];
}

- (IBAction)selectNearbyAdressAction:(id)sender {
    
    [self _comtoSelectedNeartyAdressPage];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

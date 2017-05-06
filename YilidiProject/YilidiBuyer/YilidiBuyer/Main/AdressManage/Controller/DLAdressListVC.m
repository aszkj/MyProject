//
//  DLAdressListVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLAdressListVC.h"
#import "MycommonTableView.h"
#import "DLAdressListCell.h"
#import "SUIUtils.h"
#import "DLAdressListViewModel.h"
#import "NSObject+setModelIndexPath.h"
#import "DLShopCarVC.h"
#import "UIButton+Block.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "DLLocationNearByRegionListVC.h"
#import "DLAddEditAdressVC.h"
#import "DLMeVC.h"
#import "GlobleConst.h"
#import "ProjectRelativeDefineNotification.h"
#import "BaseTableView+nodataShow.h"
const CGFloat addAdressViewHeightConstraint = 80.0f;
@interface DLAdressListVC ()
@property (weak, nonatomic) IBOutlet MycommonTableView *addreeListTableView;
@property (nonatomic, strong)DLAdressListViewModel *adressListViewModel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addShipAdressViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adressTableViewToTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *addShipAdressView;

@end

@implementation DLAdressListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showHubWithStatus:@"正在获取地址列表.."];
    [self _init];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self _requestAdressList];
}


#pragma mark ------------------------Init---------------------------------
-(void)_init {
    if (self.comeToAdresModuleType == ComeToAdresModule_FromManageAdress) {
        [self _initRightNewAdressItem];
        self.addShipAdressViewHeightConstraint.constant = 0;
        self.adressTableViewToTopConstraint.constant = 0;
        self.addShipAdressView.hidden = YES;
    }else {
        self.addShipAdressViewHeightConstraint.constant = addAdressViewHeightConstraint;
        self.addShipAdressView.hidden = NO;
        self.adressTableViewToTopConstraint.constant = 5;

    }
    self.pageTitle = @"收货地址";
    [self _initAddressListTableView];
}

-(void)_initRightNewAdressItem {
    
    UIBarButtonItem *rightItem = [UIBarButtonItem initWithTitle:@"新建" titleColor:KSelectedTitleColor     target:self action:@selector(newAdress)];
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem barButtonItemSpace:-12],rightItem];
}

-(void)_initAddressListTableView {
    
    self.addreeListTableView.cellHeight = kAdressListCellHeight;
    self.addreeListTableView.noDataLogicModule.nodataAlertTitle = @"抱歉，你还没有添加收货地址";
    WEAK_SELF
    [self.addreeListTableView configurecellNibName:@"DLAdressListCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        DLAdressListCell *adressListCell = (DLAdressListCell *)cell;
        AdressModel *model = (AdressModel *)cellModel;
        [adressListCell setAdressCellData:model];
        if (weak_self.comeToAdresModuleType == ComeToAdresModule_FromShopCart) {
            [adressListCell configureUIByTheShipRangeStatus:model.isInDeliveryRange];
        }
        uBlock(model)
//        adressListCell.selectDefaultAdressBlock = ^(UIButton *selectedButton) {
//            [weak_self _setDefaultAdressWithAdressModel:block_model];
//        };
        adressListCell.editAdressBlock = ^{
            [weak_self _comToEditAddressPageWithType:EditAdressType addressModel:block_model];
        };
    
    } clickCell:^(UITableView *tableView,id cellModel,UITableViewCell *cell,NSIndexPath *clickIndexPath){
        AdressModel *model = (AdressModel *)cellModel;
        if (!model.isInDeliveryRange) {
            return ;
        }
        
        if (weak_self.comeToAdresModuleType == ComeToAdresModule_FromManageAdress) {
            return;
        }
        emptyBlock(weak_self.selectAdressBlock,model);
        [weak_self.navigationController popViewControllerAnimated:YES];
//        [kNotification postNotificationName:KNotificationShopCartConfirmAdress object:model];
    }];

}




#pragma mark ------------------------Private-------------------------
- (void)_setDefaultAdressWithAdressModel:(AdressModel *) model{
    if (model.isDefaultConsigneeAdress.integerValue) {
        [self _popToShopCartVC];
    }else {
        [self _requestSetDefaultAdressWithAdressModel:model];
    }
}

- (void)_noAdressListAlert {
    if (self.addreeListTableView.dataLogicModule.currentDataModelArr.count > 0) {
        return;
    }
    WEAK_SELF
    [self showSimplyAlertWithTitle:@"提示" message:@"你还没有默认地址，请先去添加默认地址" sureAction:^(UIAlertAction *action) {
        [weak_self _comToEditAddressPageWithType:AddAdressType addressModel:nil];
    } cancelAction:^(UIAlertAction *action) {
        [weak_self _popToShopCartVC];
    }];
}

#pragma mark -------------------PageNavigate Method----------------------
- (void)_comToEditAddressPageWithType:(OperatorAddressType)operatorAddressType addressModel:(AdressModel *)addressModel{
    DLAddEditAdressVC *editAddressVC = [[DLAddEditAdressVC alloc] init];
    editAddressVC.operatorAddressType = operatorAddressType;
    if (addressModel) {
        editAddressVC.shippingAddressId = addressModel.consigneAdressId;
    }
    WEAK_SELF
    editAddressVC.popToLastPageBlock = ^{
        [weak_self goBack];
    };
    
    editAddressVC.comeToAdresModuleType = self.comeToAdresModuleType;
    [self.navigationController pushViewController:editAddressVC animated:YES];
}


- (void)_popToShopCartVC {
    if (self.navigationController.viewControllers.count) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isMemberOfClass:[DLShopCarVC class]]) {
                DLShopCarVC *makeSureOrderVC = (DLShopCarVC *)controller;
                [self.navigationController popToViewController:makeSureOrderVC animated:YES];
                break;
            }else if([controller isMemberOfClass:[DLMeVC  class]]){
                DLMeVC *meVC = (DLMeVC *)controller;
                [self.navigationController popToViewController:meVC animated:YES];
                break;
                
            }
        }
    }
}

- (void)_comToQuickSelecteAdressPage {
    DLAddEditAdressVC *addEditAdressVC = [[DLAddEditAdressVC alloc] init];
    addEditAdressVC.isComeForQuilocate = YES;
    addEditAdressVC.operatorAddressType = AddAdressType;
    [self navigatePushViewController:addEditAdressVC animate:NO];
}

#pragma mark ------------------------Api----------------------------------
- (void)_requestAdressList {
    @weakify(self);
    [[self.adressListViewModel requestAdresslist] subscribeNext:^(NSArray* resultArr) {
        @strongify(self);
        [self dissmiss];
        self.addreeListTableView.dataLogicModule.currentDataModelArr = [resultArr mutableCopy];
        self.adressListViewModel.adressList = self.addreeListTableView.dataLogicModule.currentDataModelArr;
        [self.addreeListTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
        [self.addreeListTableView reloadData];
        [self.addreeListTableView nodataShowDeal];
    }];
}

- (void)_requestSetDefaultAdressWithAdressModel:(AdressBaseModel *)adressListModel {
    [self showLoadingHub];
    @weakify(self);
    [[self.adressListViewModel requestSetDefaultAdressWithAdressId:adressListModel.consigneAdressId] subscribeNext:^(NSDictionary* backDic) {
        @strongify(self);
        [self hideLoadingHub];
        [self _popToShopCartVC];
    }];
}

#pragma mark ------------------------View Event---------------------------
- (IBAction)addAdressAction:(id)sender {
    [self newAdress];
}

- (void)newAdress {
    [self _comToEditAddressPageWithType:AddAdressType addressModel:nil];
}

- (void)goBack {
      [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

-(DLAdressListViewModel *)adressListViewModel {
    
    if (!_adressListViewModel) {
        _adressListViewModel = [[DLAdressListViewModel alloc] init];
    }
    return _adressListViewModel;
}
@end

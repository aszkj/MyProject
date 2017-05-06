//
//  DLManageAdressVC.m
//  YilidiBuyer
//
//  Created by yld on 16/4/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLManageAdressVC.h"
#import "MycommonTableView.h"
#import "DLAdressListCell.h"
#import "DLAdressManageCell.h"
#import "SUIUtils.h"
#import "DLEditAdressVC.h"
#import "DLAdressListViewModel.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "DLMakesureOrderVC.h"
#import "NSObject+setModelIndexPath.h"

const CGFloat bottomViewHeight = 40;
@interface DLManageAdressVC ()
@property (weak, nonatomic) IBOutlet MycommonTableView *addreeListTableView;
@property (nonatomic, strong)DLAdressListViewModel *adressListViewModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIButton *addAdressButton;

@end

@implementation DLManageAdressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self _requestAdressList];
}


#pragma mark ------------------------Init---------------------------------
-(void)_init {
    
    self.adressListViewModel.adresslistType = self.adresslistType;
    if (self.adressListViewModel.adresslistType == AddAdressType) {
        self.pageTitle = @"地址列表";
        self.bottomViewHeightConstraint.constant = 0;
        [self _initAddressListTableView];
        [self _initRightItem];
    }else if (self.adressListViewModel.adresslistType == ManageAdresslistType) {
        self.bottomViewHeightConstraint.constant = bottomViewHeight;
        [self _initAddressListManageTableView];
        self.pageTitle = @"管理地址";
    }
    self.addAdressButton.hidden = (self.adresslistType == ManageAdresslistType) ? NO : YES;
}

-(void)_initRightItem {
    
    UIBarButtonItem *rightItem = [UIBarButtonItem initWithTitle:@"管理" titleColor:[UIColor whiteColor] target:self action:@selector(manageAdress)];
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem barButtonItemSpace:-12],rightItem];
}


-(void)_initAddressListTableView {
    
    self.addreeListTableView.cellHeight = kAdressListCellHeight;
    [self.addreeListTableView configurecellNibName:@"DLAdressListCell" configurecellData:^(id cellModel, UITableViewCell *cell) {
        DLAdressListCell *adressListCell = (DLAdressListCell *)cell;
        DLAdressListModel *model = (DLAdressListModel *)cellModel;
        [adressListCell setAdressCellData:model];
        uBlock(model)
        WEAK_SELF
        adressListCell.selectDefaultAdressBlock = ^(UIButton *selectedButton) {
            [weak_self _setDefaultAdressWithAdressModel:block_model];
        };
        
    } clickCell:nil];
}


- (void)_initAddressListManageTableView {
    self.addreeListTableView.cellHeight = kManageAdressCellHeight;
    self.addreeListTableView.editingStyle = UITableViewCellEditingStyleDelete;
    [self.addreeListTableView configurecellNibName:@"DLAdressManageCell" configurecellData:^(id cellModel, UITableViewCell *cell) {
        DLAdressManageCell *adressListCell = (DLAdressManageCell *)cell;
        DLAdressListModel *model = (DLAdressListModel *)cellModel;
        [adressListCell setManageAdressCellData:model];
        uBlock(model)
        WEAK_SELF
        adressListCell.selectDefaultAdressBlock = ^(UIButton *selectedButton) {
            [weak_self _setDefaultAdressWithAdressModel:block_model];
        };
        
        adressListCell.editAdressBlock = ^{
            [weak_self _comToEditAddressPageWithType:EditAdressType addressModel:block_model];
        };
        
        adressListCell.deleteAdressBlock = ^{
            [weak_self _deleteAdress:block_model];
        };
    
    } clickCell:nil];
    WEAK_SELF
    self.addreeListTableView.editingCellBlock = ^(UITableView *tableView, UITableViewCellEditingStyle editingStyle,NSIndexPath *editingIndexPath, id cellModel){
        DLAdressListModel *model = (DLAdressListModel *)cellModel;
        [weak_self _requestDeleteAdressWithAdressModel:model];
    };
}



#pragma mark ------------------------Private-------------------------
- (void)_comtoManageAdressPage {
    DLManageAdressVC *manageAdressVC = [[DLManageAdressVC alloc] init];
    manageAdressVC.adresslistType = ManageAdresslistType;
    [self.navigationController pushViewController:manageAdressVC animated:YES];
}

- (void)_setDefaultAdressWithAdressModel:(DLAdressListModel *) model{
    if (model.isDefaultConsigneeAdress.integerValue) {
        [self _backToMakeSureVC];
    }else {
        [self _requestSetDefaultAdressWithAdressModel:model];
    }
}

- (void)_setFirstAdressAsDefaultWhenDefaultAdressDeleted {
    if (self.addreeListTableView.dataLogicModule.currentDataModelArr.count > 0) {
        DLAdressListModel *model = self.addreeListTableView.dataLogicModule.currentDataModelArr.firstObject;
        model.isDefaultConsigneeAdress = @(1);
        [self.addreeListTableView reloadRowsAtIndexPaths:@[model.modelAtIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)_deleteAdress:(DLAdressListModel *)model {
//    if (model.isDefaultConsigneeAdress) {
//        [self hideHubWithOnlyText:@"你不能删除默认地址"];
//    }else {
        [self showSimplyAlertWithTitle:@"提示" message:@"你确认要删去改收货地址吗" sureAction:^(UIAlertAction *action) {
            [self _requestDeleteAdressWithAdressModel:model];
        } cancelAction:nil];
//    }
}

- (void)_noAdressListAlert {
    if (self.addreeListTableView.dataLogicModule.currentDataModelArr.count > 0) {
        return;
    }
    [self showSimplyAlertWithTitle:@"提示" message:@"你还没有默认地址，请先去添加默认地址" sureAction:^(UIAlertAction *action) {
        [self _comToEditAddressPageWithType:AddAdressType addressModel:nil];
    } cancelAction:^(UIAlertAction *action) {
        [self _backToMakeSureVC];
    }];
}

- (void)_comToEditAddressPageWithType:(OperatorAddressType)operatorAddressType addressModel:(DLAdressListModel *)addressModel{
    DLEditAdressVC *editAddressVC = [[DLEditAdressVC alloc] init];
    editAddressVC.operatorAddressType = operatorAddressType;
    if (addressModel) {
        editAddressVC.shippingAddressId = addressModel.consigneAdressId;
    }
    [self.navigationController pushViewController:editAddressVC animated:YES];
}

-(void)_backToMakeSureVC {
    if (self.adresslistType ==AdressListType) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self _popToMakeSureVC];
    }
}

- (void)_popToMakeSureVC {
    if (self.navigationController.viewControllers.count) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isMemberOfClass:[DLMakesureOrderVC class]]) {
                DLMakesureOrderVC *makeSureOrderVC = (DLMakesureOrderVC *)controller;
                [self.navigationController popToViewController:makeSureOrderVC animated:YES];
                break;
            }
        }
    }
}

- (void)_deleteAdressAressModel:(DLAdressListModel *)adressListModel {
    [self.adressListViewModel deleteAdressAtRow:adressListModel.modelAtIndexPath.row];
    [self.addreeListTableView deleteRowsAtIndexPaths:@[adressListModel.modelAtIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.addreeListTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
    if (adressListModel.isDefaultConsigneeAdress.integerValue) {
        [self _setFirstAdressAsDefaultWhenDefaultAdressDeleted];
    }
}

#pragma mark ------------------------Api----------------------------------
- (void)_requestAdressList {
    @weakify(self);
    [[self.adressListViewModel requestAdresslist] subscribeNext:^(NSArray* resultArr) {
            @strongify(self);
            self.addreeListTableView.dataLogicModule.currentDataModelArr = [resultArr mutableCopy];
          self.adressListViewModel.adressList = self.addreeListTableView.dataLogicModule.currentDataModelArr;
            [self.addreeListTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
            [self.addreeListTableView reloadData];
    }];
}

- (void)_requestSetDefaultAdressWithAdressModel:(DLAdressListModel *)adressListModel {
    [self showLoadingHub];
    @weakify(self);
    [[self.adressListViewModel requestSetDefaultAdressWithAdressId:adressListModel.consigneAdressId] subscribeNext:^(NSDictionary* backDic) {
        @strongify(self);
        [self hideLoadingHub];
        [self _backToMakeSureVC];
    }];
}

- (void)_requestDeleteAdressWithAdressModel:(DLAdressListModel *)adressListModel {
    [self showLoadingHub];
    @weakify(self);
    [[self.adressListViewModel requesteleteAdressWithAdressId:adressListModel.consigneAdressId] subscribeNext:^(NSDictionary *backDic) {
        @strongify(self);
        [self hideLoadingHub];
        [self _deleteAdressAressModel:adressListModel];
        [self _noAdressListAlert];
    }];
}


#pragma mark ------------------------View Event---------------------------
- (IBAction)addAdressAction:(id)sender {
    [self _comToEditAddressPageWithType:AddAdressType addressModel:nil];
}

- (void)manageAdress {
    [self _comtoManageAdressPage];
}

- (void)goBack {
    if (self.adresslistType == ManageAdresslistType) {
        if (!self.addreeListTableView.dataLogicModule.currentDataModelArr.count) {
            [self _backToMakeSureVC];
            return;
        }
    }
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

- (void)dealloc
{
    NSLog(@"地址页面被销毁了");
}

@end

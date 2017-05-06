//
//  DLMakesureOrderVC.m
//  YilidiBuyer
//
//  Created by yld on 16/4/22.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLMakesureOrderVC.h"
#import "MycommonTableView.h"
#import "DLMakesureOrderGoodsModel.h"
#import "DLMakeSureOrderGoodsCell.h"
#import "ProjectRelativeConst.h"
#import "UIButton+Block.h"
#import "DLEditAdressVC.h"
#import "DLManageAdressVC.h"
#import "DLMakeSureOrderViewModel.h"
#import "DLCashierVC.h"
#import "DLOrderDetaiVC.h"
const CGFloat addressViewHeight = 53.0f;
const CGFloat addAdressFirstViewHeight = 40.0f;

@interface DLMakesureOrderVC ()
@property (weak, nonatomic) IBOutlet MycommonTableView *makeSureOrderTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *makeSureOrderTableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *invoiceInputViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *invoiceInputView;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *consigneePersonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *consigneePersonNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *consigneePersonAdressLabel;

@property (nonatomic, strong)UIView *addFirstAddressView;

@property (nonatomic, strong)DLMakeSureOrderViewModel *makeSureOrderViewModel;

//需不需要发票
@property (nonatomic, assign)BOOL needInvoice;
//有没有收获地址
@property (nonatomic, assign)BOOL hasDefaultAdress;

@end

@implementation DLMakesureOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self _requestTheDefaultAdress];
}


#pragma mark ------------------------Init---------------------------------
-(void)_init {
    
    self.pageTitle = @"确认订单";
    [self _initMakeSureOrderGoodsTableView];
    self.hasDefaultAdress = NO;
}


-(void)_initMakeSureOrderGoodsTableView {
    
    [self.makeSureOrderTableView configurecellNibName:@"DLMakeSureOrderGoodsCell" configurecellData:^(id cellModel, UITableViewCell *cell) {
        
    }];
    
    DLMakesureOrderGoodsModel *goodsModel1 = [[DLMakesureOrderGoodsModel alloc] init];
    goodsModel1.testStr = @"水果";
    
    DLMakesureOrderGoodsModel *goodsModel2 = [[DLMakesureOrderGoodsModel alloc] init];
    goodsModel2.testStr = @"葡萄";
    
    NSArray *goodsArr = @[goodsModel1,goodsModel2];
    self.makeSureOrderTableView.dataLogicModule.currentDataModelArr = [goodsArr mutableCopy];
    [self.makeSureOrderTableView reloadData];
    
    self.makeSureOrderTableViewHeightConstraint.constant = goodsArr.count * kMakeSureOrderGoodsCellHeight;
}

#pragma mark ------------------------Private-------------------------
- (void)_showCloseInvoiceView {
    
    [self.view endEditing:YES];
    self.invoiceInputView.hidden = !self.needInvoice;
    [UIView animateWithDuration:0.3 animations:^{
        self.invoiceInputViewHeightConstraint.constant = (self.needInvoice) ? 44 : 0;
        [self.view layoutIfNeeded];
    }];
}

- (void)_showHiddenTheFirstAddAdressView {
    self.addressViewHeightConstraint.constant = (self.hasDefaultAdress) ? addressViewHeight : addAdressFirstViewHeight;
    self.addFirstAddressView.hidden = self.hasDefaultAdress;

}

- (void)_comToAddAdressPage {
    DLEditAdressVC *editAdressVC = [[DLEditAdressVC alloc] init];
    editAdressVC.operatorAddressType = AddAdressType;
    [self.navigationController pushViewController:editAdressVC animated:YES];
}



- (void)_comToAdressListPage {
    DLManageAdressVC *addressListVC = [[DLManageAdressVC alloc] init];
    addressListVC.adresslistType = AdressListType;
    [self.navigationController pushViewController:addressListVC animated:YES];
}

- (void)_assignDefaultAdressDataWithAdressModel:(DLAdressListModel *)model {
    if (!model.consigneAdressId) {
        self.hasDefaultAdress = NO;
    }else {
        self.hasDefaultAdress = YES;
        self.consigneePersonAdressLabel.text = gFormat(@"%@%@",model.consigneePersonAdress,model.consigneePersonalDetailAdress);
        self.consigneePersonNameLabel.text = model.consigneePersonName;
        self.consigneePersonNumberLabel.text = model.consigneePersonPhoneNumber;
    }
}

#pragma mark ------------------------Api----------------------------------
- (void)_requestTheDefaultAdress {
    [self.makeSureOrderViewModel requestTheDefaultAdressbackBlock:^(id obj, NSError *error) {
        DLAdressListModel *model = (DLAdressListModel *)obj;
        [self _assignDefaultAdressDataWithAdressModel:model];
    }];
}

#pragma mark ------------------------View Event---------------------------

- (IBAction)orderDetaiClick:(id)sender {
    DLOrderDetaiVC *orderVC = [[DLOrderDetaiVC alloc]init];
    [self navigatePushViewController:orderVC animate:YES];
    
}


- (IBAction)submitOrderBtnClick:(id)sender {
    DLCashierVC *cashierVC= [[DLCashierVC alloc]init];
    [self navigatePushViewController:cashierVC animate:YES];
    
    
}

- (IBAction)selectInvoiceAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    self.needInvoice = button.selected;
    [self _showCloseInvoiceView];
}

- (IBAction)comtoAdressListAction:(id)sender {
    [self _comToAdressListPage];
}


#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

- (UIView *)addFirstAddressView {
    
    if (!_addFirstAddressView) {
        _addFirstAddressView = BoundNibView(@"AddTheFirstAddressView", UIView);
        [self.addressView addSubview:_addFirstAddressView];
        [_addFirstAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.addressView);
        }];
        UIButton *lookAdressButton = (UIButton *)[_addFirstAddressView viewWithTag:1];
        WEAK_SELF
        [lookAdressButton addActionHandler:^(NSInteger tag) {
            [weak_self _comToAddAdressPage];
        }];
    }
    return _addFirstAddressView;
}

- (DLMakeSureOrderViewModel *)makeSureOrderViewModel {
    
    if (!_makeSureOrderViewModel) {
        _makeSureOrderViewModel = [[DLMakeSureOrderViewModel alloc] init];
    }
    return _makeSureOrderViewModel;
}


- (void)setHasDefaultAdress:(BOOL)hasDefaultAdress {
    _hasDefaultAdress = hasDefaultAdress;
    [self _showHiddenTheFirstAddAdressView];

}





@end

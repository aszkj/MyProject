//
//  DLAccountBalanceVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/10/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLAccountBalanceVC.h"
#import "MycommonTableView.h"
#import "DLAccountBalanceCell.h"
#import "DLAccountDetailsModel.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
@interface DLAccountBalanceVC ()
@property (strong, nonatomic) IBOutlet MycommonTableView *accountBalanceTableView;
@property (nonatomic,strong)NSArray *array;
@end

@implementation DLAccountBalanceVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
#pragma mark ------------------------Init---------------------------------
- (void)_init{

    _balanceLabel.text =  _balanceStr;
    _balanceDetailLabel.text = _balanceDetailStr;
    if ([_balanceDetailStr isEqualToString:@"里米明细"]) {
        _accountBalance.text = @"0";
    }
    
//    NSArray *arr = @[@{@"money":@"12",
//                       @"title":@"适用范围：全场",@"date":@"有效期2016-10-01至2016-10-07"}];
//    
//    self.array = [DLAccountDetailsModel objectAccountDetailsModelArr:arr];
//    self.accountBalanceTableView.cellHeight = 55.0f;
//    WEAK_SELF
//    [self.accountBalanceTableView configurecellNibName:@"DLAccountBalanceCell" cellDataSource:self.array configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
//        DLAccountDetailsModel *model = (DLAccountDetailsModel*)cellModel;
//        DLAccountBalanceCell *accountCell = (DLAccountBalanceCell *)cell;
//        [accountCell setModel:model];
//        
//    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
//        
//    }];
//    
//    self.accountBalanceTableView.dataLogicModule.requestFromPage = 1;
    
//    [self.accountBalanceTableView headerRreshRequestBlock:^{
//        [weak_self _getWalletData];
//    }];
//    
//    [self.accountBalanceTableView footerRreshRequestBlock:^{
//        [weak_self _getWalletData];
//    }];

    
    
}
#pragma mark ------------------------Private-------------------------

#pragma mark ------------------------Api----------------------------------
- (void)_getWalletData{
    
    [self showLoadingHub];
    
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:@{@"":@1} subUrl:kUrl_AccountInfoUrl block:^(NSDictionary *resultDic, NSError *error) {
        [weak_self hideLoadingHub];
        
        if (isEmpty(resultDic[EntityKey])) {
            return ;
        }
        NSArray *resultArr = resultDic[EntityKey][@"list"];
        NSArray *transferedArr = [DLAccountDetailsModel objectAccountDetailsModelArr:resultArr];
        [weak_self.accountBalanceTableView configureTableAfterRequestData:transferedArr];
        [weak_self.accountBalanceTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
        
    }];
    
}


#pragma mark ------------------------Page Navigate---------------------------

#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------


@end

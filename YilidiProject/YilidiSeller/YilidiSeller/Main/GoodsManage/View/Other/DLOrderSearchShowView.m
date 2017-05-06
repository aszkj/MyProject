//
//  DLOrderSearchShowView.m
//  YilidiSeller
//
//  Created by yld on 16/6/30.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderSearchShowView.h"
#import "DLOrderListCell.h"
#import "NSObject+setModelIndexPath.h"
#import "GlobleConst.h"

@implementation DLOrderSearchShowView

#pragma mark -------------------Init Method----------------------
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self _initOrderSearchTableView];
    }
    return self;
}


-(void)_initOrderSearchTableView {
    
    self.searchOrderTableView = [[MycommonTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarAndStatusBarHeight)];
    [self addSubview:self.searchOrderTableView];
    self.searchOrderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    WEAK_SELF
    self.searchOrderTableView.cellHeight = orderListCellHeight;
    [self.searchOrderTableView configurecellNibName:@"DLOrderListCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        MerchantOrderListModel *orderListModel = (MerchantOrderListModel *)cellModel;
        DLOrderListCell  *orderlistCell = (DLOrderListCell *)cell;
        orderlistCell.orderListModel = orderListModel;
        
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        MerchantOrderListModel *orderListModel = (MerchantOrderListModel *)cellModel;
        emptyBlock(weak_self.comeToOrderDetailBlock,orderListModel.orderNo)
    }];
    
    [self.searchOrderTableView headerRreshRequestBlock:^{
        [weak_self requestOrderData];
    }];
    
    [self.searchOrderTableView footerRreshRequestBlock:^{
        [weak_self requestOrderData];
    }];
    
}

#pragma mark -------------------Api Method----------------------
- (void)requestOrderData {
    
    NSDictionary *paramDic = @{kRequestPageNumKey:@(self.searchOrderTableView.dataLogicModule.requestFromPage),
                               kRequestPageSizeKey:@(kRequestDefaultPageSize),
                               @"keyword":self.keyWords};
    [AFNHttpRequestOPManager postWithParameters:paramDic subUrl:kUrl_OrderList block:^(NSDictionary *resultDic, NSError *error) {
        NSArray *responseArr = resultDic[EntityKey][@"list"];
        NSArray *transferedArr = [MerchantOrderListModel objectArrWithOrderArr:responseArr] ;
        [self.searchOrderTableView configureTableAfterRequestData:transferedArr];
    }];
}

#pragma mark -------------------Setter/Getter Method----------------------
-(void)setKeyWords:(NSString *)keyWords {
    _keyWords = keyWords;
//    [self.searchOrderTableView configureTableAfterRequestData:[self _getTestData]];
    self.searchOrderTableView.dataLogicModule.requestFromPage = 1;
    [self.searchOrderTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
    [self requestOrderData];
}


@end

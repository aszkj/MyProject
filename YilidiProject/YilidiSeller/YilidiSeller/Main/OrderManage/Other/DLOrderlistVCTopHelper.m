//
//  DLOrderlistVCTopHelper.m
//  YilidiSeller
//
//  Created by yld on 16/3/28.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import "DLOrderlistVCTopHelper.h"
#import "NSObject+setModelIndexPath.h"
#import "MycommonTableView.h"
#import "DLOrderListCell.h"
#import "DLOrderListVC.h"
#import "GlobleConst.h"
#import "GoodsModel.h"
#import "DLOrderDetailVC.h"
#import <MJRefresh/MJRefresh.h>

@interface DLOrderlistVCTopHelper()

@end

@implementation DLOrderlistVCTopHelper

#pragma mark -------------------Init Method----------------------

-(id)initWithTableCount:(NSInteger)tableCount vcRootView:(UIView *)vcRootView {
    
    self = [super initWithTableCount:tableCount vcRootView:vcRootView];
    if (self) {
        self.isAutoFreshEachTimeWhenSwitchedTopbarIndex = YES;
        _orderTypeNumber = @(kOrderTypeNumberNomal);
    }
    return self;
}

-(void)loadTableInView:(UIView *)vcRootView tableCount:(NSInteger)tableCount {
    
    for (int i=0; i<tableCount; i++) {
        MycommonTableView *tableView = [[MycommonTableView alloc] initWithFrame:CGRectMake(0, 50+45, kScreenWidth,kScreenHeight-kNavBarAndStatusBarHeight-50-45) style:UITableViewStylePlain];
        [self _configureTableView:tableView];
        tableView.noDataLogicModule.nodataAlertTitle = @"暂无订单";

        //配置每张表
        [self setTableAttributeAtIndex:i forTableView:tableView];
        [vcRootView addSubview:tableView];
        [self.contentTableArr addObject:tableView];
    }
}

- (void)_configureTableView:(MycommonTableView *)orderTableView {
    WEAK_SELF
    orderTableView.cellHeight = orderListCellHeight;
    [orderTableView configurecellNibName:@"DLOrderListCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        MerchantOrderListModel *orderListModel = (MerchantOrderListModel *)cellModel;
        DLOrderListCell  *orderlistCell = (DLOrderListCell *)cell;
        orderlistCell.orderListModel = orderListModel;
        WEAK_SELF
        orderlistCell.enterOrderDetailBlock = ^{
            [weak_self _enterOrderDetailPageWithModel:orderListModel];
        };
        
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        MerchantOrderListModel *orderListModel = (MerchantOrderListModel *)cellModel;
        [weak_self _enterOrderDetailPageWithModel:orderListModel];
    }];
}


#pragma mark -------------------Api Method----------------------
-(void)requestData{
    NSNumber *requestTypeNumber = (NSNumber *)[self getRequestTypeWithTalbleTag:self.currentFreshTableView.tag];
    NSDictionary *paramDic = @{kRequestPageNumKey:@(self.currentFreshTableView.dataLogicModule.requestFromPage),
                               kRequestPageSizeKey:@(kRequestDefaultPageSize),
                               @"statusCode":requestTypeNumber,
                               @"orderType":self.orderTypeNumber};
    [AFNHttpRequestOPManager postWithParameters:paramDic subUrl:kUrl_OrderList block:^(NSDictionary *resultDic, NSError *error) {
            NSArray *responseArr = resultDic[EntityKey][@"list"];
            NSArray *transferedArr = [MerchantOrderListModel objectArrWithOrderArr:responseArr] ;
            [self configureTableAfterRequestData:transferedArr];
            [self.currentFreshTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
    }];
}

#pragma mark -------------------PageNavigate Method----------------------
- (void)_enterPayPageWithModel:(MerchantOrderListModel *)model {
    
}

- (void)_enterOrderDetailPageWithModel:(MerchantOrderListModel *)model {
    DLOrderDetailVC *orderDetailVC = [[DLOrderDetailVC alloc] init];
    orderDetailVC.orderNo = model.orderNo;
    [self.orderListVC navigatePushViewController:orderDetailVC animate:YES];
}

#pragma mark -------------------Private Method----------------------
-(NSNumber *)getRequestTypeWithTalbleTag:(NSInteger)tag {
    
    NSInteger requestTypeNumber;
    switch (tag) {
            
        case 0://待接单
            requestTypeNumber = 1;
            break;
        case 1://待发货
            requestTypeNumber = 2;
            break;
        case 2://待确认
            requestTypeNumber = 3;
            break;
        case 3://已完成
            requestTypeNumber = 4;
            break;
        case 4://已取消
            requestTypeNumber = 5;
            break;

        default:
            break;
    }
    return @(requestTypeNumber);
}

#pragma mark -------------------Setter/Getter----------------------
- (void)setOrderTypeNumber:(NSNumber *)orderTypeNumber {
    _orderTypeNumber = orderTypeNumber;
    self.currentFreshTableView.dataLogicModule.requestFromPage = 1;
    [self requestData];
}


@end

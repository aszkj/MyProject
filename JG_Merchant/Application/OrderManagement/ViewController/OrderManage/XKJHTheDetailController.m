//
//  XKJHTheDetailController.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHTheDetailController.h"
#import "XKJHOnlineOrderIncomeDetailCell.h"
#import "BaseTabbarTypeTableView.h"
#import "GroupOrderModel.h"
#import "OrderDetails.h"
#import "GoodsRefundModel.h"
#import "NodataShowView.h"
#import "XKJHOffLinePayDetailCell.h"


static NSString *XKJHOnlineOrderIncomeDetailCellID = @"XKJHOnlineOrderIncomeDetailCellID";

@interface XKJHTheDetailController ()<UITableViewDelegate,UITableViewDataSource>{

    VApiManager *_vapManager;
}

@property (weak, nonatomic) IBOutlet BaseTabbarTypeTableView *theDetailTableView;

@end

@implementation XKJHTheDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _initTable];
}
#pragma mark ----------------------- private Method -----------------------
- (void)_init {
    
    _vapManager = [[VApiManager alloc] init];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.barTintColor = status_color;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
    
    NSString *title = nil;
    if (self.theDetailType == OnlineServiceIncomeDetailType) {
      title = @"线上服务收入明细";
    }else if (self.theDetailType == OnlineServiceRefundType){
      title = @"在线服务退款记录";
    }else if (self.theDetailType == OfflineSwipeCardDetailType){
      title = @"线下刷卡明细";
    }

    [Util setNavTitleWithTitle:title ofVC:self];
}


- (void)_initTable {
    
    NSString *cellName = nil;
    NSString *cellID = nil;
    CGFloat  cellHeight = 0.0;
    if (self.theDetailType == OnlineServiceIncomeDetailType || self.theDetailType == OnlineServiceRefundType) {//线上服务收入明细,线上服务退款记录，
        cellName = @"XKJHOnlineOrderIncomeDetailCell";
        cellID = XKJHOnlineOrderIncomeDetailCellID;
        cellHeight = 172;
        [self.theDetailTableView registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:cellID];
    }else if (self.theDetailType == OfflineSwipeCardDetailType){//线上服务分润明细
        cellHeight = 153;
    }
    
    self.theDetailTableView.rowHeight = cellHeight;
    self.theDetailTableView.allowsSelection = NO;
    
    WEAK_SELF
    self.theDetailTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.theDetailTableView.dataLogicModule.requestFromPage = 1;
        if (!weak_self.theDetailTableView.dataLogicModule.isAutoHeaderFresh) {
            [weak_self.theDetailTableView.footer resetNoMoreData];
            [weak_self _requestData];
        }
    }];
    
    self.theDetailTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weak_self _requestData];
    }];
    
    //开始自动刷新
    [self _autoFresh];

}

#pragma mark - 开始自动刷新
-(void)_autoFresh {
    //开始自动刷新
    self.theDetailTableView.dataLogicModule.requestFromPage = 1;
    //标志自动刷新
    self.theDetailTableView.dataLogicModule.isAutoHeaderFresh = YES;
    [self.theDetailTableView.header beginRefreshing];
    [self _requestData];
}


- (void)_requestData {
    
    if (self.theDetailType == OnlineServiceIncomeDetailType) {//线上服务
        //线上线下明细
        [self _requestOnlineOfflineDetail];
    
    }else if (self.theDetailType == OfflineSwipeCardDetailType){//,线下刷卡明细
        [self _requestOfflineOfflineDetail];
    }
    else if (self.theDetailType == OnlineServiceRefundType){//线上服务退款
        //线上服务退款
        [self _requestOnlineServiceRefund];
    }
}

#pragma mark - 线上明细请求
-(void)_requestOnlineOfflineDetail {
    
    GroupOrderLineDetailsRequest *request = [[GroupOrderLineDetailsRequest alloc] init:GetToken];
    if (self.theDetailType == OnlineServiceIncomeDetailType) {//线上
        request.api_orderType = @1;
    }else {
        request.api_orderType = @2;
    }
    request.api_pageNum = @(self.theDetailTableView.dataLogicModule.requestFromPage);
    request.api_pageSize = @(self.theDetailTableView.dataLogicModule.requestPageSize);
    [_vapManager groupOrderLineDetails:request success:^(AFHTTPRequestOperation *operation, GroupOrderLineDetailsResponse *response) {
        
        NSLog(@"线上明细 %ld",response.orderDetailsList.count);
        
        NSArray *orderArr = [OrderDetailsModel JGObjectArrWihtKeyValuesArr:response.orderDetailsList];
        
        [self _configureTableAfterRequestData:orderArr];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
    }];
}

#pragma mark - 线下明细请求
-(void)_requestOfflineOfflineDetail {
    
    GroupOrderRevenueDetailsRequest *request = [[GroupOrderRevenueDetailsRequest alloc] init:GetToken];
    if (self.theDetailType == OnlineServiceIncomeDetailType) {//线上
        request.api_orderType = @1;
    }else {
        request.api_orderType = @2;
    }
    request.api_pageNum = @(self.theDetailTableView.dataLogicModule.requestFromPage);
    request.api_pageSize = @(self.theDetailTableView.dataLogicModule.requestPageSize);
    [_vapManager groupOrderRevenueDetails:request success:^(AFHTTPRequestOperation *operation, GroupOrderRevenueDetailsResponse *response) {
        
        NSLog(@"线上线下明细 %ld",response.orderDetailsList.count);
        
        NSArray *orderArr = [OrderDetailsModel JGObjectArrWihtKeyValuesArr:response.orderDetailsList];
        
        [self _configureTableAfterRequestData:orderArr];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
        
    }];
    
}


#pragma mark - 线上服务退款请求
- (void)_requestOnlineServiceRefund {
   
    GroupGoodsRefundListRequest *request = [[GroupGoodsRefundListRequest alloc] init:GetToken];
    request.api_pageNum = @(self.theDetailTableView.dataLogicModule.requestFromPage);
    request.api_pageSize = @(self.theDetailTableView.dataLogicModule.requestPageSize);
    
    [_vapManager groupGoodsRefundList:request success:^(AFHTTPRequestOperation *operation, GroupGoodsRefundListResponse *response) {
        
        DDLogVerbose(@"线上服务退款列表 %@",response);
        NSArray *refundBOs = [GoodsRefundModel JGObjectArrWihtKeyValuesArr:response.refundBOs];
        [self _configureTableAfterRequestData:refundBOs];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
    }];
    
}


#pragma mark - 数据请求下来之后，停止上下拉刷新，刷新表等
-(void)_configureTableAfterRequestData:(NSArray *)modelDatas {
    
    //处理停止上下拉刷新逻辑
    if (self.theDetailTableView.dataLogicModule.requestFromPage == 1 && !self.theDetailTableView.dataLogicModule.isAutoHeaderFresh) {//下拉非自动刷新
        [self.theDetailTableView.header endRefreshing];
    }else {//上拉加载更多
        if (modelDatas.count > 0) {
            [self.theDetailTableView.footer endRefreshing];
        }else {
            [self.theDetailTableView.footer noticeNoMoreData];
        }
    }
    
    //自动刷新
    if (self.theDetailTableView.dataLogicModule.isAutoHeaderFresh) {
        //标志完成自动刷新
        self.theDetailTableView.dataLogicModule.isAutoHeaderFresh = NO;
        [self.theDetailTableView.header endRefreshing];
    }


    if (modelDatas.count > 0) {
        //如果是加载更多，数据源拼在后面，下拉或自动刷新，替换数据源
        if (self.theDetailTableView.dataLogicModule.requestFromPage == 1) {
            self.theDetailTableView.dataLogicModule.currentDataModelArr = [NSMutableArray arrayWithArray:modelDatas];
        }else {
            [self.theDetailTableView.dataLogicModule.currentDataModelArr addObjectsFromArray:modelDatas];
        }
        [self.theDetailTableView reloadData];
        self.theDetailTableView.dataLogicModule.requestFromPage ++;
    }
}





#pragma mark --------------- table delegate & datasource -----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = self.theDetailTableView.dataLogicModule.currentDataModelArr.count;
    if (count == 0) {
        [NodataShowView showInContentView:self.theDetailTableView withReloadBlock:^{
        } requestResultType:NoDataType];
        self.theDetailTableView.backgroundColor = background_Color;
    }
    else
    {
        [NodataShowView hideInContentView:self.theDetailTableView];
    }
    return count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.theDetailType == OnlineServiceIncomeDetailType || self.theDetailType == OnlineServiceRefundType) {//线上服务收入,线上服务退款
        
        XKJHOnlineOrderIncomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:XKJHOnlineOrderIncomeDetailCellID forIndexPath:indexPath];
        if (self.theDetailType == OnlineServiceRefundType) {//退款
             cell.goodsRefundModel = self.theDetailTableView.dataLogicModule.currentDataModelArr[indexPath.row];
        }else {//收入
            cell.groupOrderModel = self.theDetailTableView.dataLogicModule.currentDataModelArr[indexPath.row];
        }
        return cell;
        
    } else if(self.theDetailType == OfflineSwipeCardDetailType) {
        
        static NSString *OffLinePayDetailCellIdentifier = @"OffLinePayDetailCellIdentifier";
        XKJHOffLinePayDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:OffLinePayDetailCellIdentifier];
        if (cell == nil) {
            cell = [[XKJHOffLinePayDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OffLinePayDetailCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setCellData:self.theDetailTableView.dataLogicModule.currentDataModelArr[indexPath.row]];
        return cell;
    }
//    else if (self.theDetailType == OnlineServiceBackProfitDetailType){//线上服务分润明细
//        
//    }
    return nil;
}


#pragma mark ----------------------- Action Method -----------------------
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}



@end

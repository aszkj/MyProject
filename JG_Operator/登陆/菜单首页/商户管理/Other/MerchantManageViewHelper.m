//
//  MerchantManageViewHelper.m
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/19.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "MerchantManageViewHelper.h"
#import "MerchantManageTableView.h"

@interface MerchantManageViewHelper(){
    
    NSMutableArray *_contentTableArr;
    VApiManager    *_vapManager;
}

//当前刷新的是那个表
@property (nonatomic, strong)MerchantManageTableView *currentFreshTableView;

@end


@implementation MerchantManageViewHelper

-(id)initWithTableCount:(NSInteger)tableCount vcRootView:(UIView *)vcRootView {
    
    self = [super init];
    if (self) {
        _vapManager = [[VApiManager alloc] init];
        //加载表
        [self _loadTableInView:vcRootView tableCount:tableCount];
    }
    return self;
}

#pragma mark - 加载表
-(void)_loadTableInView:(UIView *)vcRootView tableCount:(NSInteger)tableCount {
    //添加table
    _contentTableArr = [NSMutableArray arrayWithCapacity:tableCount];
    for (int i=0; i<tableCount; i++) {
        MerchantManageTableView *tableView = [[MerchantManageTableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight+kTableToTopbarGap, kScreenWidth, kScreenHeight-kTopBarHeight-kNavBarAndStatusBarHeight-kTableToTopbarGap) style:UITableViewStylePlain];
        tableView.allowsSelection = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [vcRootView addSubview:tableView];
        tableView.tag = i;
        tableView.hidden = i;
        WEAK_SELF
        //上下拉刷新
        tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //下拉刷新
            tableView.dataLogicModule.requestFromPage = 1;
            if (!tableView.dataLogicModule.isAutoHeaderFresh) {//如果不是自动刷新
                weak_self.currentFreshTableView = tableView;
                //重置nomoredata
                [weak_self.currentFreshTableView.footer resetNoMoreData];
                [weak_self _requestData];
            }
        }];
        
        tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weak_self.currentFreshTableView = tableView;
            //上拉刷新
            [weak_self _requestData];
        }];
        [_contentTableArr addObject:tableView];
    }
    
}

#pragma mark - 请求数据
-(void)_requestData {
    
//    //创建请求,赋值
//    GroupOrderOnlineListRequest *request = [[GroupOrderOnlineListRequest alloc] init:GetToken];
//    request.api_pageNum = @(self.currentFreshTableView.dataLogicModule.requestFromPage);
//    request.api_pageSize = @(self.currentFreshTableView.dataLogicModule.requestPageSize);
//    request.api_orderType = @2;
//    NSString *requestTypeStr = [self _getRequestTypeWithTalbleTag:_currentFreshTableView.tag];
//    //线下服务退款状态|1为未退款   2为已退款,不传为全部
//    if (requestTypeStr) {//为空的就不传，即请求全部的
//        request.api_localStatus = @(requestTypeStr.integerValue);
//    }
//    
//    //创建请求,赋值
//    [_vapManager groupOrderOnlineList:request success:^(AFHTTPRequestOperation *operation, GroupOrderOnlineListResponse *response) {
//        
//        DDLogVerbose(@"线下订单列表 -- %@",response.groupOrderList);
//        NSArray *orderArr = [GroupOrderModel JGObjectArrWihtKeyValuesArr:response.groupOrderList];
//        [self _configureTableAfterRequestData:orderArr];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        DDLogError(@"订单请求失败 -- %@",error);
//        
//    }];
    
}


#pragma mark - 根据点击那张表，返回请求类型
-(NSString *)_getRequestTypeWithTalbleTag:(NSInteger)tag {
    
    NSString *requestTypeStr = nil;
    switch (tag) {
        case 0:
            requestTypeStr = nil;
            break;
        case 1:
            requestTypeStr = @"2";
            break;
        default:
            break;
    }
    
    return requestTypeStr;
}


#pragma mark - 数据请求下来之后，停止上下拉刷新，刷新表等
-(void)_configureTableAfterRequestData:(NSArray *)modelDatas {
    //自动刷新
    if (self.currentFreshTableView.dataLogicModule.isAutoHeaderFresh) {
        //标志完成自动刷新
        self.currentFreshTableView.dataLogicModule.isFinishedHeaderAutoFresh = YES;
        self.currentFreshTableView.dataLogicModule.isAutoHeaderFresh = NO;
        [self.currentFreshTableView.header endRefreshing];
    }
    
    //处理停止上下拉刷新逻辑
    if (self.currentFreshTableView.dataLogicModule.requestFromPage == 1 && !self.currentFreshTableView.dataLogicModule.isAutoHeaderFresh) {//下拉非自动刷新
        [self.currentFreshTableView.header endRefreshing];
    }else {//上拉加载更多
        if (modelDatas.count > 0) {
            [self.currentFreshTableView.footer endRefreshing];
        }else {//没有更多数据
            [self.currentFreshTableView.footer noticeNoMoreData];
        }
    }
    
    if (modelDatas.count > 0) {
        
        //如果是加载更多，数据源拼在后面，下拉或自动刷新，替换数据源
        if (self.currentFreshTableView.dataLogicModule.requestFromPage == 1) {
            self.currentFreshTableView.dataLogicModule.currentDataModelArr = [NSMutableArray arrayWithArray:modelDatas];
        }else {
            [self.currentFreshTableView.dataLogicModule.currentDataModelArr addObjectsFromArray:modelDatas];
        }
        [self.currentFreshTableView reloadData];
        
    }
    self.currentFreshTableView.dataLogicModule.requestFromPage ++;
}


#pragma mark -  点击上面的topbar部分，做相应的处理，隐藏，自动刷新等
-(void)clickTopbarAtIndex:(NSInteger)clickedTopBarIndex {
    
    //找到之前显示的view，将其隐藏
    MerchantManageTableView *lastDisplayedTableView = (MerchantManageTableView *)[Util getDisplayedViewAtViewArrs:_contentTableArr];
    lastDisplayedTableView.hidden = YES;
    
    //显示选中的index对应的contentView
    MerchantManageTableView *willDisplayedTableView = (MerchantManageTableView *)[_contentTableArr objectAtIndex:clickedTopBarIndex];
    willDisplayedTableView.hidden = NO;
    
    //如果将要显示的表还没有自动刷新，那么第一次显示将自动刷新，以后不进行自动刷新
    if (!willDisplayedTableView.dataLogicModule.isFinishedHeaderAutoFresh) {
        willDisplayedTableView.dataLogicModule.isAutoHeaderFresh = YES;
        willDisplayedTableView.dataLogicModule.requestFromPage = 1;
        self.currentFreshTableView = willDisplayedTableView;
        [self.currentFreshTableView.header beginRefreshing];
        [self _requestData];
    }

}




@end

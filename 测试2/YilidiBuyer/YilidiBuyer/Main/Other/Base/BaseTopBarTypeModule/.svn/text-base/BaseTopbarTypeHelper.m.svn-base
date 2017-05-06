//
//  BaseTopbarTypeHelper.m
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/19.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "BaseTopbarTypeHelper.h"
#import "BaseTableView.h"
#import "BaseTableView+nodataShow.h"

@implementation BaseTopbarTypeHelper


-(id)initWithTableCount:(NSInteger)tableCount vcRootView:(UIView *)vcRootView {
    
    self = [super init];
    if (self) {
        _contentTableArr = [NSMutableArray arrayWithCapacity:tableCount];
        //不是每次切换topbar都刷新
        _isAutoFreshEachTimeWhenSwitchedTopbarIndex = NO;
        _baseView = vcRootView;
        //加载每张表
        [self loadTableInView:vcRootView tableCount:tableCount];
    }
    return self;
}


#pragma mark ----------------------------- 供子类调用 -----------------------------
#pragma mark - 设置第index个表的属性
-(void)setTableAttributeAtIndex:(NSInteger)index forTableView:(BaseTableView *)tableView
{
    tableView.allowsSelection = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView.backgroundColor = background_Color;
    tableView.tag = index;
    tableView.hidden = index;
    WEAK_SELF
    //上下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉刷新
        if (!tableView.dataLogicModule.isAutoHeaderFresh) {//如果不是自动刷新
            weak_self.currentFreshTableView = tableView;
            weak_self.currentFreshTableView.dataLogicModule.requestFromPage = 1;
            //重置nomoredata
            [weak_self.currentFreshTableView.mj_footer resetNoMoreData];
            [weak_self requestData];
        }
    }];
    
    tableView.mj_header = header;
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12.0f];
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.stateLabel.font = [UIFont systemFontOfSize:12.0f];

    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //上拉刷新
        [weak_self requestData];
    }];
    tableView.mj_footer = footer;
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    footer.stateLabel.font = [UIFont systemFontOfSize:12.0f];

}

#pragma mark - 数据请求下来之后，停止上下拉刷新，刷新表等
-(void)configureTableAfterRequestData:(NSArray *)modelDatas {
    //自动刷新
    if (self.currentFreshTableView.dataLogicModule.isAutoHeaderFresh) {
        //标志完成自动刷新
        self.currentFreshTableView.dataLogicModule.isFinishedHeaderAutoFresh = YES;
        self.currentFreshTableView.dataLogicModule.isAutoHeaderFresh = NO;
        [self.currentFreshTableView.mj_header endRefreshing];
    }
    
    //处理停止上下拉刷新逻辑
    if (self.currentFreshTableView.dataLogicModule.requestFromPage == 1 && !self.currentFreshTableView.dataLogicModule.isAutoHeaderFresh) {//下拉非自动刷新
        [self.currentFreshTableView.mj_header endRefreshing];
    }else {//上拉加载更多
        if (modelDatas.count > 0) {
            [self.currentFreshTableView.mj_footer endRefreshing];
        }else {//没有更多数据
            [self.currentFreshTableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
    
//    if (modelDatas.count > 0) {
    
        //如果是加载更多，数据源拼在后面，下拉或自动刷新，替换数据源
        if (self.currentFreshTableView.dataLogicModule.requestFromPage == 1) {
            self.currentFreshTableView.dataLogicModule.currentDataModelArr = [NSMutableArray arrayWithArray:modelDatas];
        }else {
            [self.currentFreshTableView.dataLogicModule.currentDataModelArr addObjectsFromArray:modelDatas];
        }
        [self.currentFreshTableView reloadData];
//    }
    self.currentFreshTableView.dataLogicModule.requestFromPage ++;
    
    if (modelDatas.count < self.currentFreshTableView.dataLogicModule.requestPageSize) {
        [self.currentFreshTableView.mj_footer endRefreshingWithNoMoreData];
        self.currentFreshTableView.mj_footer.hidden = YES;

    }else {
        [self.currentFreshTableView.mj_footer resetNoMoreData];
        self.currentFreshTableView.mj_footer.hidden = NO;
    }
    
    [self.currentFreshTableView nodataShowDeal];

}


#pragma mark ----------------------------- 供子类重写 -----------------------------
#pragma mark - 请求数据
-(void)requestData {
    
    
}


#pragma mark - 根据点击那张表，返回请求类型
-(NSString *)getRequestTypeWithTalbleTag:(NSInteger)tag {
    NSString *requestTypeStr = nil;
    
    return requestTypeStr;
}


#pragma mark - 加载每张表
-(void)loadTableInView:(UIView *)vcRootView tableCount:(NSInteger)tableCount {


    
}



#pragma mark -  点击上面的topbar部分，做相应的处理，隐藏，自动刷新等
-(void)clickTopbarAtIndex:(NSInteger)clickedTopBarIndex {
    
    //找到之前显示的view，将其隐藏
    BaseTableView *lastDisplayedTableView = (BaseTableView *)[Util getDisplayedViewAtViewArrs:_contentTableArr];
    lastDisplayedTableView.hidden = YES;
    
    //显示选中的index对应的contentView
    BaseTableView *willDisplayedTableView = (BaseTableView *)[_contentTableArr objectAtIndex:clickedTopBarIndex];
    willDisplayedTableView.hidden = NO;
    
    if (self.isAutoFreshEachTimeWhenSwitchedTopbarIndex) {//是否每次切换topindex就自动刷新
        [self _willDisplayTableViewAutoFresh:willDisplayedTableView];
    }else {
        //如果将要显示的表还没有自动刷新，那么第一次显示将自动刷新，以后不进行自动刷新
        if (!willDisplayedTableView.dataLogicModule.isFinishedHeaderAutoFresh) {
            [self _willDisplayTableViewAutoFresh:willDisplayedTableView];
        }
    }
    

}


-(void)_willDisplayTableViewAutoFresh:(BaseTableView *)willDisplayedTableView {
   
    willDisplayedTableView.dataLogicModule.isAutoHeaderFresh = YES;
    willDisplayedTableView.dataLogicModule.requestFromPage = 1;
    self.currentFreshTableView = willDisplayedTableView;
    [self.currentFreshTableView.mj_header beginRefreshing];
    [self requestData];

}



@end

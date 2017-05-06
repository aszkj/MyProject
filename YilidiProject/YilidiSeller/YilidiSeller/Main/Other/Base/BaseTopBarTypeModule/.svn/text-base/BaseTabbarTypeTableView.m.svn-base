//
//  BaseTabbarTypeTableView.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "BaseTabbarTypeTableView.h"
#import <MJRefresh/MJRefresh.h>

@interface BaseTabbarTypeTableView() {

    NSString *reuseCellID;//重用cellID
}

@end


@implementation BaseTabbarTypeTableView

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initDataLogicModule];

    }
    return self;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initDataLogicModule];
    }
    return self;
}

-(void)_initDataLogicModule {
    TopbarTypeTableDataLogicModule *module = [[TopbarTypeTableDataLogicModule alloc] init];
    _dataLogicModule = module;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style dataLogicModule:(TopbarTypeTableDataLogicModule *)dataLogicModule
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _dataLogicModule = dataLogicModule;
    }
    return self;
}


-(void)_init{
    
    self.delegate = self;
    self.dataSource = self;
}

-(void)headerAutoRreshRequestBlock:(RequestDataBlock)headerAutoRequestBlock {
  
    self.dataLogicModule.isAutoHeaderFresh = YES;
    self.dataLogicModule.requestFromPage = 1;
    [self.mj_header beginRefreshing];
    if (headerAutoRequestBlock) {
        headerAutoRequestBlock();
    }
}

-(void)headerRreshRequestBlock:(RequestDataBlock)headerRequestBlock {
    WEAK_SELF
    //上下拉刷新
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉刷新
        if (!weak_self.dataLogicModule.isAutoHeaderFresh) {//如果不是自动刷新
            weak_self.dataLogicModule.requestFromPage = 1;
            //重置nomoredata
            [weak_self.mj_footer resetNoMoreData];
            if (headerRequestBlock) {
                headerRequestBlock();
            }
        }
    }];

}

-(void)footerRreshRequestBlock:(RequestDataBlock)footerRequestBlock {

      self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //上拉刷新
        if (footerRequestBlock) {
            footerRequestBlock();
        }
    }];
}

-(void)configureTableAfterRequestData:(NSArray *)modelDatas {
    //自动刷新
    if (self.dataLogicModule.isAutoHeaderFresh) {
        //标志完成自动刷新
        self.dataLogicModule.isFinishedHeaderAutoFresh = YES;
        self.dataLogicModule.isAutoHeaderFresh = NO;
        [self.mj_header endRefreshing];
    }
    
    //处理停止上下拉刷新逻辑
    if (self.dataLogicModule.requestFromPage == 1 && !self.dataLogicModule.isAutoHeaderFresh) {//下拉非自动刷新
        [self.mj_header endRefreshing];
    }else {//上拉加载更多
        if (modelDatas.count > 0) {
            [self.mj_footer endRefreshing];
        }else {//没有更多数据
            [self.mj_footer endRefreshingWithNoMoreData];
        }
    }
    
//    if (modelDatas.count > 0) {
        //如果是加载更多，数据源拼在后面，下拉或自动刷新，替换数据源
        if (self.dataLogicModule.requestFromPage == 1) {
            self.dataLogicModule.currentDataModelArr = [NSMutableArray arrayWithArray:modelDatas];
        }else {
            if (modelDatas.count > 0) {
                [self.dataLogicModule.currentDataModelArr addObjectsFromArray:modelDatas];
            }
        }
        [self reloadData];
//    }
    if (self.dataLogicModule.isRequestByPage) {
        self.dataLogicModule.requestFromPage ++;
    }
}







@end

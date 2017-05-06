//
//  BaseCollectionView.m
//  YilidiBuyer
//
//  Created by yld on 16/5/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseCollectionView.h"
#import "BaseCollectionView+nodata.h"

@implementation BaseCollectionView

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initDataLogicModule];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self _initDataLogicModule];
    }
    return self;
}

-(void)_initDataLogicModule {
    self.dataLogicModule = [[TopbarTypeTableDataLogicModule alloc] init];
    self.noDataLogicModule = [[NodataLogicModule alloc] init];
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
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
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
    self.mj_header = header;
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12.0f];
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.stateLabel.font = [UIFont systemFontOfSize:12.0f];
}

-(void)footerRreshRequestBlock:(RequestDataBlock)footerRequestBlock {
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //上拉刷新
        if (footerRequestBlock) {
            footerRequestBlock();
        }
    }];
    self.mj_footer = footer;
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    footer.stateLabel.font = [UIFont systemFontOfSize:12.0f];
}

-(void)configureCollectionAfterRequestPagingData:(NSArray *)pageDatas {
    
    if (self.dataLogicModule.totalPage > 0) {
        if (self.dataLogicModule.requestFromPage > self.dataLogicModule.totalPage) {
            [self.mj_footer endRefreshingWithNoMoreData];
            self.mj_footer.hidden = YES;
            return;
        }else {
            self.mj_footer.hidden = NO;
            [self.mj_footer resetNoMoreData];
        }
    }
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
        [self.mj_footer endRefreshing];
    }
    
    //如果是加载更多，数据源拼在后面，下拉或自动刷新，替换数据源
    if (self.dataLogicModule.requestFromPage == 1) {
        self.dataLogicModule.currentDataModelArr = [NSMutableArray arrayWithArray:pageDatas];
    }else {
        [self.dataLogicModule.currentDataModelArr addObjectsFromArray:pageDatas];

    }
    
    [self reloadData];
    
    if (self.dataLogicModule.isRequestByPage) {
        self.dataLogicModule.requestFromPage ++;
    }
    
    if (pageDatas.count < self.dataLogicModule.requestPageSize) {
        [self.mj_footer endRefreshingWithNoMoreData];
        self.mj_footer.hidden = YES;
    }else {
        self.mj_footer.hidden = NO;
        [self.mj_footer resetNoMoreData];
    }
    if (self.noDataLogicModule.needDealNodataCondition) {
        [self nodataShowDeal];
    }
}

-(void)configureCollectionAfterRequestTotalData:(NSArray *)tatalDatas {
    self.dataLogicModule.currentDataModelArr = [tatalDatas mutableCopy];
    [self reloadData];
    if (self.noDataLogicModule.needDealNodataCondition) {
        [self nodataShowDeal];
    }
}



@end

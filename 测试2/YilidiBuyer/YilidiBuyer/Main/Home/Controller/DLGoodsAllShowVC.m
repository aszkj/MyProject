//
//  DLGoodsAllShowVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/9.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGoodsAllShowVC.h"
#import "MycommonTableView.h"
#import "MyCommonCollectionView.h"
#import "DLGoodsAllshowCell.h"
#import "DLHomeGoodsModel.h"
#import "DLFreshFruitCollectionViewCell.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "CellCalculateModel.h"
#import "DLCommunityGoodsCollectionViewCell.h"
#import "MyCommonCollectionView.h"
#import "GlobleConst.h"

@interface DLGoodsAllShowVC ()
@property (weak, nonatomic) IBOutlet MyCommonCollectionView *allGoodsCollectionView;
@property (weak, nonatomic) IBOutlet MycommonTableView *goodsAllTabbleView;

@property (nonatomic, assign)NSInteger goodsSortRuleNumber;

@property (nonatomic, assign)NSInteger requestFromPage;

@property (nonatomic, copy)NSString *keyWords;

@end

@implementation DLGoodsAllShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _requestGoodsData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------------Init---------------------------------
-(void)_init {
    [self _initInfo];
    [self _initgoodsAllTableView];
    [self _initGoodsCollectionView];
}

-(void)_initInfo {
    
    self.goodsSortRuleNumber = -1;
    self.requestFromPage = 1;
}



-(void)_initgoodsAllTableView {
    
    self.goodsAllTabbleView.cellHeight = GoodsAllshowHeight;    
    [self.goodsAllTabbleView configurecellNibName:@"DLGoodsAllshowCell" cellDataSource:nil configurecellData:^(id cellModel, UITableViewCell *cell) {
        DLGoodsAllshowCell *allshowCell = (DLGoodsAllshowCell *)cell;
        DLHomeGoodsModel *model =  (DLHomeGoodsModel *)cellModel;
        
        [allshowCell setGoodsAllshowCell:model];
        
        
    } clickCell:^(id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
    }];
    WEAK_SELF
    [self.goodsAllTabbleView headerRreshRequestBlock:^{
        [weak_self _requestGoodsData];
    }];
    
    [self.goodsAllTabbleView footerRreshRequestBlock:^{
        [weak_self _requestGoodsData];
    }];
}


- (void)_initGoodsCollectionView
{
    
    WEAK_SELF
    
    [self.allGoodsCollectionView headerRreshRequestBlock:^{
        [weak_self _requestGoodsData];
    }];
    
    [self.allGoodsCollectionView footerRreshRequestBlock:^{
        [weak_self _requestGoodsData];
    }];
    
    [self.allGoodsCollectionView configureCollectionCellNibName:@"DLCommunityGoodsCollectionViewCell" cellDataSource:nil configureCollectionCellData:^(id collectionModel, UICollectionViewCell *collectionCell) {
        
        DLCommunityGoodsCollectionViewCell *goodsCell = (DLCommunityGoodsCollectionViewCell *)collectionCell;
        DLHomeGoodsModel *model = (DLHomeGoodsModel *)collectionModel;
        [goodsCell setCellModel:model];
        goodsCell.imgWidthConstraint.constant = weak_self.allGoodsCollectionView.cellCalculateModel.cellImgWidth;
         goodsCell.imgHeightConstraint.constant = weak_self.allGoodsCollectionView.cellCalculateModel.cellImgHeight;
        
    } clickCell:^(id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        
    }];
    self.allGoodsCollectionView.commonFlowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.allGoodsCollectionView.commonFlowLayout.minimumInteritemSpacing = 10;
    self.allGoodsCollectionView.commonFlowLayout.minimumLineSpacing = 10;
    CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:2 horizontalDisplayAreaWidth:kScreenWidth cellImgToSideEdge:8 cellImgWidthToHeightScale:0.95 cellOterPartHeightBesideImg:70 edgeBetweenCellAndCell:10 edgeBetweenCellAndSide:10];
    CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
    self.allGoodsCollectionView.cellCalculateModel = cellCaculateModel;
    self.allGoodsCollectionView.commonFlowLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth, cellCaculateModel.cellHeight);
    
}


#pragma mark ------------------------Private-------------------------

#pragma mark ------------------------Api----------------------------------
- (void)_requestGoodsData {
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:0];
    [requestParam setObject:@(self.goodsSortRuleNumber) forKey:@"sortRule"];
    [requestParam setObject:@(self.goodsTypeNumber) forKey:@"goodsType"];
    [requestParam  setObject:@(self.requestFromPage) forKey:kRequestPageNumKey];
    [requestParam  setObject:@(kRequestDefaultPageSize) forKey:kRequestPageSizeKey];
    if (!isEmpty(self.keyWords)) {
        [requestParam setObject:self.keyWords forKey:@"keyword"];
    }
    
    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_GoodsSearch parameters:requestParam block:^(id result, NSError *error) {
        NSArray *resultArr = result[@"data"][@"items"];
        NSArray *transferedArr = [DLHomeGoodsModel objectGoodsModelWithGoodsArr:resultArr];
//        [self.goodsAllTabbleView configureTableAfterRequestData:transferedArr];
        self.allGoodsCollectionView.datas = transferedArr;
        [self.allGoodsCollectionView reloadData];
    }];
}

#pragma mark ------------------------Page Navigate---------------------------

#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

- (void)dealloc
{
    
}

@end

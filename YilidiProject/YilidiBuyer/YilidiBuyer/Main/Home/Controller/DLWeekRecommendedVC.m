//
//  DLWeekRecommendedVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/7/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLWeekRecommendedVC.h"
#import "DLGoodsAllshowCell.h"
#import "DLHomeGoodsModel.h"
#import "GlobleConst.h"
#import "GoodsModel.h"
#import "ProjectRelativeKey.h"
#import "DLHomeGoodsVerticalCell.h"
#import "CommunityDataManager.h"
#import "ShopCartView.h"
#import "ProjectRelativeDefineNotification.h"
#import "DLAnimatePerformer.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "DLShopCarVC.h"
#import "UIViewController+unLoginHandle.h"
#import "DLGoodsdetailVC.h"
#import "DLWeekHeadView.h"
#import "DLAnimatePerformer+business.h"
@interface DLWeekRecommendedVC ()
@property (nonatomic, assign)NSInteger searchedGoodsCount;
@property (weak, nonatomic) IBOutlet ShopCartView *shopCartView;

@end

@implementation DLWeekRecommendedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"每周推荐";
    
    [self _init];
    [self showHubWithDefaultStatus];

    
}



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
}


#pragma mark ------------------------Init---------------------------------
-(void)_init {
    //    [self _initGoodsSearchTableView];
    [self _initGoodsSearchResultCollectionView];
    [self requestGoodsData];
}

-(void)_initGoodsSearchResultCollectionView {
    
    WEAK_SELF
    self.weekRecommendedView.noDataLogicModule.nodataAlertTitle = @"抱歉，没有相关商品";
    [self.weekRecommendedView configureCollectionCellNibName:@"DLHomeGoodsVerticalCell" configureCollectionCellData:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell,NSIndexPath *clickIndexPath) {
        GoodsModel *model = (GoodsModel *)collectionModel;
        DLHomeGoodsVerticalCell *searchGoodsCell = (DLHomeGoodsVerticalCell *)collectionCell;
        [searchGoodsCell setCellModel:model];
        MyCommonCollectionView *collectionview = (MyCommonCollectionView *)collectionView;
        searchGoodsCell.imgHeightConstraint.constant = collectionview.cellCalculateModel.cellImgHeight;
        searchGoodsCell.imgWidthConstraint.constant = collectionview.cellCalculateModel.cellImgWidth;
        WEAK_OBJ(searchGoodsCell)
        searchGoodsCell.goodsCountChangeView.countChangedBlk = ^(NSInteger nowCount,BOOL isAdd){
            [DLAnimatePerformer excuteAddShopCartAnimationUsingAnimateImageView:weak_searchGoodsCell.goodsImgView contentListView:weak_self.weekRecommendedView shopCartViewPoint:ListPageShopCartIconPoint isAddShopCart:isAdd];

        };
        
        
    } clickCell:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        GoodsModel *model = (GoodsModel *)collectionModel;
        [weak_self _enterGoodsDetailWithGoodsId:model.goodsId];
    }];
    
    self.weekRecommendedView.backgroundColor = UIColorFromRGB(0xd33b42);
    
    self.weekRecommendedView.commonFlowLayout.minimumInteritemSpacing = 5;
    self.weekRecommendedView.commonFlowLayout.minimumLineSpacing = 5;
    
    self.weekRecommendedView.commonFlowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:2 horizontalDisplayAreaWidth:kScreenWidth cellImgToSideEdge:8 cellImgWidthToHeightScale:0.9 cellOterPartHeightBesideImg:97 edgeBetweenCellAndCell:5 edgeBetweenCellAndSide:5];
    CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
    self.weekRecommendedView.cellCalculateModel = cellCaculateModel;
    self.weekRecommendedView.commonFlowLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth, cellCaculateModel.cellHeight);
  
    self.weekRecommendedView.commonFlowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, kScreenWidth/1.8);
    [self.weekRecommendedView configureFirstSectioHeaderNibName:@"DLWeekHeadView" configureFirstSectionHeaderBlock:^(UICollectionView *collectionView, id collectionModel, UICollectionReusableView *firstSectionHeaderView) {
        
    }];
    
}

#pragma mark ------------------------Private-------------------------
#pragma mark ------------------------Api----------------------------------
- (void)requestGoodsData {
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:0];
    [requestParam setObject:@3 forKey:@"zoneType"];
    [requestParam setObject:kCommunityStoreId forKey:KStoreIdKey];
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GetPerfectureGoods block:^(NSDictionary *resultDic, NSError *error) {
        [weak_self dissmiss];
        
        NSArray *resultArr = resultDic[EntityKey];
        NSArray *transferedArr = [GoodsModel objectGoodsModelWithGoodsArr:resultArr];
        [weak_self.weekRecommendedView configureCollectionAfterRequestPagingData:transferedArr];
        
    }];
}


#pragma mark ------------------------Page Navigate---------------------------
- (void)_enterGoodsDetailWithGoodsId:(NSString *)goodsId {
    DLGoodsdetailVC *goodsDetailVC = [[DLGoodsdetailVC alloc] init];
    goodsDetailVC.goodsId = goodsId;
    [self navigatePushViewController:goodsDetailVC animate:YES];
}
#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark -------------------Setter/Getter Method----------------------

@end

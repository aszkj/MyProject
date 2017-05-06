//
//  DLShowFloorGoodsVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/9/6.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLShowFloorGoodsVC.h"
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
#import "DLAnimatePerformer+business.h"
@interface DLShowFloorGoodsVC ()
@property (strong, nonatomic) IBOutlet ShopCartView *shopCartView;

@end

@implementation DLShowFloorGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self _init];
    [self showHubWithDefaultStatus];
    
    self.navigationController.view.backgroundColor = [UIColor whiteColor];

}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
}


#pragma mark ------------------------Init---------------------------------
-(void)_init {
    //    [self _initGoodsSearchTableView];
    if (!isEmpty(self.infoDic)) {
        self.floorId = self.infoDic[kLinkDataKeyFloorGoods];
        self.pageTitle = self.infoDic[@"floorName"];
        [self requestGoodsData];
    }
    [self _initGoodsSearchResultCollectionView];
    
}

-(void)_initGoodsSearchResultCollectionView {
    
    WEAK_SELF
    self.floorCollectionView.noDataLogicModule.nodataAlertTitle = @"抱歉，没有相关商品";
    [self.floorCollectionView configureCollectionCellNibName:@"DLHomeGoodsVerticalCell" configureCollectionCellData:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell,NSIndexPath *clickIndexPath) {
        GoodsModel *model = (GoodsModel *)collectionModel;
        DLHomeGoodsVerticalCell *searchGoodsCell = (DLHomeGoodsVerticalCell *)collectionCell;
        [searchGoodsCell setCellModel:model];
        MyCommonCollectionView *collectionview = (MyCommonCollectionView *)collectionView;
        searchGoodsCell.imgHeightConstraint.constant = collectionview.cellCalculateModel.cellImgHeight;
        searchGoodsCell.imgWidthConstraint.constant = collectionview.cellCalculateModel.cellImgWidth;
        WEAK_OBJ(searchGoodsCell)
        searchGoodsCell.goodsCountChangeView.countChangedBlk = ^(NSInteger nowCount,BOOL isAdd){
            [DLAnimatePerformer excuteAddShopCartAnimationUsingAnimateImageView:weak_searchGoodsCell.goodsImgView contentListView:weak_self.floorCollectionView shopCartViewPoint:ListPageShopCartIconPoint isAddShopCart:isAdd];

        };
        
        
    } clickCell:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        GoodsModel *model = (GoodsModel *)collectionModel;
        [weak_self _enterGoodsDetailWithGoodsId:model.goodsId];
    }];
    
    self.floorCollectionView.commonFlowLayout.minimumInteritemSpacing = 5;
    self.floorCollectionView.commonFlowLayout.minimumLineSpacing = 5;
    
    self.floorCollectionView.commonFlowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:2 horizontalDisplayAreaWidth:kScreenWidth cellImgToSideEdge:8 cellImgWidthToHeightScale:0.9 cellOterPartHeightBesideImg:97 edgeBetweenCellAndCell:5 edgeBetweenCellAndSide:5];
    CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
    self.floorCollectionView.cellCalculateModel = cellCaculateModel;
    self.floorCollectionView.commonFlowLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth, cellCaculateModel.cellHeight);
    
       
}

#pragma mark ------------------------Private-------------------------
#pragma mark ------------------------Api----------------------------------
- (void)requestGoodsData {
    
    
    NSDictionary  *requestParam = @{@"floorId":self.floorId,KStoreIdKey:kCommunityStoreId};

    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GetFloorProducts block:^(NSDictionary *resultDic, NSError *error) {
        [weak_self dissmiss];
        
        NSArray *resultArr = resultDic[EntityKey];
        NSArray *transferedArr = [GoodsModel objectGoodsModelWithGoodsArr:resultArr];
        [weak_self.floorCollectionView configureCollectionAfterRequestPagingData:transferedArr];
        
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

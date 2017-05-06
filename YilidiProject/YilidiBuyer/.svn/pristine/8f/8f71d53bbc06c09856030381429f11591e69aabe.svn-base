//
//  DLMyWalletVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGoodsThirdLevelClassChildController.h"
#import "GlobleConst.h"
#import "DLGoodsThirdLevelClassChildController.h"
#import "MyCommonCollectionView.h"
#import "ProjectRelativeKey.h"
#import "DLHomeGoodsVerticalCell.h"
#import "ProjectRelativeDefineNotification.h"
#import "DLAnimatePerformer.h"
#import "DLGoodsdetailVC.h"
#import "DLAnimatePerformer+business.h"

@interface DLGoodsThirdLevelClassChildController ()
@property (weak, nonatomic) IBOutlet MyCommonCollectionView *goodsCollectionView;




@end

@implementation DLGoodsThirdLevelClassChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initGoodsCollectionView];
    
    [self showLoadingHub];
    
    [self _requestGoodsData];
    
    
}

-(void)_init {

}



-(void)_initGoodsCollectionView {
    
    WEAK_SELF
    self.goodsCollectionView.noDataLogicModule.nodataAlertTitle = @"没有相关商品";
    [self.goodsCollectionView configureCollectionCellNibName:@"DLHomeGoodsVerticalCell" configureCollectionCellData:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell,NSIndexPath *clickIndexPath) {
        GoodsModel *model = (GoodsModel *)collectionModel;
        DLHomeGoodsVerticalCell *goodsCell = (DLHomeGoodsVerticalCell *)collectionCell;
        [goodsCell setCellModel:model];
        MyCommonCollectionView *collectionview = (MyCommonCollectionView *)collectionView;
        goodsCell.imgHeightConstraint.constant = collectionview.cellCalculateModel.cellImgHeight;
        goodsCell.imgWidthConstraint.constant = collectionview.cellCalculateModel.cellImgWidth;
        WEAK_OBJ(goodsCell)
        goodsCell.goodsCountChangeView.countChangedBlk = ^(NSInteger nowCount,BOOL isAdd){
            [DLAnimatePerformer excuteAddShopCartAnimationUsingAnimateImageView:weak_goodsCell.goodsImgView contentListView:weak_self.goodsCollectionView shopCartViewPoint:ListPageShopCartIconPoint isAddShopCart:isAdd];

        };
        
        
    } clickCell:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        GoodsModel *model = (GoodsModel *)collectionModel;
        [weak_self _enterGoodsDetailPageWithGoodsId:model.goodsId];
    }];
    
    self.goodsCollectionView.commonFlowLayout.minimumInteritemSpacing = 5;
    self.goodsCollectionView.commonFlowLayout.minimumLineSpacing = 5;
    
    self.goodsCollectionView.commonFlowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:2 horizontalDisplayAreaWidth:kScreenWidth cellImgToSideEdge:8 cellImgWidthToHeightScale:1.0 cellOterPartHeightBesideImg:97 edgeBetweenCellAndCell:5 edgeBetweenCellAndSide:5];
    CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
    self.goodsCollectionView.cellCalculateModel = cellCaculateModel;
    self.goodsCollectionView.commonFlowLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth, cellCaculateModel.cellHeight);
    [self.goodsCollectionView headerRreshRequestBlock:^{
        [weak_self _requestGoodsData];
    }];
    
    [self.goodsCollectionView footerRreshRequestBlock:^{
        [weak_self _requestGoodsData];
    }];
}

- (void)_enterGoodsDetailPageWithGoodsId:(NSString *)goodsId {
    DLGoodsdetailVC *goodsDetailVC = [[DLGoodsdetailVC alloc] init];
    goodsDetailVC.goodsId = goodsId;
    [self navigatePushViewController:goodsDetailVC animate:YES];
}


- (void)_requestGoodsData {
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:0];
    [requestParam setObject:@(self.goodsCollectionView.dataLogicModule.requestFromPage) forKey:kRequestPageNumKey];
    [requestParam setObject:@(kRequestDefaultPageSize) forKey:kRequestPageSizeKey];
    [requestParam setObject:self.classCode forKey:@"classCode"];
    [requestParam setObject:kCommunityStoreId forKey:KStoreIdKey];
    DDLogVerbose(@"正在获取根据商品类型获取商品列表信息...");
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GoodsSearch block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        NSArray *resultArr = resultDic[EntityKey][@"list"];
        NSArray *transferedArr = [GoodsModel objectGoodsModelWithGoodsArr:resultArr];
        [self.goodsCollectionView configureCollectionAfterRequestPagingData:transferedArr];
    }];
}



#pragma mark -------------------Setter/Getter Method----------------------




@end

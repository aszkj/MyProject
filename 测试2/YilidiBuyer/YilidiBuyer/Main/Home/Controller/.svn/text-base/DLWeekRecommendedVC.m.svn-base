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
@interface DLWeekRecommendedVC ()
@property (nonatomic, assign)NSInteger searchedGoodsCount;
@property (weak, nonatomic) IBOutlet ShopCartView *shopCartView;
@property (nonatomic, strong)DLAnimatePerformer *animatePerformer;

@end

@implementation DLWeekRecommendedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"每周推荐";
    
    [self _init];
    [self showHubWithDefaultStatus];
    [self _initShopCartView];
    
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
}



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self.shopCartView initShopCartGoods];
}


#pragma mark ------------------------Init---------------------------------
-(void)_init {
    //    [self _initGoodsSearchTableView];
    [self _initGoodsSearchResultCollectionView];
    [self requestGoodsData];
}

- (void)_initShopCartView {
    
    WEAK_SELF
    self.shopCartView.gotoShopCartPageBlock = ^{
        [weak_self _enterShopCartPage];
    };
}

-(void)_initGoodsSearchResultCollectionView {
    
    WEAK_SELF
    self.weekRecommendedView.nodataAlertTitle = @"抱歉，没有相关商品";
    [self.weekRecommendedView configureCollectionCellNibName:@"DLHomeGoodsVerticalCell" configureCollectionCellData:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell) {
        GoodsModel *model = (GoodsModel *)collectionModel;
        DLHomeGoodsVerticalCell *searchGoodsCell = (DLHomeGoodsVerticalCell *)collectionCell;
        [searchGoodsCell setCellModel:model];
        MyCommonCollectionView *collectionview = (MyCommonCollectionView *)collectionView;
        searchGoodsCell.imgHeightConstraint.constant = collectionview.cellCalculateModel.cellImgHeight;
        searchGoodsCell.imgWidthConstraint.constant = collectionview.cellCalculateModel.cellImgWidth;
        WEAK_OBJ(searchGoodsCell)
        searchGoodsCell.goodsCountChangeView.countChangedBlk = ^(NSInteger nowCount,BOOL isAdd){
            [weak_self _performAddShopCartAnimationUsingImgView:weak_searchGoodsCell.goodsImgView isAdd:isAdd];
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
- (void)_performAddShopCartAnimationUsingImgView:(UIImageView *)animationImageView isAdd:(BOOL)isAdd{
    if (!isAdd) {
        [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(isAdd)];
        return;
    }
    self.weekRecommendedView.scrollEnabled = NO;
    WEAK_SELF
    [self.animatePerformer performProjectDefaultAddShopCartAnimationForAnimationGoodsImgView:animationImageView animateEndPoint: CGPointMake(kScreenWidth-34-50/2, kScreenHeight-58 - 50/2) animateDidEndBlock:^{
        weak_self.weekRecommendedView.scrollEnabled = YES;
        [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(isAdd)];
    }];
}

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
        [weak_self.weekRecommendedView configureTableAfterRequestData:transferedArr];
        
    }];
}


#pragma mark ------------------------Page Navigate---------------------------
- (void)_enterShopCartPage {
    if (![self unloginHandle]) {
        return;
    }
    DLShopCarVC *shopCartVC = [[DLShopCarVC alloc] init];
    [self navigatePushViewController:shopCartVC animate:YES];
}

- (void)_enterGoodsDetailWithGoodsId:(NSString *)goodsId {
    DLGoodsdetailVC *goodsDetailVC = [[DLGoodsdetailVC alloc] init];
    goodsDetailVC.goodsId = goodsId;
    [self navigatePushViewController:goodsDetailVC animate:YES];
}
#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark -------------------Setter/Getter Method----------------------

- (DLAnimatePerformer *)animatePerformer {
    
    if (!_animatePerformer) {
        _animatePerformer = [[DLAnimatePerformer alloc] init];
    }
    return _animatePerformer;
}

@end

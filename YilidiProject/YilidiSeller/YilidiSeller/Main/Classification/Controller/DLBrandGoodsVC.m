////
////  DLBrandGoodsVC.m
////  YilidiBuyer
////
////  Created by 曾勇兵 on 16/12/12.
////  Copyright © 2016年 yld. All rights reserved.
////
//
#import "DLBrandGoodsVC.h"
//#import "DLGoodsAllshowCell.h"
//#import "DLHomeGoodsModel.h"
//#import "GlobleConst.h"
//#import "GoodsModel.h"
//#import "ProjectRelativeKey.h"
//#import "DLHomeGoodsVerticalCell.h"
//#import "CommunityDataManager.h"
//#import "ShopCartView.h"
//#import "ProjectRelativeDefineNotification.h"
//#import "DLAnimatePerformer.h"
//#import <SVProgressHUD/SVProgressHUD.h>
//#import "DLShopCarVC.h"
//#import "UIViewController+unLoginHandle.h"
//#import "DLGoodsdetailVC.h"
//@interface DLBrandGoodsVC ()
//@property (strong, nonatomic) IBOutlet ShopCartView *shopCartView;
//@property (nonatomic, assign)NSInteger searchedGoodsCount;
//@property (nonatomic, strong)DLAnimatePerformer *animatePerformer;
//@end
//
@implementation DLBrandGoodsVC
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self _init];
//    
//    [self _initShopCartView];
//    
////    self.navigationController.view.backgroundColor = [UIColor whiteColor];
//    
//}
//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:YES];
//    
//    [self.shopCartView initShopCartGoods];
//}
//
//
//#pragma mark ------------------------Init---------------------------------
//-(void)_init {
//    //    [self _initGoodsSearchTableView];
//    [self _initGoodsSearchResultCollectionView];
//    [self _requestGoodsData];
//}
//
//- (void)_initShopCartView {
//    
//    WEAK_SELF
//    self.shopCartView.gotoShopCartPageBlock = ^{
//        [weak_self _enterShopCartPage];
//    };
//}
//
//-(void)_initGoodsSearchResultCollectionView {
//    
//    WEAK_SELF
//    self.brandGoodsCollectionView.noDataLogicModule.nodataAlertTitle = @"抱歉，没有相关商品";
//    [self.brandGoodsCollectionView configureCollectionCellNibName:@"DLHomeGoodsVerticalCell" configureCollectionCellData:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell,NSIndexPath *clickIndexPath) {
//        GoodsModel *model = (GoodsModel *)collectionModel;
//        DLHomeGoodsVerticalCell *searchGoodsCell = (DLHomeGoodsVerticalCell *)collectionCell;
//        [searchGoodsCell setCellModel:model];
//        MyCommonCollectionView *collectionview = (MyCommonCollectionView *)collectionView;
//        searchGoodsCell.imgHeightConstraint.constant = collectionview.cellCalculateModel.cellImgHeight;
//        searchGoodsCell.imgWidthConstraint.constant = collectionview.cellCalculateModel.cellImgWidth;
//        WEAK_OBJ(searchGoodsCell)
//        searchGoodsCell.goodsCountChangeView.countChangedBlk = ^(NSInteger nowCount,BOOL isAdd){
//            [weak_self _performAddShopCartAnimationUsingImgView:weak_searchGoodsCell.goodsImgView isAdd:isAdd];
//        };
//        
//        
//    } clickCell:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
//        GoodsModel *model = (GoodsModel *)collectionModel;
//        [weak_self _enterGoodsDetailWithGoodsId:model.goodsId];
//    }];
//    
////    self.brandGoodsCollectionView.backgroundColor = UIColorFromRGB(0xd33b42);
//    
//    self.brandGoodsCollectionView.commonFlowLayout.minimumInteritemSpacing = 5;
//    self.brandGoodsCollectionView.commonFlowLayout.minimumLineSpacing = 5;
//    
//    self.brandGoodsCollectionView.commonFlowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
//    CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:2 horizontalDisplayAreaWidth:kScreenWidth cellImgToSideEdge:8 cellImgWidthToHeightScale:0.9 cellOterPartHeightBesideImg:97 edgeBetweenCellAndCell:5 edgeBetweenCellAndSide:5];
//    CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
//    self.brandGoodsCollectionView.cellCalculateModel = cellCaculateModel;
//    self.brandGoodsCollectionView.commonFlowLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth, cellCaculateModel.cellHeight);
//    
////    self.brandGoodsCollectionView.commonFlowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, kScreenWidth/1.8);
////    [self.brandGoodsCollectionView configureFirstSectioHeaderNibName:@"DLWeekHeadView" configureFirstSectionHeaderBlock:^(UICollectionView *collectionView, id collectionModel, UICollectionReusableView *firstSectionHeaderView) {
////        
////    }];
//    
//    [self.brandGoodsCollectionView headerRreshRequestBlock:^{
//        [weak_self _requestGoodsData];
//    }];
//    
//    [self.brandGoodsCollectionView footerRreshRequestBlock:^{
//        [weak_self _requestGoodsData];
//    }];
//    
//}
//
//#pragma mark ------------------------Private-------------------------
//- (void)_performAddShopCartAnimationUsingImgView:(UIImageView *)animationImageView isAdd:(BOOL)isAdd{
//    if (!isAdd) {
//        [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(isAdd)];
//        return;
//    }
//    self.brandGoodsCollectionView.scrollEnabled = NO;
//    WEAK_SELF
//    [self.animatePerformer performProjectDefaultAddShopCartAnimationForAnimationGoodsImgView:animationImageView animateEndPoint: CGPointMake(kScreenWidth-34-50/2, kScreenHeight-58 - 50/2) animateDidEndBlock:^{
//        weak_self.brandGoodsCollectionView.scrollEnabled = YES;
//        [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(isAdd)];
//    }];
//}
//
//#pragma mark ------------------------Api----------------------------------
//- (void)_requestGoodsData {
//    [self showLoadingHub];
//    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:0];
//    
//    [requestParam setObject:self.brandCode forKey:@"brandCode"];
//    [requestParam setObject:kCommunityStoreId forKey:KStoreIdKey];
//    [requestParam setObject:@(self.brandGoodsCollectionView.dataLogicModule.requestFromPage) forKey:kRequestPageNumKey];
//    [requestParam setObject:@(kRequestDefaultPageSize) forKey:kRequestPageSizeKey];
//    WEAK_SELF
//    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_BrandPaging block:^(NSDictionary *resultDic, NSError *error) {
//        [weak_self hideLoadingHub];
//        
//        if (isEmpty(resultDic[EntityKey])) {
//            return;
//        }
//        
//       
//        
//        
//        NSArray *resultArr = resultDic[EntityKey][@"list"];
//        NSArray *transferedArr = [GoodsModel objectGoodsModelWithGoodsArr:resultArr];
//        [weak_self.brandGoodsCollectionView configureCollectionAfterRequestPagingData:transferedArr];
//        [weak_self.brandGoodsCollectionView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
//    }];
//}
//
//
//#pragma mark ------------------------Page Navigate---------------------------
//- (void)_enterShopCartPage {
//    if (![self unloginHandle]) {
//        return;
//    }
//    DLShopCarVC *shopCartVC = [[DLShopCarVC alloc] init];
//    [self navigatePushViewController:shopCartVC animate:YES];
//}
//
//- (void)_enterGoodsDetailWithGoodsId:(NSString *)goodsId {
//    DLGoodsdetailVC *goodsDetailVC = [[DLGoodsdetailVC alloc] init];
//    goodsDetailVC.goodsId = goodsId;
//    [self navigatePushViewController:goodsDetailVC animate:YES];
//}
//#pragma mark ------------------------View Event---------------------------
//
//#pragma mark ------------------------Delegate-----------------------------
//
//#pragma mark ------------------------Notification-------------------------
//
//#pragma mark -------------------Setter/Getter Method----------------------
//
//- (DLAnimatePerformer *)animatePerformer {
//    
//    if (!_animatePerformer) {
//        _animatePerformer = [[DLAnimatePerformer alloc] init];
//    }
//    return _animatePerformer;
//}
//
//
@end

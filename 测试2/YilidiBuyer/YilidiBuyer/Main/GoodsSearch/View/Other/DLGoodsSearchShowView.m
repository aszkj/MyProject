//
//  DLGoodsSearchShowView.m
//  YilidiBuyer
//
//  Created by yld on 16/5/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGoodsSearchShowView.h"
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
@interface DLGoodsSearchShowView()
@property (nonatomic, assign)NSInteger searchedGoodsCount;
@property (weak, nonatomic) IBOutlet ShopCartView *shopCartView;
@property (nonatomic, strong)DLAnimatePerformer *animatePerformer;

@end

@implementation DLGoodsSearchShowView

#pragma mark -------------------Init Method----------------------
- (void)awakeFromNib {
    
    [self _init];
    
    [self _initShopCartView];
}

-(void)_init {
//    [self _initGoodsSearchTableView];
    [self _initGoodsSearchResultCollectionView];
}

- (void)_initShopCartView {
    
    WEAK_SELF
    self.shopCartView.gotoShopCartPageBlock = ^{
        emptyBlock(weak_self.gotoShopCartPageBlock);
    };
}

- (void)_performAddShopCartAnimationUsingImgView:(UIImageView *)animationImageView isAdd:(BOOL)isAdd{
    if (!isAdd) {
        [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(isAdd)];
        return;
    }
    self.searchGoodsTableView.scrollEnabled = NO;
    WEAK_SELF
    [self.animatePerformer performProjectDefaultAddShopCartAnimationForAnimationGoodsImgView:animationImageView animateEndPoint: CGPointMake(kScreenWidth-34-50/2, kScreenHeight-58 - 50/2) animateDidEndBlock:^{
        weak_self.searchGoodsTableView.scrollEnabled = YES;
        [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(isAdd)];
    }];
}


-(void)_initGoodsSearchResultCollectionView {
    
    WEAK_SELF
    self.searchGoodsResultCollectionView.nodataAlertTitle = @"抱歉，没有搜到相关商品";
    [self.searchGoodsResultCollectionView configureCollectionCellNibName:@"DLHomeGoodsVerticalCell" configureCollectionCellData:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell) {
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
        emptyBlock(weak_self.gotoGoodsDetailPageBlock,model.goodsId);
    }];
    
    self.searchGoodsResultCollectionView.commonFlowLayout.minimumInteritemSpacing = 5;
   self.searchGoodsResultCollectionView.commonFlowLayout.minimumLineSpacing = 5;
    
    self.searchGoodsResultCollectionView.commonFlowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:2 horizontalDisplayAreaWidth:kScreenWidth cellImgToSideEdge:8 cellImgWidthToHeightScale:0.9 cellOterPartHeightBesideImg:97 edgeBetweenCellAndCell:5 edgeBetweenCellAndSide:5];
    CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
    self.searchGoodsResultCollectionView.cellCalculateModel = cellCaculateModel;
    self.searchGoodsResultCollectionView.commonFlowLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth, cellCaculateModel.cellHeight);
    [self.searchGoodsResultCollectionView headerRreshRequestBlock:^{
        [weak_self requestGoodsData];
    }];
    
    [self.searchGoodsResultCollectionView footerRreshRequestBlock:^{
        [weak_self requestGoodsData];
    }];

}


-(void)_initGoodsSearchTableView {
    
    WEAK_SELF
    self.searchGoodsTableView.cellHeight = GoodsAllshowHeight;
    self.searchGoodsTableView.firstSectionHeaderHeight = 28;
    [self.searchGoodsTableView configurecellNibName:@"DLGoodsAllshowCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        GoodsModel *model = (GoodsModel *)cellModel;
        DLGoodsAllshowCell *searchGoodsCell = (DLGoodsAllshowCell *)cell;
        [searchGoodsCell setGoodsAllshowCell:model];
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        GoodsModel *model = (GoodsModel *)cellModel;
        emptyBlock(weak_self.gotoGoodsDetailPageBlock,model.goodsId);
    }];
    
    [self.searchGoodsTableView configureFirstSectioHeaderNibName:@"DLSearchGoodsHeaderView" ConfigureTablefirstSectionHeaderBlock:^(UITableView *tableView,id cellModel, UIView *firstSectionHeaderView) {
        
        NSString *keyWords = weak_self.keyWords;
        if (isEmpty(keyWords)) {
            keyWords = @"全部商品";
        }
        NSString *searchResultStr = [NSString stringWithFormat:@"搜到“%@”%ld条",keyWords,        weak_self.searchGoodsTableView.dataLogicModule.currentDataModelArr.count];
        NSRange keyWordsRange = [searchResultStr rangeOfString:keyWords];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:searchResultStr];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]
                                range:keyWordsRange];
        UILabel *searchLabel = (UILabel *)[firstSectionHeaderView viewWithTag:1];
        searchLabel.attributedText = attriString;
    }];
    
    [self.searchGoodsTableView headerRreshRequestBlock:^{
        [weak_self requestGoodsData];
    }];
    
    [self.searchGoodsTableView footerRreshRequestBlock:^{
        [weak_self requestGoodsData];
    }];
    
}


- (void)requestGoodsData {
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:0];
    if (!isEmpty(self.keyWords)) {
        [requestParam setObject:self.keyWords forKey:@"keywords"];
    }
    if (isEmpty(kCommunityStoreId)) {
        return;
    }
    [requestParam setObject:@(self.searchGoodsResultCollectionView.dataLogicModule.requestFromPage) forKey:kRequestPageNumKey];
    [requestParam setObject:@(kRequestDefaultPageSize) forKey:kRequestPageSizeKey];
    [requestParam setObject:kCommunityStoreId forKey:KStoreIdKey];
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GoodsSearch block:^(NSDictionary *resultDic, NSError *error) {
        [SVProgressHUD dismiss];
        NSArray *resultArr = resultDic[EntityKey][@"list"];
        NSArray *transferedArr = [GoodsModel objectGoodsModelWithGoodsArr:resultArr];
        [self.searchGoodsResultCollectionView configureTableAfterRequestData:transferedArr];
    }];
}

#pragma mark -------------------Setter/Getter Method----------------------
-(void)setKeyWords:(NSString *)keyWords {
    _keyWords = keyWords;
    [SVProgressHUD showWithStatus:@"拼命加载中.."];
    self.searchGoodsResultCollectionView.dataLogicModule.requestFromPage = 1;
    [self requestGoodsData];
}
- (DLAnimatePerformer *)animatePerformer {
    
    if (!_animatePerformer) {
        _animatePerformer = [[DLAnimatePerformer alloc] init];
    }
    return _animatePerformer;
}


@end

//
//  DLBrandView.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBrandView.h"
#import "DLBrandCollectionCell.h"
#import "DLBrandModel.h"
#import "DLBrandHeadView.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "DLClassificationVC.h"
#import "DLBrandGoodsVC.h"
#import "DLBrandClassificationVC.h"
#import "GlobleConst.h"
#import "BrandDataManager.h"
#import "ProjectRelativeKey.h"
#import <Masonry.h>
#import "DLGoodsSearchVC.h"
@interface DLBrandView()

@property (nonatomic, copy)NSString *requestBrandDataStoreId;
@property (nonatomic,strong) UIViewController *ownVC;

@end

@implementation DLBrandView

- (void)awakeFromNib{

    [super awakeFromNib];
    [self _initBrandCollectionView];
    
    
}




#pragma mark ------------------------Init---------------------------------
-(void)_initBrandCollectionView {
    
    WEAK_SELF
    [self.brandCollectionView configureCollectionCellNibName:@"DLBrandCollectionCell" configureCollectionCellData:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell,NSIndexPath *clickIndexPath) {
        DLBrandModel *model = (DLBrandModel *)collectionModel;
        DLBrandCollectionCell *brandCollectionCell = (DLBrandCollectionCell *)collectionCell;
        [brandCollectionCell setModel:model];

        
    } clickCell:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        DLBrandModel *model = (DLBrandModel *)collectionModel;
        
        DLBrandGoodsVC *brandGoodsVC = [[DLBrandGoodsVC alloc]init];
        brandGoodsVC.brandCode = model.brandCode;
        brandGoodsVC.pageTitle = model.brandName;
        
        if ([_showType isEqualToString:@"hotBrand"]) {
            [weak_self.ownVC.navigationController pushViewController:brandGoodsVC animated:YES];
        }else{
            [weak_self.searchVC navigatePushViewController:brandGoodsVC animate:YES];
        }
        
        
    }];
    

    self.brandCollectionView.commonFlowLayout.minimumInteritemSpacing = 11;
    self.brandCollectionView.commonFlowLayout.minimumLineSpacing = 11;
    
    self.brandCollectionView.commonFlowLayout.sectionInset = UIEdgeInsetsMake(11, 11, 11, 11);
    CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:4 horizontalDisplayAreaWidth:kScreenWidth cellImgToSideEdge:10 cellImgWidthToHeightScale:1.76 cellOterPartHeightBesideImg:37 edgeBetweenCellAndCell:11 edgeBetweenCellAndSide:11];
    CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
    self.brandCollectionView.cellCalculateModel = cellCaculateModel;
    self.brandCollectionView.commonFlowLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth, cellCaculateModel.cellHeight);
    
 
    
}

#pragma mark ------------------------Private-------------------------
- (void)requestHotBrandDataConfigure {
    BOOL needRequestStoreBrandData = NO;
    if (isEmpty(kCommunityStoreId)) {
        return;
    }
    
    if (isEmpty(self.requestBrandDataStoreId)) {
        needRequestStoreBrandData = YES;
    }else {
        //上一次请求的storeId有值，但是又和当前的不一样，说明店铺换了,得重新请求分类
        if (![self.requestBrandDataStoreId isEqualToString:kCommunityStoreId]) {
            needRequestStoreBrandData = YES;
        }
    }
    if (needRequestStoreBrandData) {
        self.requestBrandDataStoreId = kCommunityStoreId;
        [self requestHotBrand];
    }
    
}

#pragma mark ------------------------Api----------------------------------
- (void)requestHotBrand{
//    [self.ownVC showLoadingHub];
    WEAK_SELF
    self.brandCollectionView.commonFlowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 33);
    [self.brandCollectionView configureFirstSectioHeaderNibName:@"DLBrandHeadView" configureFirstSectionHeaderBlock:^(UICollectionView *collectionView, id collectionModel, UICollectionReusableView *firstSectionHeaderView) {
        DLBrandHeadView *headView = (DLBrandHeadView *)firstSectionHeaderView;
        headView.headBlock = ^{
            
            DLBrandClassificationVC *brandClassificationVC = [[DLBrandClassificationVC alloc]init];
            
            [weak_self.ownVC.navigationController pushViewController:brandClassificationVC animated:YES];
        };
        
        
    }];
    
    [AFNHttpRequestOPManager postWithParameters:@{@"type":@"hot"} subUrl:kUrl_Brand block:^(NSDictionary *resultDic, NSError *error) {
//        [self.ownVC hideLoadingHub];
        if (isEmpty(resultDic[EntityKey])) {
            return;
        }
        
        NSArray *resultArr = resultDic[EntityKey];
        NSArray *transferedArr = [DLBrandModel objectBrandModelWithArr:resultArr];
        weak_self.brandCollectionView.dataLogicModule.currentDataModelArr = [transferedArr mutableCopy];
        [weak_self.brandCollectionView reloadData];

    }];

    
}

- (void)_requestBrandData{
    
    self.brandCollectionView.dataLogicModule.requestPageSize=28;
    WEAK_SELF
    [self.searchVC showLoadingHub];
    NSLog(@"keywords:%@",_keyWords);
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:0];
    if (!isEmpty(self.keyWords)) {
        [requestParam setObject:self.keyWords forKey:@"keywords"];
    }
    if (isEmpty(kCommunityStoreId)) {
        return;
    }
    
    [requestParam setObject:@(self.brandCollectionView.dataLogicModule.requestFromPage) forKey:kRequestPageNumKey];
    [requestParam setObject:@(28) forKey:kRequestPageSizeKey];
    [requestParam setObject:kCommunityStoreId forKey:KStoreIdKey];
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_SearchBrand block:^(NSDictionary *resultDic, NSError *error) {
        [weak_self.searchVC hideLoadingHub];
        NSArray *resultArr = resultDic[EntityKey][@"list"];
        NSArray *transferedArr = [DLBrandModel objectBrandModelWithArr:resultArr];
        [weak_self.brandCollectionView configureCollectionAfterRequestPagingData:transferedArr];
        [weak_self.brandCollectionView reloadData];
      
    }];
    
   

    
}

#pragma mark ------------------------Page Navigate---------------------------

#pragma mark ------------------------View Event---------------------------
- (void)setShowType:(NSString *)showType{
    _showType = showType;
    
    [self requestHotBrandDataConfigure];
    
}
#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------
- (void)setKeyWords:(NSString *)keyWords{

    _keyWords = keyWords;
    self.brandCollectionView.dataLogicModule.requestFromPage = 1;
    WEAK_SELF
    self.brandCollectionView.noDataLogicModule.nodataAlertTitle = @"暂时没有找到相关品牌";
    [self.brandCollectionView headerRreshRequestBlock:^{
        [weak_self _requestBrandData];
    }];
    
    [self.brandCollectionView footerRreshRequestBlock:^{
        [weak_self _requestBrandData];
    }];
    
    [self _requestBrandData];

}

- (UIViewController *)ownVC {
    if (!_ownVC) {
        _ownVC = [Util currentViewController];
    }
    return _ownVC;
}


@end

//
//  DLBrandView.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBrandView.h"
#import "MyCommonCollectionView.h"
#import "DLBrandCollectionCell.h"
#import "DLBrandModel.h"
#import "DLBrandHeadView.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "DLClassificationVC.h"
#import "DLBrandGoodsVC.h"
#import "DLBrandGoodsManageVC.h"
#import "DLBrandClassificationVC.h"
#import "BrandDataManager.h"
@interface DLBrandView()

@property (strong, nonatomic) IBOutlet MyCommonCollectionView *brandCollectionView;


@end

@implementation DLBrandView

- (void)awakeFromNib{

    [super awakeFromNib];
    [self _requestHotBrand];
    [self _initBrandCollectionView];
    
}

#pragma mark ------------------------Init---------------------------------
-(void)_initBrandCollectionView {
    
    
  
    WEAK_SELF
//    self.brandCollectionView.nodataAlertTitle = @"抱歉，没有相关商品";
    [self.brandCollectionView configureCollectionCellNibName:@"DLBrandCollectionCell" configureCollectionCellData:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell,NSIndexPath *clickIndexPath) {
        DLBrandModel *model = (DLBrandModel *)collectionModel;
        DLBrandCollectionCell *brandCollectionCell = (DLBrandCollectionCell *)collectionCell;
        [brandCollectionCell setModel:model];
//        MyCommonCollectionView *collectionview = (MyCommonCollectionView *)collectionView;
//        brandCollectionCell.imgHeightConstraint.constant = collectionview.cellCalculateModel.cellImgHeight;
//        brandCollectionCell.imgWidthConstraint.constant = collectionview.cellCalculateModel.cellImgWidth;
//        WEAK_OBJ(brandCollectionCell)
        
        
        
    } clickCell:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        DLBrandModel *model = (DLBrandModel *)collectionModel;
        
        DLBrandGoodsManageVC *brandGoodsVC = [[DLBrandGoodsManageVC alloc]init];
        brandGoodsVC.brandCode = model.brandCode;
        brandGoodsVC.brandName = model.brandName;
        [weak_self.ownVC navigatePushViewController:brandGoodsVC animate:YES];
        
    }];
    

    self.brandCollectionView.commonFlowLayout.minimumInteritemSpacing = 11;
    self.brandCollectionView.commonFlowLayout.minimumLineSpacing = 11;
    
    self.brandCollectionView.commonFlowLayout.sectionInset = UIEdgeInsetsMake(11, 11, 11, 11);
    CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:4 horizontalDisplayAreaWidth:kScreenWidth cellImgToSideEdge:10 cellImgWidthToHeightScale:1.76 cellOterPartHeightBesideImg:37 edgeBetweenCellAndCell:11 edgeBetweenCellAndSide:11];
    CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
    self.brandCollectionView.cellCalculateModel = cellCaculateModel;
    self.brandCollectionView.commonFlowLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth, cellCaculateModel.cellHeight);
    
    self.brandCollectionView.commonFlowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 33);
    [self.brandCollectionView configureFirstSectioHeaderNibName:@"DLBrandHeadView" configureFirstSectionHeaderBlock:^(UICollectionView *collectionView, id collectionModel, UICollectionReusableView *firstSectionHeaderView) {
        DLBrandHeadView *headView = (DLBrandHeadView *)firstSectionHeaderView;
        headView.headBlock = ^{

            DLBrandClassificationVC *brandClassificationVC = [[DLBrandClassificationVC alloc]init];
            
            [weak_self.ownVC navigatePushViewController:brandClassificationVC animate:YES];
        };
        
        
    }];
    
    
   
    
    
}



#pragma mark ------------------------Private-------------------------

#pragma mark ------------------------Api----------------------------------
- (void)_requestHotBrand{

    [self.ownVC showLoadingHub];
    
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:@{@"type":@"hot"} subUrl:kUrl_Brand block:^(NSDictionary *resultDic, NSError *error) {
        [weak_self.ownVC hideLoadingHub];
        if (isEmpty(resultDic[EntityKey])) {
            return;
        }
        
        NSArray *resultArr = resultDic[EntityKey];
        NSArray *transferedArr = [DLBrandModel objectBrandModelWithArr:resultArr];
        [weak_self.brandCollectionView configureCollectionAfterRequestTotalData:[transferedArr mutableCopy]];
        [weak_self.brandCollectionView reloadData];

    }];

    
}
#pragma mark ------------------------Page Navigate---------------------------

#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------


@end

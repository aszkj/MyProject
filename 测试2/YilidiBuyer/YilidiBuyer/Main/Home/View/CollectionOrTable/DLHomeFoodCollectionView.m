//
//  DLHomeFoodCollectionView.m
//  YilidiBuyer
//
//  Created by yld on 16/4/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHomeFoodCollectionView.h"
#import "DLCommunityHoteSaleCollectionViewCell.h"
#import "CellCalculateModel.h"
#import "MyCommonCollectionView.h"
#import "MycommonTableView.h"
#import "CellCalculateModel.h"
#import "DLCommunityGoodsCollectionViewCell.h"
#import "UIButton+Block.h"
#import "ProjectRelativeKey.h"
#import "DLHomeGoodsVerticalCell.h"
#import "ProjectRelativeDefineNotification.h"
#import "DLHomeSecondSectionHeaderView.h"
#import "DLHomeGoodsClassModel.h"
#import "DLHomeFloorModel.h"
#import "GoodsModel.h"
#import "UIImageView+sd_SetImg.h"
#import "GlobleConst.h"
#import "UIView+BlockGesture.h"
#import "DataManager+linkDataHandle.h"


static NSString *DLHomeGoodsVerticalCellID = @"DLHomeGoodsVerticalCellID";
static NSString *DLHomeHeaderViewID = @"DLHomeHeaderViewID";
static NSString *DLHomeSecondSectionHeaderID = @"DLHomeSecondSectionHeaderID";
@interface DLHomeFoodCollectionView()

@property (nonatomic, strong)CellCalculateModel *cellCalculateModel;

@end

@implementation DLHomeFoodCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self _init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)_init {
    self.dataSource = self;
    self.delegate = self;
    self.headerHeight = kDlhomeHeaderViewTotalHeight;
    [self registerNib:[UINib nibWithNibName:@"DLHomeGoodsVerticalCell" bundle:nil] forCellWithReuseIdentifier:DLHomeGoodsVerticalCellID];
    [self registerNib:[UINib nibWithNibName:@"DLHomeHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DLHomeHeaderViewID];
    [self registerNib:[UINib nibWithNibName:@"DLHomeSecondSectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DLHomeSecondSectionHeaderID];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
        return self.floorList.count+1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        DLHomeFloorModel *floorModel = self.floorList[section-1];
        return floorModel.floorBaseInfoModel.floorProductList.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return nil;
    }else {
        DLHomeFloorModel *floorModel = self.floorList[indexPath.section-1];
        DLHomeGoodsVerticalCell *cell = [self dequeueReusableCellWithReuseIdentifier:DLHomeGoodsVerticalCellID forIndexPath:indexPath];
        GoodsModel *model = floorModel.floorBaseInfoModel.floorProductList[indexPath.row];
        [cell setCellModel:model];
        cell.imgWidthConstraint.constant = self.cellCalculateModel.cellImgWidth;
        cell.imgHeightConstraint.constant = self.cellCalculateModel.cellImgHeight;
        return cell;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }else {
        DLHomeFloorModel *floorModel = self.floorList[section-1];
        if (floorModel.floorBaseInfoModel && floorModel.floorBaseInfoModel.floorProductList.count) {
            return self.homeFoodCollectionViewLayout.sectionInset;
        }else {
            return UIEdgeInsetsMake(3, 0, 0, 0);
        }
    }
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else {
        DLHomeFloorModel *floorModel = self.floorList[section-1];
        if (floorModel.floorBaseInfoModel && floorModel.floorBaseInfoModel.floorProductList.count) {
            return self.homeFoodCollectionViewLayout.minimumLineSpacing;
        }else {
            return 0;
        }
    }

}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{

    if (section == 0) {
        return 0;
    }else {
        DLHomeFloorModel *floorModel = self.floorList[section-1];
        if (floorModel.floorBaseInfoModel && floorModel.floorBaseInfoModel.floorProductList.count) {
            return self.homeFoodCollectionViewLayout.minimumInteritemSpacing;
        }else {
            return 0;
        }
    }

}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    DLHomeFloorModel *floorModel = self.floorList[indexPath.section-1];
    GoodsModel *model = floorModel.floorBaseInfoModel.floorProductList[indexPath.row];
    emptyBlock(self.clickGoodsCellBlock,model);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (kind == UICollectionElementKindSectionHeader) {
            DLHomeHeaderView *homeFirstSectionView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DLHomeHeaderViewID forIndexPath:indexPath];
            self.homeFirstSectionView = homeFirstSectionView;
            return homeFirstSectionView;
        }
    }else {
        if (kind == UICollectionElementKindSectionHeader) {
            DLHomeSecondSectionHeaderView *homeSecondSectionView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DLHomeSecondSectionHeaderID forIndexPath:indexPath];
            DLHomeFloorModel *floorModel = self.floorList[indexPath.section-1];
            homeSecondSectionView.floorModel = floorModel;
            return homeSecondSectionView;
        }
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(kScreenWidth, self.headerHeight);
    }else {
        DLHomeFloorModel *floorModel = self.floorList[section-1];
        return CGSizeMake(kScreenWidth, floorModel.floodHeaderAndAdPartHeight);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    emptyBlock(self.scrollContentOffsetBlock,scrollView.contentOffset.y);
    
}


-(UICollectionViewFlowLayout *)homeFoodCollectionViewLayout {

    if (!_homeFoodCollectionViewLayout) {
        _homeFoodCollectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
        _homeFoodCollectionViewLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _homeFoodCollectionViewLayout.minimumInteritemSpacing = 5;
        _homeFoodCollectionViewLayout.minimumLineSpacing = 5;
        CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:2 horizontalDisplayAreaWidth:kScreenWidth cellImgToSideEdge:7 cellImgWidthToHeightScale:1.0 cellOterPartHeightBesideImg:97 edgeBetweenCellAndCell:5 edgeBetweenCellAndSide:5];
        CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
        self.cellCalculateModel = cellCaculateModel;
       _homeFoodCollectionViewLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth, cellCaculateModel.cellHeight);
    }
    return _homeFoodCollectionViewLayout;
}

@end

//
//  DLHomeFoodCollectionView.m
//  YilidiBuyer
//
//  Created by yld on 16/4/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHomeFoodCollectionView.h"
#import "DLFreshFruitCollectionViewCell.h"
#import "DLTopQualityFruitSectionHeaderView.h"

static NSString *DLFreshFruitCollectionViewCellID = @"DLFreshFruitCollectionViewCellID";
static NSString *DLTopQualityFruitSectionHeaderViewID = @"DLTopQualityFruitSectionHeaderViewID";
static NSString *DLHomeHeaderViewID = @"DLHomeHeaderViewID";

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
    self.firstSectionHeaderHeight = kDlhomeHeaderViewHeight;
    self.dataSource = self;
    self.delegate = self;
    [self registerNib:[UINib nibWithNibName:@"DLFreshFruitCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:DLFreshFruitCollectionViewCellID];
    [self registerNib:[UINib nibWithNibName:@"DLTopQualityFruitSectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DLTopQualityFruitSectionHeaderViewID];
    [self registerNib:[UINib nibWithNibName:@"DLHomeHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DLHomeHeaderViewID];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else if (section == 1) {
        return self.datas.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return nil;
    }else if (indexPath.section == 1){
    
        DLFreshFruitCollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:DLFreshFruitCollectionViewCellID forIndexPath:indexPath];
        cell.goodsModel = self.datas[indexPath.row];
        return cell;
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
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
            DLTopQualityFruitSectionHeaderView *reusableHeaderView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DLTopQualityFruitSectionHeaderViewID forIndexPath:indexPath];
            return reusableHeaderView;
        }
    }
    
    return nil;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(kScreenWidth, self.firstSectionHeaderHeight);
    }
    return CGSizeMake(kScreenWidth, kTopQuliytySectionHeaderHeight);
}

- (void)setFirstSectionHeaderHeight:(CGFloat)firstSectionHeaderHeight {
    
    _firstSectionHeaderHeight = firstSectionHeaderHeight;
//    NSIndexSet *firSection = [NSIndexSet indexSetWithIndex:0];
//    [self reloadSections:firSection];
}

-(UICollectionViewFlowLayout *)homeFoodCollectionViewLayout {

    if (!_homeFoodCollectionViewLayout) {
        _homeFoodCollectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
        _homeFoodCollectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _homeFoodCollectionViewLayout.minimumInteritemSpacing = 0;
        _homeFoodCollectionViewLayout.minimumLineSpacing = 0;
        _homeFoodCollectionViewLayout.itemSize = CGSizeMake(kFreshFruitCellWidth, kFreshFruitCellHeight);
    }
    
    return _homeFoodCollectionViewLayout;

}

@end

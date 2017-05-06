//
//  JGNewYearCollectionView.m
//  jingGang
//
//  Created by dengxf on 15/12/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGNewYearCollectionView.h"
#import "JGActivityItemCell.h"
#import "JGActivityHeaderView.h"
#import "JGActivityFootiew.h"
#import "UIImageView+WebCache.h"
#import "GlobeObject.h"

static NSString * kActivityCollectionCell = @"kActivityCollectionCell";

@implementation JGNewYearCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.dataSource = self;
    self.delegate = self;
    [self registerNib:[UINib nibWithNibName:@"JGActivityItemCell" bundle:nil] forCellWithReuseIdentifier:kActivityCollectionCell];
    [self registerClass:[JGActivityHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
}

- (void)setShops:(NSArray *)shops {
    _shops = shops;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JGActivityItemCell *cell = [self dequeueReusableCellWithReuseIdentifier:kActivityCollectionCell forIndexPath:indexPath];
    cell.backgroundColor = kGetColorWithAlpha(240, 240, 240, 1);
    cell.apiBO = self.shops[indexPath.item];
    cell.selectedItemButtonBlock = ^(ActHotSaleGoodsInfoApiBO *apiBO){
        if (self.selectedItemShopBlock) {
            self.selectedItemShopBlock(apiBO);
        }
    };
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JGActivityItemCell *cell = (JGActivityItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selectedItemButtonBlock = ^(ActHotSaleGoodsInfoApiBO *apiBO){
        if (self.selectedItemShopBlock) {
            self.selectedItemShopBlock(apiBO);
        }
    };
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        JGActivityHeaderView *reusableView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor clearColor];
        UIImageView *headimg = [[UIImageView alloc] init];
        [reusableView addSubview:headimg];
        headimg.x = 0;
        headimg.y = 0;
        headimg.width = ScreenWidth;
        headimg.height = reusableView.height;
        [headimg sd_setImageWithURL:[NSURL URLWithString:self.apiBO.headImage] placeholderImage:nil];
        return reusableView;
    }else {
        JGActivityFootiew *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot" forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor clearColor];
        UIImageView *footimg = [[UIImageView alloc] init];
        [reusableView addSubview:footimg];
        footimg.x = 0;
        footimg.y = 0;
        footimg.width = ScreenWidth;
        footimg.height = reusableView.height;
        [footimg sd_setImageWithURL:[NSURL URLWithString:self.apiBO.footImage] placeholderImage:nil];
        return reusableView;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenWidth, [self getImageHeightWithNormalHeight:603]);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(ScreenWidth, [self getImageHeightWithNormalHeight:173]);
}

- (CGFloat)getImageHeightWithNormalHeight:(CGFloat)normalHeight
{
    //以iphone6的屏幕宽度为标准
    CGFloat height = kScreenWidth/375 * normalHeight;
    
    return height;
}

@end

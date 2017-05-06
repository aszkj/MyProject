//
//  IntegralHomeCollectionView.m
//  jingGang
//
//  Created by 张康健 on 15/11/22.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "IntegralHomeCollectionView.h"
#import "IntegralShopCell.h"
#import "GlobeObject.h"
#import "IntegralGoodsDetailController.h"
#import "UIView+firstResponseController.h"
@implementation IntegralHomeCollectionView

static NSString *IntegralHomeHeaderViewID = @"IntegralHomeHeaderViewID";
static NSString *IntegralShopCellID = @"IntegralShopCellID";

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self _init];
    }
    return self;
}


-(void)_init{
    
    self.dataSource = self;
    self.delegate = self;
    [self registerNib:[UINib nibWithNibName:@"IntegralHomeHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IntegralHomeHeaderViewID];
    [self registerNib:[UINib nibWithNibName:@"IntegralShopCell" bundle:nil] forCellWithReuseIdentifier:IntegralShopCellID];
}


-(void)setCollectionlayout{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(KCellWith, KCellHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(KIntegralCellGap, KIntegralCellGap, KIntegralCellGap, KIntegralCellGap);
    layout.minimumLineSpacing = KIntegralCellGap;
    layout.headerReferenceSize = CGSizeMake(kScreenWidth, 225);
    self.collectionViewLayout = layout;
}



#pragma mark ----------------------- data source -----------------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1 ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IntegralShopCell *cell = [self dequeueReusableCellWithReuseIdentifier:IntegralShopCellID forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark ----------------------- header reuse Method -----------------------
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        IntegralHomeHeaderView *headerView = [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IntegralHomeHeaderViewID forIndexPath:indexPath];
        self.headerView = headerView;
        reusableview = headerView;
    }
    
    return reusableview;
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did select cell");
    IntegralGoodsDetailController *inteGralGoodsVc = [[IntegralGoodsDetailController alloc] init];
    IntegralListBO *model = self.dataArr[indexPath.row];
    inteGralGoodsVc.integralGoodsID = model.apiId;
    [self.firstResponseController.navigationController pushViewController:inteGralGoodsVc animated:YES];

}








@end

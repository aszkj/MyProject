//
//  CareChoosenCollectionView.m
//  jingGang
//
//  Created by 张康健 on 15/10/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "CareChoosenCollectionView.h"
#import "GlobeObject.h"
#import "CaseChoosenHeaderReusableView.h"
#import "KJGoodsDetailViewController.h"
#import "UIView+firstResponseController.h"
@implementation CareChoosenCollectionView

static NSString *careChoosenGoodsID = @"careChoosenGoodsID";

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self _init];
        

        
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];

    if (self) {
        
        [self _init];
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {

    self = [super initWithFrame:frame collectionViewLayout:[self getDefaultLayout]];
    if (self) {
        [self _init];
    }
    return self;
    
}


-(void)_init{
    
    self.backgroundColor = [UIColor whiteColor];
    self.dataSource = self;
    self.delegate = self;
    self.scrollEnabled = NO;
    [self registerNib:[UINib nibWithNibName:@"SHKJGuessyouLikeCollectionCell" bundle:nil] forCellWithReuseIdentifier:careChoosenGoodsID];
//    [self registerNib:[UINib nibWithNibName:@"CaseChoosenHeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"choosenGoodsHeaderID"];
}


-(UICollectionViewLayout *)getDefaultLayout {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(kScreenWidth/2.0, kCareChoosenGoodsCellHeight);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return flowLayout;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataArr.count;
//    return 4;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHKJGuessyouLikeCollectionCell *cell = [self dequeueReusableCellWithReuseIdentifier:careChoosenGoodsID forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CaseChoosenHeaderReusableView *reusableview = (CaseChoosenHeaderReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"choosenGoodsHeaderID" forIndexPath:indexPath];;
    return reusableview;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KJGoodsDetailViewController *goodSDetailVC = [[KJGoodsDetailViewController alloc] init];
    
    GoodsDetailModel *model = self.dataArr[indexPath.row];
    goodSDetailVC.goodsID = @(model.GoodsDetailModelID.integerValue);
    goodSDetailVC.hidesBottomBarWhenPushed = YES;
    [self.firstResponseController.navigationController pushViewController:goodSDetailVC animated:YES];

}




#pragma mark ----------------------- request Method -----------------------
//请求推荐位
-(void)requestWithGoodsCode:(NSString *)storeCode result:(CareChoosenGoodsBlcok)resultBlock
{



}






@end

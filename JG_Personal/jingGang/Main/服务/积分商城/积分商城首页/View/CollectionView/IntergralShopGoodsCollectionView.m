//
//  IntergralShopGoodsCollectionView.m
//  jingGang
//
//  Created by 张康健 on 15/10/30.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "IntergralShopGoodsCollectionView.h"
#import "GlobeObject.h"
#import "UIView+firstResponseController.h"
#import "IntegralGoodsDetailController.h"
#import "IntegralListBO.h"


@implementation IntergralShopGoodsCollectionView

static NSString *intergralShopCellID = @"intergralShopCellID";

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        
        [self _init];
    }
    return self;
}

-(void)_init{
    
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.dataSource = self;
    self.delegate = self;
    [self registerNib:[UINib nibWithNibName:@"IntegralShopCell" bundle:nil] forCellWithReuseIdentifier:intergralShopCellID];
}


-(void)setCollectionlayout{


    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(KCellWith, KCellHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(KIntegralCellGap, KIntegralCellGap, KIntegralCellGap, KIntegralCellGap);
    layout.minimumLineSpacing = KIntegralCellGap;
    self.collectionViewLayout = layout;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IntegralShopCell *cell = [self dequeueReusableCellWithReuseIdentifier:intergralShopCellID forIndexPath:indexPath];
    
    cell.model = self.dataArr[indexPath.row];
    
    return cell;
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

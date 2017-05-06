//
//  JGNewYearCollectionView.h
//  jingGang
//
//  Created by dengxf on 15/12/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGActivityHotSaleApiBO.h"
#import "ActHotSaleGoodsInfoApiBO.h"

typedef void(^SelectedItemShopBlock)(ActHotSaleGoodsInfoApiBO *apiBO);

@interface JGNewYearCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (copy , nonatomic) SelectedItemShopBlock selectedItemShopBlock;

@property (strong,nonatomic) NSArray *shops;

@property (strong,nonatomic) JGActivityHotSaleApiBO *apiBO;
@end

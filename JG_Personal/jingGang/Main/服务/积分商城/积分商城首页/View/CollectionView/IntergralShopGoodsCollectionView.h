//
//  IntergralShopGoodsCollectionView.h
//  jingGang
//
//  Created by 张康健 on 15/10/30.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobeObject.h"
#import "IntegralShopCell.h"
@interface IntergralShopGoodsCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataArr;

-(void)setCollectionlayout;


@end

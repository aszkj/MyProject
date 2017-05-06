//
//  KJShopHomeGuessYoulikeCollectionView.h
//  jingGang
//
//  Created by 张康健 on 15/8/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHKJGuessyouLikeCollectionCell.h"
@class GoodsDetailModel;
@interface KJShopHomeGuessYoulikeCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

//猜您喜欢回调block
typedef void(^ShopHomeGuessyouLikeBlock)(GoodsDetailModel *model);
//有您喜欢回调block
@property (nonatomic, strong)NSMutableArray *guessYoulikeArr;

@property (nonatomic, copy)ShopHomeGuessyouLikeBlock shopHomeGuessyouLikeBlock;

@end

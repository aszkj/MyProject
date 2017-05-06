//
//  KJShopHomeHasyouLikeCollectionView.h
//  jingGang
//
//  Created by 张康健 on 15/8/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HasyouLikeCollecionCell.h"

@class AdRecommendModel;
//有您喜欢回调block
typedef void(^HaveyouLikeClickBlock)(AdRecommendModel *model);

@interface KJShopHomeHasyouLikeCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, copy)NSArray *hasYouLikeDataArr;

@property (nonatomic, copy)HaveyouLikeClickBlock haveyouLikeClickBlock;

@end

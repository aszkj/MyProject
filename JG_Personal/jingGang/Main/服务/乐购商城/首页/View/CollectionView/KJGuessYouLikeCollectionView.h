//
//  KJGuessYouLikeCollectionView.h
//  商品详情页collectionView测试
//
//  Created by 张康健 on 15/8/8.
//  Copyright (c) 2015年 com.organazation. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickItemCellBlock)(NSNumber *goodsID);
@interface KJGuessYouLikeCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, copy)NSArray *data;

@property (nonatomic, copy)ClickItemCellBlock clickItemCellBlock;
@end

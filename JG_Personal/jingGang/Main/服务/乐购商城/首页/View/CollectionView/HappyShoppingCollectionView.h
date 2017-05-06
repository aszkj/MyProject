//
//  HappyShoppingCollectionView.h
//  jingGang
//
//  Created by 张康健 on 15/11/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HappyShoppingFirstSectionHeaderView.h"

#define kHeaderKey @"kHeaderKey"
#define kPerfictGoodsRecommendKey @"kPerfictGoodsRecommendKey"
#define kHasYoulikeGoodsKey @"kHasYoulikeGoodsKey"

typedef void(^ClickItemBlcok)(NSNumber *ID,NSIndexPath *indexPath);
@interface HappyShoppingCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, copy)ClickItemBlcok clickItemBlcok;

@property (nonatomic, strong)HappyShoppingFirstSectionHeaderView *headerView;

@property (nonatomic, strong)NSMutableDictionary *dataDic;

- (void)backtoTop;

@end

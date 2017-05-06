//
//  DLWeekRecommendedVC.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/7/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBuyerBaseController.h"
#import "MyCommonCollectionView.h"

typedef void(^GotoShopCartPageBlock)(void);
typedef void(^GotoGoodsDetailPageBlock)(NSString *goodsId);

@interface DLWeekRecommendedVC : DLBuyerBaseController


@property (strong, nonatomic) IBOutlet MyCommonCollectionView *weekRecommendedView;
@property (nonatomic,copy)NSString *keyWords;

@property (nonatomic,copy)GotoShopCartPageBlock gotoShopCartPageBlock;

@property (nonatomic,copy)GotoGoodsDetailPageBlock gotoGoodsDetailPageBlock;
@end

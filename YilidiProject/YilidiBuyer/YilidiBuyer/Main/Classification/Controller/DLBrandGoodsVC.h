//
//  DLBrandGoodsVC.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBuyerBaseController.h"
#import "MyCommonCollectionView.h"

typedef void(^GotoShopCartPageBlock)(void);
typedef void(^GotoGoodsDetailPageBlock)(NSString *goodsId);
@interface DLBrandGoodsVC : DLBuyerBaseController
@property (strong, nonatomic) IBOutlet MyCommonCollectionView *brandGoodsCollectionView;

@property (nonatomic,copy)NSString *brandCode;

@property (nonatomic,copy)GotoShopCartPageBlock gotoShopCartPageBlock;

@property (nonatomic,copy)GotoGoodsDetailPageBlock gotoGoodsDetailPageBlock;

@end

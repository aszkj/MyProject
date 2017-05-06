//
//  DLShowFloorGoodsVC.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/9/6.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBuyerBaseController.h"
#import "MyCommonCollectionView.h"

typedef void(^GotoShopCartPageBlock)(void);
typedef void(^GotoGoodsDetailPageBlock)(NSString *goodsId);

@interface DLShowFloorGoodsVC : DLBuyerBaseController
@property (strong, nonatomic) IBOutlet MyCommonCollectionView *floorCollectionView;

@property (nonatomic,copy)NSString *keyWords;
@property (nonatomic,strong)NSString *floorId;
@property (nonatomic,copy)GotoShopCartPageBlock gotoShopCartPageBlock;

@property (nonatomic,copy)GotoGoodsDetailPageBlock gotoGoodsDetailPageBlock;
@end

//
//  DLGoodsSecondLevelClassController.h
//  YilidiBuyer
//
//  Created by mm on 16/12/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBuyerBaseController.h"
@class GoodsClassModel;
@interface DLGoodsThirdLevelClassController : DLBuyerBaseController

@property (nonatomic,strong)GoodsClassModel *goodsClassModel;

@property (nonatomic,strong)GoodsClassModel *goodsClassChildModel;


@end

//
//  DLGoodsThirdLevelClassChildController.h
//  YilidiBuyer
//
//  Created by mm on 16/12/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLSellerBaseController.h"

@class GoodsClassModel;
@interface DLGoodsThirdLevelClassController : DLSellerBaseController

@property (nonatomic,assign)NSInteger number;

@property (nonatomic,copy)NSString *classCode;

@property (nonatomic,strong)GoodsClassModel *goodsClassModel;

@property (nonatomic,strong)GoodsClassModel *goodsClassChildModel;


@end

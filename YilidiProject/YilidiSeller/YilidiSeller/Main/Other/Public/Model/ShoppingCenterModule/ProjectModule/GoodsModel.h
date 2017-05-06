//
//  GoodsModel.h
//  YilidiSeller
//
//  Created by yld on 16/5/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "GoodsBaseModel.h"

@interface GoodsModel : GoodsBaseModel

@property (nonatomic,strong)NSNumber *goodsVipPrice;

@property (nonatomic,strong)NSNumber *goodsSettlePrice;

@property (nonatomic,strong)NSNumber *goodsNumber;

/**
 *  微仓库存
 */
@property (nonatomic,strong)NSNumber *minuteResposityStock;
/**
 *  起订数量
 */
@property (nonatomic,strong)NSNumber *basicOrderNumber;

@end

@interface GoodsModel (objectGoodsModel)

+ (NSArray *)objectGoodsModelWithGoodsArr:(NSArray *)goodsArr;

+ (NSArray *)objectOrderDetailGoodsModelWithGoodsArr:(NSArray *)goodsArr;

+ (NSArray *)objectOrderSettleGoodsModelWithGoodsArr:(NSArray *)goodsArr;

@end

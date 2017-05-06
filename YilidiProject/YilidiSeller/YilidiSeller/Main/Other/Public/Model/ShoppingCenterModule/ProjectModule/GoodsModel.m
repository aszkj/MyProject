//
//  GoodsModel.m
//  YilidiSeller
//
//  Created by yld on 16/5/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.goodsId = [dic[@"saleProductId"] stringValue];
        self.goodsName = dic[@"saleProductName"];
        self.goodsOriginalPrice = dic[@"retailPrice"];
        self.goodsOriginalPrice = @(self.goodsOriginalPrice.floatValue / 1000);
        self.goodsVipPrice = dic[@"promotionalPrice"];
        self.goodsVipPrice = @(self.goodsVipPrice.floatValue / 1000);
        self.goodsThumbnail = dic[@"saleProductImageUrl"];
        self.goodsSalesVulome = dic[@"saleCount"];
        self.goodsStock = dic[@"remainCount"];
        self.goodsOnShelf = dic[@"productStatus"];
        self.goodsPurchasePrice = dic[@"basePrice"];
        self.goodsPurchasePrice = @(self.goodsPurchasePrice.floatValue / 1000);
        self.minuteResposityStock = dic[@"warehouseCount"];
        self.basicOrderNumber = dic[@"perAllotCount"];
        self.goodsStand = dic[@"saleProductSpec"];

    }
    return self;
}

@end
@implementation GoodsModel (objectGoodsModel)

+ (NSArray *)objectGoodsModelWithGoodsArr:(NSArray *)goodsArr
{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:goodsArr.count];
    for (NSDictionary *dic in goodsArr) {
        GoodsModel *model = [[GoodsModel alloc] initWithDefaultDataDic:dic];
        [tempArr addObject:model];
    }
    return [tempArr copy];
}

+ (NSArray *)objectOrderDetailGoodsModelWithGoodsArr:(NSArray *)goodsArr {
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:goodsArr.count];
    for (NSDictionary *dic in goodsArr) {
        GoodsModel *model = [[GoodsModel alloc] initWithDefaultDataDic:dic];
        model.goodsNumber = dic[@"cartNum"];
        model.goodsBuyPrice = dic[@"currentPrice"];
        model.goodsBuyPrice = @(model.goodsBuyPrice.floatValue / 1000);
        [tempArr addObject:model];
    }
    return [tempArr copy];
}

+ (NSArray *)objectOrderSettleGoodsModelWithGoodsArr:(NSArray *)goodsArr {
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:goodsArr.count];
    for (NSDictionary *dic in goodsArr) {
        GoodsModel *model = [[GoodsModel alloc] initWithDefaultDataDic:dic];
        model.goodsNumber = dic[@"settleCount"];
        model.goodsSettlePrice = dic[@"settleAmount"];
        model.goodsSettlePrice = @(model.goodsSettlePrice.floatValue / 1000);
        [tempArr addObject:model];
    }
    return [tempArr copy];


}


@end

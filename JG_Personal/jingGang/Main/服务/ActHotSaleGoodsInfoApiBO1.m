//
//  JGActivityShopModel.m
//  jingGang
//
//  Created by dengxf on 15/12/10.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "ActHotSaleGoodsInfoApiBO1.h"

@implementation ActHotSaleGoodsInfoApiBO1

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.shopId = [dic[@"id"] longLongValue];
        self.goodsMobilePrice = [dic[@"goodsMobilePrice"] floatValue];
        self.goodsCurrentPrice = [dic[@"goodsCurrentPrice"] floatValue];
        self.goodsPrice = [dic[@"goodsPrice"] floatValue];
        self.adTitle = dic[@"adTitle"];
        self.adImgPath = dic[@"adImgPath"];
        self.goodsSalenum = [dic[@"goodsSalenum"] floatValue];
        self.goodsInventory = [dic[@"goodsInventory"] floatValue];
    }
    return self;
}

@end

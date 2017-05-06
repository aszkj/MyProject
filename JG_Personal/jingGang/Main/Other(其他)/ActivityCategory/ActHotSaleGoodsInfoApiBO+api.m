//
//  ActHotSaleGoodsInfoApiBO+api.m
//  jingGang
//
//  Created by dengxf on 15/12/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "ActHotSaleGoodsInfoApiBO+api.h"

@implementation ActHotSaleGoodsInfoApiBO (api)

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.apiId = [NSNumber numberWithLong:[dic[@"id"] longLongValue]];
        self.goodsMobilePrice = [NSNumber numberWithFloat:[dic[@"goodsMobilePrice"] floatValue]];
        self.goodsCurrentPrice = [NSNumber numberWithFloat:[dic[@"goodsCurrentPrice"] floatValue]];
        self.goodsPrice = [NSNumber numberWithFloat:[dic[@"goodsPrice"] floatValue]];
        self.adTitle = dic[@"adTitle"];
        self.adImgPath = dic[@"adImgPath"];
        self.goodsSalenum = [NSNumber numberWithFloat:[dic[@"goodsSalenum"] floatValue]];
        self.goodsInventory = [NSNumber numberWithFloat:[dic[@"goodsInventory"] floatValue]];;
    }
    return self;
}

@end

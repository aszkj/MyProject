//
//  DLShopCartModel.m
//  YilidiSeller
//
//  Created by yld on 16/3/25.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import "DLShopCartModel.h"

@implementation DLShopCartModel

- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic
{
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.cartId = dic[@"cartId"];
        self.goodsId = [dic[@"goodsId"] stringValue];
        self.goodsName = dic[@"goodsName"];
        self.goodsNumber = dic[@"goodsNumber"];
        self.stock = dic[@"stock"];
        self.price = dic[@"vipPrice"];
        self.coverImg = dic[@"thumbnail"];
    }
    return self;
}

@end

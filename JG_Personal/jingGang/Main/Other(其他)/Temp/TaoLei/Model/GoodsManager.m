//
//  GoodsManager.m
//  jingGang
//
//  Created by thinker on 15/8/24.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "GoodsManager.h"
#import "Util.h"

@implementation GoodsManager

- (id)initWithGoodsInfo:(NSDictionary *)goodsCart
{
    if (self = [super init]) {
        self.goodsMainPhotoPath = goodsCart[@"goods"][@"goodsMainPhotoPath"];
//        self.goodsCurrentPrice = goodsCart[@"goods"][@"goodsShowPrice"];
        self.goodsCurrentPrice = goodsCart[@"price"];
        self.mobilePrice = goodsCart[@"goodsMobilePrice"];
        self.goodsName = goodsCart[@"goods"][@"goodsName"];
//        self.hasMobilePrice = (Boolean)goodsCart[@"goods"][@"hasMobilePrice"];
        self.hasMobilePrice = [goodsCart[@"goods"][@"hasMobilePrice"] integerValue];
        if (self.hasMobilePrice && self.mobilePrice.doubleValue != 0.0) {
            self.goodsCurrentPrice = self.mobilePrice;
        }
        
        self.goodscount = goodsCart[@"count"];
        self.goodsSpecInfo = [Util removeHTML2:goodsCart[@"specInfo"]];
        self.exchangeIntegral = goodsCart[@"exchangeIntegral"];
        if (self.exchangeIntegral.integerValue != 0) {
            self.integralPrice = goodsCart[@"goodsIntegralPrice"];
        }
        self.gcId = goodsCart[@"id"];
    }

    return self;
}

- (NSString *)jifengDescrition {
    if (_exchangeIntegral.integerValue != 0) {
        
        return [NSString stringWithFormat:@"使用%lu积分兑购,兑购商品价格为¥%lu元",[_exchangeIntegral integerValue],[_integralPrice integerValue] ];
    } else {
        return nil;
    }
    
}


@end

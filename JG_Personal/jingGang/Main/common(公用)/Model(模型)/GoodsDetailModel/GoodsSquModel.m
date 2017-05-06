//
//  GoodsSquModel.m
//  jingGang
//
//  Created by 张康健 on 15/8/25.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "GoodsSquModel.h"

@implementation GoodsSquModel

-(id)initWithJSONDic:(NSDictionary *)json {
    
    self = [super initWithJSONDic:json];
    
    if (self) {
        //squ中如果有手机专享价，显示手机专享价,否则显示price
        if (_mobilePrice.integerValue > 0) {
            _actualPrice = _mobilePrice;
            _hasMobilePrice = YES;
        }else{
            _actualPrice = _price;
        }
        
        
        //判断有没有积分兑换价,一般有积分的话肯定是有积分兑换价的
        if (_integralCount.integerValue > 0 ) {
            _hasIntegralPrice = YES;
            
            if (_integralPrice.integerValue > 0) {//并且积分兑换价大于0
                _integralAndIntegralPriceStr = [NSString stringWithFormat:@"￥%ld+%ld积分兑换",_integralPrice.integerValue,_integralCount.integerValue];
            }else{//有积分，没有积分兑换价的情况
                _integralAndIntegralPriceStr = [NSString stringWithFormat:@"%ld积分兑换",_integralCount.integerValue];
            }
        }
        
        
        NSLog(@"库存----    %ld",_count.integerValue);
    }
    return self;
}

@end

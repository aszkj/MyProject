//
//  GoodsDetailModel.m
//  jingGang
//
//  Created by 张康健 on 15/8/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "GoodsDetailModel.h"

@implementation GoodsDetailModel

-(id)initWithJSONDic:(NSDictionary *)json{
    
    self = [super initWithJSONDic:json];
    if (self) {
        CGFloat mobilePrice =(CGFloat) _mobilePrice.floatValue;
        //有手机专享价，并且手机专享价不为0
        if (self.hasMobilePrice.integerValue && mobilePrice > 0) {//有手机专享价
            _actualPrice = self.mobilePrice.floatValue;
        }else{
            _actualPrice = self.goodsShowPrice.floatValue;
        }
        NSMutableArray *cationListArr = [NSMutableArray arrayWithCapacity:_cationList.count];
        for (NSDictionary *dic in _cationList) {
            [cationListArr addObject:dic[@"name"]];
        }
        _cationNameStr = [cationListArr componentsJoinedByString:@" "];
    }
    return  self;
}

@end

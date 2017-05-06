//
//  RecommendGoods+OtherProperty.m
//  jingGang
//
//  Created by 张康健 on 15/11/20.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "RecommendGoods+OtherProperty.h"

@implementation RecommendGoods (OtherProperty)

-(CGFloat )getActualPrice {
    
    CGFloat mobilePrice =(CGFloat) self.mobilePrice.floatValue;
    CGFloat actualPrice = 0.00;
    //有手机专享价，并且手机专享价不为0
    if (self.hasMobilePrice.integerValue && mobilePrice > 0) {//有手机专享价
        actualPrice = self.mobilePrice.floatValue;
    }else{
        actualPrice = self.storePrice.floatValue;
    }

    return actualPrice;
}

@end

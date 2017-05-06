//
//  WSJShoppingCartInfoModel.m
//  jingGang
//
//  Created by thinker on 15/8/14.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJShoppingCartInfoModel.h"

@implementation WSJShoppingCartInfoModel


- (void)setSpecInfo:(NSString *)specInfo
{
    NSArray *array = [specInfo componentsSeparatedByString:@"<br>"];
    if (array.count >= 2 ) {
        _specInfo = [NSString stringWithFormat:@"%@  %@",array[0],array[1]];
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"id=%@  image= %@  name=%@  specInfo=%@ goodsCurrentPrice=%@  hasMobilePrice=%@  count=%@",self.ID,self.imageURL,self.name,self.specInfo,self.goodsCurrentPrice,self.hasMobilePrice,self.count];
}

@end

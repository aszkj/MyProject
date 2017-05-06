//
//  IntegralListBO+InitExtend.m
//  jingGang
//
//  Created by 张康健 on 15/12/25.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "IntegralListBO+InitExtend.h"

@implementation IntegralListBO (InitExtend)

- (instancetype)initWithIntegralListDict:(NSDictionary *)listDict {
    if (self = [super init]) {
        self.apiId = [NSNumber numberWithInteger:[listDict[@"id"] integerValue]];
        self.igGoodsIntegral = listDict[@"igGoodsIntegral"];
        self.igGoodsName = listDict[@"igGoodsName"];
        self.igGoodsImg = listDict[@"igGoodsImg"];
    }
    return self;
}

@end

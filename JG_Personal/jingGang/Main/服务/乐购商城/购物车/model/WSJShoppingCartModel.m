//
//  WSJShoppingCartModel.m
//  jingGang
//
//  Created by thinker on 15/8/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//


#import "WSJShoppingCartModel.h"

@implementation WSJShoppingCartModel

- (instancetype)init
{
    self = [super init];
    if ( self)
    {
        self.data = [NSMutableArray array];
        self.isAll = NO;
        self.edit = NO;
    }
    return  self;
}
- (void)setNoSelect
{
    _isAll = NO;
}

- (void)setIsAll:(BOOL)isAll
{
    _isAll = isAll;
    for (WSJShoppingCartInfoModel *model in self.data)
    {
        model.isSelect = isAll;
    }
}


@end

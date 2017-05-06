//
//  NSArray+extend.m
//  YilidiBuyer
//
//  Created by yld on 16/4/26.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "NSArray+extend.h"


@implementation NSArray (extend)

-(NSArray *)transferDicArrToModelArrWithModelClass:(Class)modelClass{
    if (self.count <= 0) {
        return nil;
    }
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:self.count];
    for (NSDictionary *dic in self) {
        //创建一个该类的对象
        id model = [modelClass alloc];
        SEL sle = @selector(initWithDefaultDataDic:);
        //拿到该对象该方法的首地址
        IMP im = [model methodForSelector:sle];
        //用同样类型的函数指针（必须相同类型）指向该函数首地址，
        id(*p)(id,SEL,NSDictionary *) = (id(*)(id,SEL,NSDictionary *))im;
        //用函数指针的方式去调用
        [tempArr addObject:p(model,sle,dic)];
    }
    return [tempArr copy];
}


@end

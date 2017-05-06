//
//  GoodsClassModel.m
//  YilidiBuyer
//
//  Created by mm on 16/12/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "GoodsClassModel.h"
#import "NSArray+extend.h"

@implementation GoodsClassModel

- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.classCode = dic[@"classCode"];
        self.className = dic[@"className"];
        self.classImageUrl = dic[@"classImageUrl"];
        self.subClassList = dic[@"subClassList"];
        if (isEmpty(self.subClassList)) {
            self.subClassList = @[];
        }
        self.subClassList = [self.subClassList transferDicArrToModelArrWithModelClass:[self class]];
        
    }
    return self;
}


@end

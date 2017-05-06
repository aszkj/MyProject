//
//  DLShareModel.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/10/13.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLShareModel.h"

@implementation DLShareModel
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic{

    if (self) {
        self.imageUrl = dic[@"imageUrl"];
        self.phoneNum = dic[@"phone"];
        self.count = dic[@"count"];
    }
    return self;
}
@end


@implementation DLShareModel(setShareModel)

+ (NSArray*)objectShareModelWithArr:(NSArray*)array {
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        DLShareModel *model = [[DLShareModel alloc]initWithDefaultDataDic:dic];
        [arr addObject:model];
    }
    
    return [arr mutableCopy];
    
}
@end

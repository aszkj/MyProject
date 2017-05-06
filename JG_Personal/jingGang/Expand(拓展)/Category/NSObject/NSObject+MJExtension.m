//
//  NSObject+MJExtension.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/12.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "NSObject+MJExtension.h"
#import "MJExtension.h"

@implementation NSObject (MJExtension)

+ (NSArray *)JGObjectArrWihtKeyValuesArr:(NSArray *)keyValuesArr {
    if (![keyValuesArr count] > 0) {
        return nil;
    }
    
    [self setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"apiId":@"id"};
    }];
    
    return [self objectArrayWithKeyValuesArray:keyValuesArr];

}

+ (instancetype)JGObjectvalueWithKeyValue:(NSDictionary *)dic {
    if (dic == nil) {
        return nil;
    }
    
    [self setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"apiId":@"id"};
    }];
    
    return [self objectWithKeyValues:dic];
}



@end

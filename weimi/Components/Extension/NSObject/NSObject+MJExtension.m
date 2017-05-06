//
//  NSObject+MJExtension.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/12.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "NSObject+MJExtension.h"

@implementation NSObject (MJExtension)

+ (NSArray *)JGObjectArrWihtKeyValuesArr:(NSArray *)keyValuesArr {
    
    [self setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"apiId":@"id"};
    }];
    
    return [self objectArrayWithKeyValuesArray:keyValuesArr];

}



@end

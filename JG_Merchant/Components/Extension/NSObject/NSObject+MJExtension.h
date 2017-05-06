//
//  NSObject+MJExtension.h
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/12.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MJExtension)

+ (NSArray *)JGObjectArrWihtKeyValuesArr:(NSArray *)keyValuesArr;

+ (instancetype)JGObjectvalueWithKeyValue:(NSDictionary *)dic;

@end

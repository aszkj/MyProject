//
//  NSMutableDictionary+safeSet.m
//  YilidiBuyer
//
//  Created by mm on 16/12/21.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "NSMutableDictionary+safeSet.h"

@implementation NSMutableDictionary (safeSet)

- (void)saveSetObject:(id)object forKey:(NSString *)key {
    
    if ([object isKindOfClass:[NSNumber class]]) {
        if (![(NSNumber *)object longLongValue]) {
            return;
        }
    }
    
    if (object) {
        [self setObject:object forKey:key];
    }
   
}

@end

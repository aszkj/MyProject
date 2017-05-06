//
//  NSString+Safe.m
//  JDBClient
//
//  Created by You Tu on 15/1/6.
//  Copyright (c) 2015年 JDB. All rights reserved.
//

#import "NSString+Safe.h"

@implementation NSString (Safe)

- (unichar)xf_safeCharacterAtIndex:(NSUInteger)index
{
    if (index >= self.length) {
        return '\0';
    }
    return [self characterAtIndex:index];
}

- (NSString *)xf_safeSubstringToIndex:(NSUInteger)index
{
    if(index >= self.length) {
        return nil;
    }
    return [self substringToIndex:index];
}

- (NSString *)xf_safeSubstringFromIndex:(NSUInteger)index
{
    if(index >= self.length) {
        return nil;
    }
    return [self substringFromIndex:index];
}

@end

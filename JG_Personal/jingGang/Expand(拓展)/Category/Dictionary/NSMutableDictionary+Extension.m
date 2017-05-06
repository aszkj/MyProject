//
//  NSMutableDictionary+MDP.m
//  MDPFramework
//
//  Created by 谢进展 on 14-4-6.
//  Copyright (c) 2014年 谢进展. All rights reserved.
//

#import "NSMutableDictionary+Extension.h"
#import <UIKit/UIGeometry.h>


@implementation NSMutableDictionary (Extension)

@end


@implementation NSMutableDictionary (CGStructs)

- (void)xf_setPoint:(CGPoint)value forKey:(NSString *)key
{
    NSValue *storeValue = [NSValue valueWithCGPoint:value];
    [self setValue:storeValue forKey:key];
}

- (void)xf_setSize:(CGSize)value forKey:(NSString *)key
{
    NSValue *storeValue = [NSValue valueWithCGSize:value];
    [self setValue:storeValue forKey:key];
}

- (void)xf_setRect:(CGRect)value forKey:(NSString *)key
{
    NSValue *storeValue = [NSValue valueWithCGRect:value];
    [self setValue:storeValue forKey:key];
}

- (void)xf_setAffineTransform:(CGAffineTransform )value forKey:(NSString *)key
{
    NSValue *storeValue = [NSValue valueWithCGAffineTransform:value];
    [self setValue:storeValue forKey:key];
}

@end


@implementation NSMutableDictionary (Safe)

- (void)xf_safeSetObject:(id)anObject forKey:(id < NSCopying >)aKey
{
    if (!anObject || !aKey) {
        return ;
    }
    
    [self setObject:anObject forKey:aKey];
}

- (void)xf_safeSetObject:(id)object forKeyedSubscript:(id < NSCopying >)aKey
{
    if (!object || !aKey) {
        return ;
    }
    
    [self setObject:object forKeyedSubscript:aKey];
}

- (void)xf_safeRemoveObjectForKey:(id)aKey
{
    if(!aKey)
        return;
    
    [self removeObjectForKey:aKey];
}

@end
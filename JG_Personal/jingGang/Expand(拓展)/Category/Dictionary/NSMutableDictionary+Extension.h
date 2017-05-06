//
//  NSMutableDictionary+MDP.h
//  MDPFramework
//
//  Created by 谢进展 on 14-4-6.
//  Copyright (c) 2014年 谢进展. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSMutableDictionary (Extension)

@end


@interface NSMutableDictionary (CGStructs)

- (void)xf_setPoint:(CGPoint)value forKey:(NSString *)key;
- (void)xf_setSize:(CGSize)value forKey:(NSString *)key;
- (void)xf_setRect:(CGRect)value forKey:(NSString *)key;
- (void)xf_setAffineTransform:(CGAffineTransform )value forKey:(NSString *)key;

@end

@interface NSMutableDictionary (Safe)

- (void)xf_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey;

- (void)xf_safeSetObject:(id)object forKeyedSubscript:(id < NSCopying >)aKey;

- (void)xf_safeRemoveObjectForKey:(id)aKey;


@end
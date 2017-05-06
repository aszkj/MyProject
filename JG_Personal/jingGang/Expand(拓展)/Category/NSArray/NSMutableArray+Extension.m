//
//  NSMutableArray+MDP.m
//  MDPFramework
//
//  Created by 谢进展 on 14-4-6.
//  Copyright (c) 2014年 谢进展. All rights reserved.
//

#import "NSMutableArray+Extension.h"
#import "NSArray+Extension.h"

@implementation NSMutableArray (Extension)

- (void)xf_safeAddObject:(id)obj
{
    if (obj) {
        [self addObject:obj];
    }
}

- (void)xf_safeAddObjectsFromArray:(NSArray *)otherArray
{
    if (otherArray) {
        [self addObjectsFromArray:otherArray];
    }
}

- (void)xf_safeInsertObject:(id)obj atIndex:(NSUInteger)index
{
    if (obj) {
        if (index < self.count) {
            [self insertObject:obj atIndex:index];
        } else if(index == self.count) {
            [self addObject:obj];
        }
    }
}

- (void)xf_safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
    if (objects && indexes) {
        [self insertObjects:objects atIndexes:indexes];
    }
}

- (void)xf_safeRemoveLastObject
{
    if (self.count > 0) {
        [self removeLastObject];
    }
}

- (void)xf_safeRemoveObject:(id)anObject inRange:(NSRange)aRange
{
    if (anObject && (aRange.location + aRange.length) <= self.count) {
        [self removeObject:anObject inRange:aRange];
    }
}
- (void)xf_safeRemoveObjectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
}

- (void)xf_safeRemoveObjectIdenticalTo:(id)anObject inRange:(NSRange)aRange
{
    if (anObject && (aRange.location + aRange.length) <= self.count) {
        [self removeObjectIdenticalTo:anObject inRange:aRange];
    }
}
- (void)xf_safeRemoveObjectsAtIndexes:(NSIndexSet *)indexes
{
    if (indexes) {
        [self removeObjectsAtIndexes:indexes];
    }
}
- (void)xf_safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (index < self.count && anObject) {
        [self replaceObjectAtIndex:index withObject:anObject];
    }
}

- (void)xf_safeReplaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects
{
    if (indexes && objects && indexes.count == objects.count ) {
        [self replaceObjectsAtIndexes:indexes withObjects:objects];
    }
}

- (void)xf_safeSetObject:(id)anObject atIndexedSubscript:(NSUInteger)index
{
    if (anObject && index <= self.count) {
        [self xf_safeSetObject:anObject atIndexedSubscript:index];
    }
}

@end

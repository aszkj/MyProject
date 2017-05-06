//
//  NSMutableArray+MDP.h
//  MDPFramework
//
//  Created by 谢进展 on 14-4-6.
//  Copyright (c) 2014年 谢进展. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Extension)

- (void)xf_safeAddObject:(id)obj;
- (void)xf_safeAddObjectsFromArray:(NSArray *)otherArray;
- (void)xf_safeInsertObject:(id)obj atIndex:(NSUInteger)index;
- (void)xf_safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes;
- (void)xf_safeRemoveLastObject;
- (void)xf_safeRemoveObject:(id)anObject inRange:(NSRange)aRange;
- (void)xf_safeRemoveObjectAtIndex:(NSUInteger)index;
- (void)xf_safeRemoveObjectIdenticalTo:(id)anObject inRange:(NSRange)aRange;
- (void)xf_safeRemoveObjectsAtIndexes:(NSIndexSet *)indexes;
- (void)xf_safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
- (void)xf_safeReplaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects;
- (void)xf_safeSetObject:(id)anObject atIndexedSubscript:(NSUInteger)index;


@end

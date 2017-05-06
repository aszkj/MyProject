//
//  NSArray+MDP.h
//  MDPFramework
//
//  Created by 谢进展 on 14-4-6.
//  Copyright (c) 2014年 谢进展. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

//随机
- (NSArray *)xf_randomArray;
- (NSArray *)xf_randomArrayWithLimit:(NSUInteger)itemLimit;
- (id)xf_randomObject;

//安全
- (id)xf_safeObjectAtIndex:(NSUInteger)index;

// 数组转换为json
- (NSString*)xf_jsonValue;

@end

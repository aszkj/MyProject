//
//  NSArray+subArrToIndex.m
//  YilidiSeller
//
//  Created by yld on 16/4/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "NSArray+subArrToIndex.h"

@implementation NSArray (subArrToIndex)

- (NSArray *)subArrayToIndex:(NSInteger)index
{
    NSInteger toIndex = (index <= self.count) ? (index) : (self.count);
    
    return [self subarrayWithRange:NSMakeRange(0, toIndex)];

}

@end

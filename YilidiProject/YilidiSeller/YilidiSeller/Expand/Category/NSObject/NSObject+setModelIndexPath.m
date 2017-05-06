//
//  NSObject+setModelIndexPath.m
//  YilidiSeller
//
//  Created by yld on 16/3/26.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import "NSObject+setModelIndexPath.h"

@implementation NSObject (setModelIndexPath)

-(void)setIndexPathInselfContainer
{
    
    if ([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSMutableArray class]]) {
        [self _setIndexPathforArrSelf];
    }else if ([self isKindOfClass:[NSDictionary class]] || [self isKindOfClass:[NSMutableDictionary class]]) {
        [self _setIndexPathforDictionarySelf];
    }
    
}

-(void)_setIndexPathforArrSelf{
    
    NSArray *arr = (NSArray *)self;
    for (NSInteger i=0; i<arr.count; i++) {
        id model = arr[i];
        if ([model respondsToSelector:@selector(setModelAtIndexPath:)]) {
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [model setValue:newIndexPath forKey:@"modelAtIndexPath"];

        }
    }
}

-(void)_setIndexPathforDictionarySelf{
    
    NSDictionary *dictionary = (NSDictionary *)self;
    NSArray *keys = dictionary.allKeys;
    for (NSInteger keyNumber; keyNumber<keys.count; keyNumber ++) {
        id value = dictionary[keys[keyNumber]];
        if ([value isMemberOfClass:[NSArray class]]) {
            NSArray *arr = (NSArray *)value;
            for (NSInteger arrNumber=0; arrNumber<arr.count; arrNumber ++) {
                id model = arr[arrNumber];
                if ([model respondsToSelector:@selector(setModelAtIndexPath:)]) {
                    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:arrNumber inSection:keyNumber];
                    [model setValue:newIndexPath forKey:@"modelAtIndexPath"];
                }
            }
        }
    }

    
}


@end

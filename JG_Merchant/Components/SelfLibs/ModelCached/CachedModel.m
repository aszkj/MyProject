//
//  CCWModelCached.m
//  jingGang
//
//  Created by zhupeng on 15-9-1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.

#import "CachedModel.h"
#import <regex.h>
#import <string.h>
#include <stdint.h>
#import <CommonCrypto/CommonDigest.h>

#pragma mark --
#pragma mark NSString 

@implementation CachedModel
+ (id)SObject {
    static CachedModel *__AppStaticCacheModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __AppStaticCacheModel = [[[self class] alloc] init];
    });
    return __AppStaticCacheModel;
}

#pragma mark ---
- (BaseModel *)modelCacheForKey:(NSString *)key {
    if (key.length==0) return nil;

    NSDictionary *dic = [self valueForKey:key];    
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        NSString *className = [dic valueForKey:MODEL_KEY___CLASSNAME];
        if (className) {
            Class class = NSClassFromString(className);
            if (class) {
                return [(BaseModel *)[class alloc] initWithDictionary:dic];
            }
        }else {
//            return [(CWModel *)[CWModel alloc] initWithDictionary:dic];
            return nil;
        }
    }
    return nil;
}

- (void)setModelCache:(BaseModel *)model forKey:(NSString *)key {
    if (key.length==0) return;
    if (model == nil) {
        [self deleteForKey:key];
    }else {
        if ([model isKindOfClass:[BaseModel class]]) {
            [model toDictionaryWithBlock:^(NSMutableDictionary *dic){
                if (key != nil && dic != nil) {
                    [self setValue:dic forKey:key];
                }
            }];
            
        }else {
            NSLog(@"%@ 该模型不支持缓存操作,或者数据为空",key);
        }
    }
}

-(void)delCacheForKey:(NSString *)key
{
    [[CachedModel SObject] deleteForKey:key];
}

#pragma mark  static
+ (BaseModel *)modelCacheForKey:(NSString *)key {
    return [[CachedModel SObject] modelCacheForKey:key];
}

+ (void)setModelCache:(BaseModel *)model forKey:(NSString *)key {
    [[CachedModel SObject] setModelCache:model forKey:key];
}

+ (void)clearCache {
    [[CachedModel SObject] clearCache];
}

+ (void)deleteCacheForKey:(NSString *)key {
    [[CachedModel SObject] delCacheForKey:key];
}

+ (void)clearCacheAll {
    [[CachedModel SObject] deleteAllCache];
}

@end

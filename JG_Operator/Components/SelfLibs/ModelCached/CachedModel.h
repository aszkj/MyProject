//
//  CCWModelCached.h
//  jingGang
//
//  Created by zhupeng on 15-9-1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.

#import "ModelManager.h"
#import "BaseModel.h"

@interface CachedModel : ModelManager
-(void)delCacheForKey:(NSString *)key;
- (BaseModel *)modelCacheForKey:(NSString *)key;
- (void)setModelCache:(BaseModel *)model forKey:(NSString *)key;

#pragma mark  static
+ (BaseModel *)modelCacheForKey:(NSString *)key;
+ (void)setModelCache:(BaseModel *)model forKey:(NSString *)key;
+ (void)deleteCacheForKey:(NSString *)key;
+ (void)clearCache;
+ (void)clearCacheAll;
@end

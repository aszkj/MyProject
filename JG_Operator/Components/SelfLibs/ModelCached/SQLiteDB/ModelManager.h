//
//  ModelManager.h
//  jingGang
//
//  Created by zhupeng on 15-9-1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.

#import "Share.h"
#import "FMDatabase.h"

typedef void(^ModelLoadCompleted)(NSDictionary *value);

@interface ModelManager : Share  {
@package
    NSMutableDictionary *_cacheQueue;
    FMDatabase          *_db;
    NSString            *_dbPath;
}
- (void)valueForKey:(NSString *)key completed:(ModelLoadCompleted)completed;
- (NSDictionary *)valueForKey:(NSString *)key;
- (void)setValue:(NSDictionary *)value forKey:(NSString *)key;
- (void)deleteForKey:(NSString *)key;
- (void)clearCache;
- (void)deleteAllCache;
@end

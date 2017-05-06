//
//  ModelManager.m
//  jingGang
//
//  Created by zhupeng on 15-9-1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.

#import "ModelManager.h"
#import "FMDatabase.h"
#import "UserController.h"

@implementation ModelManager
+ (id)SObject {
    static ModelManager *__AppStaticMManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __AppStaticMManager = [[[self class] alloc] init];
    });
    return __AppStaticMManager;
    
    
}

- (void)dealloc {

}

- (id)init {
    self = [super init];
    if (self) {
        NSString *dbPaths = [NSString stringWithFormat:@"%@/%@.db/cache",@"Documents",[[UserController SObject] getCurrentUserId]];
        NSString *dbPath = [[NSHomeDirectory() stringByAppendingPathComponent:dbPaths]
                            stringByAppendingPathComponent:@"__AppModelCache.sqlite"];
        
        _dbPath = [dbPath copy];
        
        NSFileManager *fp = [NSFileManager defaultManager];
        if (![fp fileExistsAtPath:dbPath]) {
            NSString *sqlPath = [[NSBundle mainBundle] pathForResource:@"__AppModelDb" ofType:@"sql"];
            if ([fp fileExistsAtPath:sqlPath]) {
                NSString *sqls = [NSString stringWithContentsOfFile:sqlPath 
                                                           encoding:NSUTF8StringEncoding 
                                                              error:nil];
                NSArray *items = [sqls componentsSeparatedByString:@"\n"];
                FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
                if ([db open]) {
                    for (NSString *query in items) {
                        [db executeUpdate:query];
                    }
                    [db close];
                }
            }
        }
        _db = [FMDatabase databaseWithPath:dbPath];
        _cacheQueue = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSDictionary *)valueForKey:(NSString *)key {
    NSDictionary *value = nil;    
    if (_cacheQueue.count>0) {
        value = [_cacheQueue objectForKey:key];
    }
    if (value == nil) {
        if ([_db open]) {
            FMResultSet *rs = [_db executeQuery:@"SELECT value FROM modelCache WHERE key=?",key];
            if ([rs next]) {
                NSData *dvalue = [rs dataForColumn:@"value"];
                NSPropertyListFormat format;
                value = [NSPropertyListSerialization propertyListFromData:dvalue
                                                         mutabilityOption:NSPropertyListMutableContainers
                                                                   format:&format
                                                         errorDescription:nil];
            }
            [_db close];
        }
    }
    return value;
}

- (void)valueForKey:(NSString *)key completed:(ModelLoadCompleted)completed {
    NSDictionary *value = nil;    
    if (_cacheQueue.count>0) {
        value = [_cacheQueue objectForKey:key];
        if (value) completed(value);
        return;
    }
    
    NSString *dbPath = _dbPath;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
        NSDictionary *value = nil;
        if ([db open]) {
            FMResultSet *rs = [_db executeQuery:@"SELECT value FROM modelCache WHERE key=?",key];
            if ([rs next]) {
                NSData *dvalue = [rs dataForColumn:@"value"];
                NSPropertyListFormat format;
                value = [NSPropertyListSerialization propertyListFromData:dvalue
                                                         mutabilityOption:NSPropertyListMutableContainers
                                                                   format:&format
                                                         errorDescription:nil];
            }
            [_db close];
        }
        completed(value);
    });
}

- (void)setValue:(NSDictionary *)value forKey:(NSString *)key {
    if (value == nil || key == nil) return;
    
//    NSDictionary *mvalue = [_cacheQueue objectForKey:key];
//    if (mvalue == nil) {
//        [_cacheQueue setObject:value forKey:key];
//    }
    

    if (value) {
        [_cacheQueue setObject:value forKey:key];
    }
    
    NSString *dbPath = _dbPath;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *errorStr = nil;
        NSData *dataValue = [NSPropertyListSerialization dataFromPropertyList:value
                                                                       format:NSPropertyListXMLFormat_v1_0
                                                             errorDescription:&errorStr];
        if (dataValue) {
            FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
            if ([db open]) {
                BOOL isOk =[db executeUpdate:@"INSERT OR REPLACE INTO modelCache ('key','value') VALUES (?,?)",
                 key,dataValue];
                if (isOk == NO) {
                    NSLog(@"保存Model 失败! key=%@",key);
                }
                [db close];
            }
        }
    });
}

- (void)deleteForKey:(NSString *)key {
    if (key.length==0) return;
    [_cacheQueue removeObjectForKey:key];
    NSString *dbPath = _dbPath;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
        if ([db open]) {
            BOOL isOk =[db executeUpdate:@"DELETE FROM modelCache where key=?",key];
            if (isOk == NO) {
                NSLog(@"删除Model 失败! key=%@",key);
            }
            [db close];
        }
    });
}


- (void)deleteAllCache{
    [_cacheQueue removeAllObjects];
    NSString *dbPath = _dbPath;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
        if ([db open]) {
            BOOL isOk =[db executeUpdate:@"DELETE FROM modelCache"];
            if (isOk == NO) {
                NSLog(@"删除ModelAll 失败!");
            }
            [db close];
        }
    });
}

- (void)clearCache {
    [_cacheQueue removeAllObjects];
}
@end

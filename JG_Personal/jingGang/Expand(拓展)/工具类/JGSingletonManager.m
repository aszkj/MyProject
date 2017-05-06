//
//  JGSingletonManager.m
//  jingGang
//
//  Created by dengxf on 16/1/25.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGSingletonManager.h"

@interface JGSingletonManager ()
{
    NSMutableDictionary *sharedInstanceDictionary;
    NSRecursiveLock *singletonLock;
}

@end

@implementation JGSingletonManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        sharedInstanceDictionary = [NSMutableDictionary dictionary];
        singletonLock = [[NSRecursiveLock alloc] init];
    }
    return self;
}

+ (JGSingletonManager *)sharedManager {
    static JGSingletonManager *factory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        factory = [[JGSingletonManager alloc] init];
    });
    return factory;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)sharedInstanceFor:(Class)aClass {
    NSString *key = NSStringFromClass(aClass);
    [self->singletonLock lock];
    id obj = nil;
    if (key) {
        obj = [self->sharedInstanceDictionary objectForKey:key];
        if (!obj) {
            obj = [[aClass alloc] init];
            [self->sharedInstanceDictionary setObject:obj forKey:key];
        }
    }
    [self->singletonLock unlock];
    return obj;
}

- (id)sharedInstanceFor:(Class)aClass category:(NSString *)key
{
    NSString *className = NSStringFromClass(aClass);
    NSString *classKey = [NSString stringWithFormat:@"%@-%@",className,key];
    
    [self->singletonLock lock];
    
    id obj = nil;
    if (classKey) {
        obj = [self->sharedInstanceDictionary objectForKey:classKey];
        if (!obj) {
            obj = [[aClass alloc] init];
            [self->sharedInstanceDictionary setObject:obj forKey:classKey];
        }
    }
    [self->singletonLock unlock];
    
    return obj;
}

- (void)destroySharedInstanceFor:(Class)aClass
{
    NSString *key = NSStringFromClass(aClass);
    
    [self->singletonLock lock];
    
    id obj = nil;
    if (key) {
        obj = [self->sharedInstanceDictionary objectForKey:key];
        if (obj) {
            [self->sharedInstanceDictionary removeObjectForKey:key];
        }
    }
    [self->singletonLock unlock];
}

- (void)destroySharedInstanceFor:(Class)aClass category:(NSString*)key
{
    NSString *className = NSStringFromClass(aClass);
    NSString *classKey = [NSString stringWithFormat:@"%@-%@",className,key];
    
    [self->singletonLock lock];
    
    id obj = nil;
    if (classKey) {
        obj = [self->sharedInstanceDictionary objectForKey:classKey];
        if (obj) {
            [self->sharedInstanceDictionary removeObjectForKey:classKey];
        }
    }
    [self->singletonLock unlock];
}


@end

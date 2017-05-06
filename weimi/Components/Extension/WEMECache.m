//
//  WEMECache.m
//  weimi
//
//  Created by ray on 16/1/20.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "WEMECache.h"


@implementation WEMECache

static NSString *USERCACHENAME = @"UserCache";
static NSString *FEEDCACHENAME = @"FeedCache";
static NSString *REPLAYCACHENAME = @"ReplayCache";

+ (YYCache *)userCache
{
    static YYCache *userCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userCache = [[YYCache alloc] initWithName:USERCACHENAME];
        [userCache.diskCache removeAllObjects];
    });
    return userCache;
}

+ (YYCache *)FeedCache
{
    static YYCache *FeedCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FeedCache = [[YYCache alloc] initWithName:FEEDCACHENAME];
    });
    return FeedCache;
}

+ (YYCache *)ReplayCache
{
    static YYCache *ReplayCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ReplayCache = [[YYCache alloc] initWithName:REPLAYCACHENAME];
    });
    return ReplayCache;
}


@end

//
//  WEMECache.h
//  weimi
//
//  Created by ray on 16/1/20.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYCache.h"

@interface WEMECache : NSObject

+ (YYCache *)userCache;
+ (YYCache *)FeedCache;
+ (YYCache *)ReplayCache;

@end

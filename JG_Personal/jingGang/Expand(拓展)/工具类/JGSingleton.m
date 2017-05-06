//
//  JGSingleton.m
//  jingGang
//
//  Created by dengxf on 16/1/25.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGSingleton.h"
#import "JGSingletonManager.h"

@implementation JGSingleton
+ (instancetype)sharedInstance {
    return [[JGSingletonManager sharedManager] sharedInstanceFor:[self class]];
}

+ (void)destorySharedInstance {
    return [[JGSingletonManager sharedManager] destroySharedInstanceFor:[self class]];
}
@end

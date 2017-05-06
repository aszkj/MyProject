//
//  JGActivityTools.m
//  jingGang
//
//  Created by dengxf on 15/12/9.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGActivityTools.h"

static JGActivityTools *instance = nil;

@implementation JGActivityTools

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[self alloc] init];
            instance.shouldShowActivity = YES;
        }
    });
    return instance;
}



+ (void)mainPushToActivityView {
    instance.isPush = YES;
}

+ (void)activityPopToMainController {
    instance.isPop = NO;
    instance.shouldShowActivity = NO;
}

+ (void)switchTabBarAction {
    instance.shouldShowActivity = YES;
}


@end

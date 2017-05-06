//
//  DebugLogger.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/1.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "DebugSet.h"
#import <FLEX/FLEXManager.h>
#import "CustomDDLogFormatter.h"

@implementation DebugSet

+ (void)setLogger
{
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:nil forFlag:DDLogFlagInfo];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor yellowColor] backgroundColor:nil forFlag:DDLogFlagWarning];

    [[DDTTYLogger sharedInstance] setLogFormatter:[[CustomDDLogFormatter alloc] init]];
    
    DDLogVerbose(@"Meet George Jetson");
    DDLogError(@"error appear");
    DDLogInfo(@"info appear");
    DDLogWarn(@"warning appear");
    DDLogDebug(@"debug appear");
}

+ (void)showExplor
{
#ifdef DEBUG
    [[FLEXManager sharedManager] showExplorer];
#endif

}

+ (void)hiddeExplor
{
#ifdef DEBUG
    [[FLEXManager sharedManager] hideExplorer];
#endif
}

@end

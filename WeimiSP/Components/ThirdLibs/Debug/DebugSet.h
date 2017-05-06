//
//  DebugLogger.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/1.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DebugSet : NSObject

/**
 *  设置CocoaLumberjack logger
 */
+ (void)setLogger;
/**
 *  显示FLEX
 */
+ (void)showExplor;
/**
 *  隐藏FLEX
 */
+ (void)hiddeExplor;


@end

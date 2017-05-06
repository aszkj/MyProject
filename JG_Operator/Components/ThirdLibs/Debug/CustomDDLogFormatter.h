//
//  CustomDDLogFormatter.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/1.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDLog.h"

@interface CustomDDLogFormatter : NSObject <DDLogFormatter>{
    int atomicLoggerCount;
    NSDateFormatter *threadUnsafeDateFormatter;
}

@end

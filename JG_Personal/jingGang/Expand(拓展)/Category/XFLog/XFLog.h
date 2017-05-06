//
//  XFLog.h
//  XFTest
//
//  Created by xiejinzhan on 14-8-6.
//  Copyright (c) 2014年 jiuding. All rights reserved.
//

#import <Foundation/Foundation.h>


#ifndef XFLog_H

#define XFLog_H

#ifdef DEBUG

#define XFLogDebug(fmt...) \
__XFLog(XFLogLevelDebug, __FILE__, __LINE__, __func__, 0, [NSString stringWithFormat:fmt])

#define XFLogTrace(fmt...) \
__XFLog(XFLogLevelTrace, __FILE__, __LINE__, __func__, 0, [NSString stringWithFormat:fmt])

#else

#define XFLogDebug(fmt...) do{}while(0)
#define XFLogTrace(fmt...) do{}while(0)

#endif

#define XFLogWarning(error_no, fmt...) \
__XFLog(XFLogLevelWarning, __FILE__, __LINE__, __func__, error_no, [NSString stringWithFormat:fmt])

#define XFLogFatal(error_no, fmt...) \
__XFLog(XFLogLevelFatal, __FILE__, __LINE__, __func__, error_no, [NSString stringWithFormat:fmt])


typedef enum _XFLogLevel {
    XFLogLevelDebug = 0,
    XFLogLevelTrace,
    XFLogLevelWarning,
    XFLogLevelFatal
}XFLogLevel;


void __XFLog(XFLogLevel level,
           const char *fileName,
           int line,
           const char *methodName,
           int error,
           NSString *userMsg);

#endif
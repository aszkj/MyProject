//
//  XFLog.m
//  XFTest
//
//  Created by xiejinzhan on 14-8-6.
//  Copyright (c) 2014年 jiuding. All rights reserved.
//

#import "XFLog.h"


void __XFLog(XFLogLevel level,
              const char *fileName,
              int line,
              const char *methodName,
              int error,
              NSString *userMsg)
{
    static const char * XFLogLevelString[] = {
        "DEBUG",
        "TRACE",
        "WARNI",
        "FATAL",
    };
    
    const char *file_name;
    if((file_name = strrchr(fileName, '/'))) {
        ++file_name;
    } else {
        file_name = fileName;
    }
    
    if (level < XFLogLevelWarning) {
        NSLog(@"%s [%s:%d %s] %@",
              XFLogLevelString[level], file_name, line, methodName, userMsg);
    } else {
        NSLog(@"%s [%s:%d %s] [err:%d] %@",
              XFLogLevelString[level], file_name, line, methodName, error, userMsg);
    }
    
    if (level == XFLogLevelWarning) {
        //警告
    }
    
    if (level == XFLogLevelFatal) {
        //致命的错误
    }
}

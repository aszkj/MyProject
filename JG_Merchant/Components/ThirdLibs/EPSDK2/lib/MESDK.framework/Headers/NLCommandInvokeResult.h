//
//  NLCommandInvokeResult.h
//  MTypeSDK
//
//  Created by su on 14-4-12.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    NLCommandInvokeResultSuccess,
    NLCommandInvokeResultFailed,
    NLCommandInvokeResultUserCanceled,
    NLCommandInvokeResultContinued
} NLCommandInvokeResult;
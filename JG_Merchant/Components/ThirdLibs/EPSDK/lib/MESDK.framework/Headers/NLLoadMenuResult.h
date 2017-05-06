//
//  NLLoadMenuResult.h
//  MTypeSDK
//
//  Created by su on 15/7/8.
//  Copyright © 2015年 newland. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @enum
 @abstract 菜单装载结果
 @constant NLLoadMenuResultSuccess 下载成功
 @constant NLLoadMenuResultNoMenu 菜单数据为空
 @constant NLLoadMenuResultMacError MAC校验出错
 @constant NLLoadMenuResultParseError 菜单数据解析出错
 @constant NLLoadMenuResultUnknownError 未知错误，一般是通信失败
 */
typedef enum {
    NLLoadMenuResultSuccess,
    NLLoadMenuResultNoMenu,
    NLLoadMenuResultMacError,
    NLLoadMenuResultParseError,
    NLLoadMenuResultUnknownError,
} NLLoadMenuResult;

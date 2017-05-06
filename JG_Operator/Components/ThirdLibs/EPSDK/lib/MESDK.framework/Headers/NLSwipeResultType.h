//
//  NLSwipResultType.h
//  MTypeSDK
//
//  Created by shencw on 13-7-1.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLFoundation.h"

/*!
 @enum
 @abstract 刷卡处理结果
 @discussion
 @constant NLSwipeResultTypeSuccess 处理成功
 @constant NLSwipeResultTypeParamError 参数错误
 @constant NLSwipeResultTypeDataLengthError 数据域长度错误
 @constant NLSwipeResultTypeLengthError 长度错误
 @constant NLSwipeResultTypeTypeError TYPE错误
 @constant NLSwipeResultTypeDataFormatError 读取磁条卡数据格式错误
 @constant NLSwipeResultTypeReadTrackTimeout 读取磁条卡数据超时
 @constant NLSwipeResultTypeSwipeFailed 读取磁条卡刷卡失败
 */
typedef enum {
    NLSwipeResultTypeSuccess,
    NLSwipeResultTypeParamError,
    NLSwipeResultTypeDataLengthError,
    NLSwipeResultTypeLengthError,
    NLSwipeResultTypeTypeError,
    NLSwipeResultTypeDataFormatError,
    NLSwipeResultTypeReadTrackTimeout,
    NLSwipeResultTypeSwipeFailed
} NLSwipeResultType;

NL_INLINE NSString* GetSwipeResultTypeDescription(NLSwipeResultType restType)
{
    return [[NSArray arrayWithObjects:
             @"处理成功",
             @"参数错误",
             @"数据域长度错误",
             @"长度错误",
             @"TYPE错误",
             @"读取磁条卡数据格式错误",
             @"读取磁条卡数据超时",
             @"读取磁条卡刷卡失败",
             nil] objectAtIndex:restType];
}

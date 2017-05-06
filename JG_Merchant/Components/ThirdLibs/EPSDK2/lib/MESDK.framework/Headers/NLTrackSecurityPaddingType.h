//
//  NLTrackSecurityPaddingType.h
//  MTypeSDK
//
//  Created by su on 14-4-14.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @enum
 @abstract 磁道安全填充模式
 @constant NLTrackSecurityPaddingTypeNone 不填充
 @constant NLTrackSecurityPaddingTypeStandardModel 填充完的平台流水号（12个字节）+随机数（8个字节）+ MPOS硬件序列号（即SN码，12个字节）+磁道数据合并进行加密
 */
typedef enum {
    NLTrackSecurityPaddingTypeNone,
    NLTrackSecurityPaddingTypeStandardModel
} NLTrackSecurityPaddingType;//NL_DEPRECATED_AT(1_0_3);

//
//  NLEmvTagValueType.h
//  MTypeSDK
//
//  Created by su on 14-1-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 @enum
 @abstract emv标签数值类型<p>
 @discussion
 */
typedef enum {
	/**
	 * 二进制,可能包含字节,以及复合字段定义部分
	 */
    NLEmvTagValueTypeBinary,
    /**
     * Compressed numberic data elements consist of two numeric digists.(having values in the range hex '0'-'9') per bytes,
     * These data elements are left justified and padded with trailing hexadecimal 'F's.<p>
     * <b>ex.</b><pre><quote>
     * 1234567890123 ,padded rslt: 12 34 56 78 90 12 3F FF with a length of 8
     * </pre></quote>
     */
    NLEmvTagValueTypeCompressedNumberic,
    /**
     * numberic data,differnt to {@link #COMPRESSED_NUMBERIC} are <b>right justified</b> and padded with leading hexadecimal <b>zeroes</b>.
     * <b>ex.</b><pre><quote>
     * 1234567890123 ,padded rslt: 00 01 32 54 67 89 01 23 with a length of 8
     * </pre></quote>
     */
    NLEmvTagValueTypeNumberic,
    /**
     * 文本类型
     */
    NLEmvTagValueTypeText
} NLEmvTagValueType;
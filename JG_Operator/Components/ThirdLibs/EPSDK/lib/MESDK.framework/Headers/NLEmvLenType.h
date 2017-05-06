//
//  NLEmvLenType.h
//  MTypeSDK
//
//  Created by su on 14-1-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 @enum
 @abstract 长度定义方式
 @discussion
 */
typedef enum {
	/**
	 * 定长
	 */
	NLEmvLenTypeFixed,
	/**
	 * 范围内设定
	 */
	NLEmvLenTypeScope,
	/**
	 * 变长
	 */
	NLEmvLenTypeVar
    
} NLEmvLenType;
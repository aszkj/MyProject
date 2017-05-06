//
//  NLEmvTagClass.h
//  MTypeSDK
//
//  Created by su on 14-1-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 @enum
 @abstract EMV TAG 类型<p>
 @discussion
 */
typedef enum {
	NLEmvTagClassUniversal,
	NLEmvTagClassApplication,
    NLEmvTagClassConextSpecific,
	NLEmvTagClassPrivate
} NLEmvTagClass;
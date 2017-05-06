//
//  NLEmvTagType.h
//  MTypeSDK
//
//  Created by su on 14-1-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @enum
 @abstract
 @discussion 
    EMV Book 3 Annex B
 */
typedef enum {
    /**
     * The value field of a primitive data object contains a
     * data element for financial transaction interchange
     */
    NLEmvTagTypePrimitive,
    /**
     * The value field of a constructed data object contains one
     * or more primitive or constructed data objects.
     * The value field of a constructed data object is called a template.
     */
    NLEmvTagTypeConstructed
} NLEmvTagType;
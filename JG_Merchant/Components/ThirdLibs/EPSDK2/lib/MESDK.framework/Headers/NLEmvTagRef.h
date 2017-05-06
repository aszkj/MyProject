//
//  NLEmvTagRef.h
//  MTypeSDK
//
//  Created by su on 14-1-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLEmvTagValueType.h"
#import "NLEmvTagClass.h"
#import "NLEmvTagType.h"
#import "NLEmvLenType.h"
/*!
 @protocol
 @abstract 标签参考说明
 @discussion
 */
@protocol NLEmvTagRef <NSObject>
/*!
 @method
 @abstract 标签值
 @discussion
 @return
 */
- (int)tag;
/*!
 @method
 @abstract 标签名称
 @discussion
 @return
 */
- (NSString*)name;
/*!
 @method
 @abstract 标签数值类型
 @discussion
 @return
 */
- (NLEmvTagValueType)tagValueType;
/*!
 @method
 @abstract 标签种类
 @discussion
 @return
 */
- (NLEmvTagClass)tagClass;
/*!
 @method
 @abstract 标签类型
 @discussion
 @return
 */
- (NLEmvTagType)tagType;
/*!
 @method
 @abstract 长度模式
 @discussion
 @return
 */
- (NLEmvLenType)lenType;
/*!
 @method
 @abstract 定长长度
 @discussion
 @return
 */
- (int)fixedLen;
/*!
 @method
 @abstract 若变长,则最大长度
 @discussion
 @return
 */
- (int)maxLen;
/*!
 @method
 @abstract 若变长,则最小长度
 @discussion
 @return
 */
- (int)minLen;
/*!
 @method
 @abstract 是否是定长模式
 @discussion
 @return
 */
- (BOOL)isModelFixedLen;
/*!
 @method
 @abstract 是否是范围长度设定模式
 @discussion
 @return
 */
- (BOOL)isModelScopeLen;
@end

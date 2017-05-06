//
//  NLDeviceResponse.h
//  mpos
//
//  Created by su on 13-6-21.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLFoundation.h"
#import "NLCommandInvokeResult.h"
/*!
 @protocol
 @abstract 设备响应接口
 @discussion
 TODO
 */
@protocol NLDeviceResponse <NSObject>
/*!
 @version 1.0.6
 @method
 @abstract 获取当前指令处理结果
 @discussion
 */
- (NLCommandInvokeResult)processRslt;
/*!
 @method
 @abstract 是否被撤消
 @discussion
 @deprecated 1.0.6
 @see #getProcessRslt
 @return
 */
- (BOOL)isUserCanceled NL_DEPRECATED_API;
/*!
 @method
 @abstract 是否成功执行
 @discussion
 @deprecated 1.0.6
 @see #getProcessRslt
 @return
 */
- (BOOL)isSuccess NL_DEPRECATED_API;
/*!
 @method
 @abstract 若{@link #isSuccess()}返回为<tt>false</tt>，
        则期望通过该方法返回一个出错异常<p>
 @return 出错异常
 */
- (NSError*)exceptionError;

@end

//
//  NLAbortable.h
//  MTypeSDK
//
//  Created by su on 13-6-24.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 @protocol
 @abstract 内部对象
 @discussion  用于<tt>InnerMessage</tt>和<tt>DeviceRequest</tt>中传递中断请求<p>
 */
@protocol NLAbortable <NSObject>
- (void)abort;
@end

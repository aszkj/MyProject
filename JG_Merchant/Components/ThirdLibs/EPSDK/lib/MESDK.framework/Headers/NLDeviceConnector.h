//
//  NLDeviceConnector.h
//  MTypeSDK
//
//  Created by su on 13-6-24.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLDeviceConnType.h"
#import "NLDeviceConnection.h"
#import "NLDeviceConnParams.h"
/*!
 @protocol
 @abstract 设备连接器实现
 @discussion
 */
@protocol NLDeviceConnector <NSObject>
/*!
 @method
 @abstract 获得该连接器支持
 @return
 */
- (NSArray*)supportConnType;
/*!
 @method 
 @abstract 创建一个设备连接
 @discussion
        这里不约定是否能确保成功创建一个连接。
        上层需要根据连接器的不同特性处理创建时可能出现的错误。
 @return
 */
- (id<NLDeviceConnection>)createWithParams:(id<NLDeviceConnParams>)params connectId:(long)connId error:(NSError**)err;

@end

//
//  NLDeviceConnParams.h
//  mpos
//
//  Created by su on 13-6-20.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLDeviceConnType.h"
/*!
 @protocol DeviceConnParams设备连接参数
 @abstract 设备连接参数
 @discussion
     对于给定的连接器,无论是<tt>蓝牙</tt>,<tt>USB</tt>,<tt>音频口</tt>或者是<tt>k21</tt>采用的<tt>Android Service</tt>方式连接，
     但都应该是期望具有相同的通信和交互方式。<p>
     这使得对应一种蓝牙设备可以用一个类型和一组参数来描述连接<p>
     <p>
     接口定义内，还包括一个参数集的实现，用来指定连接时的参数设置。
 */
@protocol NLDeviceConnParams <NSObject>
/*!
 @method
 @abstract 获得一个连接类型
 @return
 */
- (NLDeviceConnType)connectType;
/*!
 @method
 @abstract 获得该连接器声明中所有的参数键值
 @return 获得参数键值列表
 */
- (NSArray*)paramKeys;
/*!
 @method
 @abstract 获得对应连接参数
 @param key 对应键值
 @return 对应参数值
 */
- (NSString*)paramForKey:(NSString*)key;
@end

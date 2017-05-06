//
//  NLBlueToothV100ConnParams.h
//  MTypeSDK
//
//  Created by su on 13-6-24.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLDeviceConnParams.h"
/*!
 @class BlueToothV100ConnParams蓝牙连接参数
 @abstract 蓝牙连接参数
 @discussion
 */
@interface NLBlueToothV100ConnParams : NSObject<NLDeviceConnParams>
/*!
 @method 蓝牙连接参数构造函数
 @abstract 需要传入设备uuid，可从NLBuletoothHelper中获取设备列表从中取一
 @param uuid 设备uuid
 @return 蓝牙连接参数对象
 */
- (id)initWithUuid:(NSString*)uuid;
@end

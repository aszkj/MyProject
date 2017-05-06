//
//  NLModule.h
//  mpos
//
//  Created by su on 13-6-13.
//  Copyright (c) 2013年 suzw. All rights reserved.
//
#import "NLModuleType.h"
#import "NLDevice.h"

@protocol NLDevice;
/*!
 @class Module设备模块
 @abstract 设备模块
 */
@protocol NLModule <NSObject>
// 
/*!
 @method
 @abstract 是否是标准模块
 @return 是否是标准模块
 */
- (BOOL)isStandardModule;
/*!
 @method 
 @abstract 若该模块是在sdk中存在定义的标准模块,获得对应的标准模块的枚举类型
 @return 模块类型，若非标准模块类型，则返回为空
 */
- (NLModuleType)standardModuleType;
/*!
 @method
 @abstract 若该模块是声明在外部的扩展模块,则获得扩展模块类型
 @return 模块类型，若是标准模块类型，则返回为空
 */
- (NSString*)exModuleType;
/*!
 @method
 @abstract 获得这个模块所在的设备对象
 @return 模块所在的设备对象
 */
- (NSObject<NLDevice>*)owner;
/*!
 @method
 @abstract 获得该模块的表述
 @return 模块的表述
 */
- (NSString*)description;
@end

//
//  NLCardReader.h
//  mpos
//
//  Created by su on 13-6-18.
//  Copyright (c) 2013年 suzw. All rights reserved.
//
#import "NLFoundation.h"
#import "NLModule.h"
#import "NLOpenCardReaderEvent.h"
#import "NLDeviceEventListener.h"
#import "NLME11SwipeResult.h"
#import "NLWorkingKey.h"
/*!
 @protocol CardReader读卡器模块
 @abstract 读卡器模块
 @discussion
 */
@protocol NLCardReader <NLModule>
/*!
 @method 
 @abstract 当前设备支持的读卡器组
 @return 支持的读卡器类型
 */
- (NSArray*)supportCardReaderModule;
/*!
 @method
 @abstract 判断当前设备是否IC卡
 @return 是否已插入了刷卡器
 */
- (BOOL)checkCardReader NL_DEPRECATED_API;
/*!
 @method IC卡通信（需升级api）
 @abstract IC卡通信
 @return
 */
- (void)communicateCardReaderWithHexCmd:(NSString*)hexCmd NL_DEPRECATED_API;
/*!
 @method 打开一个读卡器.
 @abstract
 @param cardReaderModuleTypes 打开的读卡器类型
 @param timeout 期待超时时间
 @param timeunit 期待超时量级
 @param listener 事件监听(得到的事情是NLOpenCardReaderEvent)
 @return
 */
- (void)openCardReaderWithCardReaderModuleTypes:(NSArray*)cardReaderModuleTypes timeout:(int)timeout listener:(id<NLDeviceEventListener>)listener NL_DEPRECATED_API;
/*!
 @version 1.0.6
 @method 打开一个读卡器.
 @abstract
 @param cardReaderModuleTypes 打开的读卡器类型
 @param screenShow 界面显示的内容
 @param timeout 期待超时时间
 @param timeunit 期待超时量级
 @param listener 事件监听(得到的事情是NLOpenCardReaderEvent)
 @return
 */
- (void)openCardReaderWithCardReaderModuleTypes:(NSArray*)cardReaderModuleTypes screenShow:(NSString*)screenShow timeout:(int)timeout listener:(id<NLDeviceEventListener>)listener NL_DEPRECATED_API;
/*!
 @version 1.0.6
 @method 打开一个读卡器.
 @abstract
 @param cardReaderModuleTypes 打开的读卡器类型
 @param screenShow 界面显示的内容
 @param timeout 期待超时时间
 @param timeunit 期待超时量级
 @param listener 事件监听(得到的事情是NLOpenCardReaderEvent)
 @return NSArray(NLModuleType)
 */
- (NSArray*)openCardReaderWithCardReaderModuleTypes:(NSArray*)cardReaderModuleTypes screenShow:(NSString*)screenShow timeout:(int)timeout;

/*!
 @version 1.0.3
 @method 打开一个读卡器.
 @abstract
 @param cardReaderModuleTypes 打开的读卡器类型
 @param timeout 期待超时时间
 @param timeunit 期待超时量级
 @param listener 事件监听(得到的事情是NLOpenCardReaderEvent)
 @return NSArray(NLModuleType)
 */
- (NSArray*)openCardReaderWithCardReaderModuleTypes:(NSArray *)cardReaderModuleTypes timeout:(int)timeout NL_DEPRECATED_AT(1_0_3);
/*!
 @version 1.0.4
 @method
 @abstract 撤销上次读卡操作
 @discussion
 @return
 */
- (void)cancelCardRead;
/*!
 @method
 @abstract 关闭读卡器
 @discussion 若之前有读卡事件，则撤消读卡操作
 @return
 */
- (void)closeCardReader;

#pragma mark - ME11
/*!
 @version 1.0.6
 @method 打开一个读卡器.
 @abstract
 @param moduleTypes 打开的读卡器类型
 @param readModels 读卡磁道
 @param panType pan类型
 @param encryptAlgorithm 算法标识
 @param wk 工作密钥
 @param time 流水时间戳
 @param random 界面显示的内容
 @param appendData 平台流水号等信息
 @param timeout 期待超时时间
 @return NLME11SwipeResult 刷卡结果
 */
- (NLME11SwipeResult*)openCardReader:(NSArray*)moduleTypes
                           readModel:(NSArray*)readModels
                             panType:(Byte)panType
                    encryptAlgorithm:(NSString*)encryptAlgorithm
                                  wk:(NLWorkingKey*)wk
                                time:(NSData*)time
                              random:(NSData*)random
                          appendData:(NSData*)appendData
                             timeout:(int)timeout;
@end

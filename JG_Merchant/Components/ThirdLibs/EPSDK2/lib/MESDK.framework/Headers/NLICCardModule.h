//
//  NLICCardModule.h
//  MTypeSDK
//
//  Created by su on 14-4-11.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLICCardConstants.h"


/*!
 @version 1.0.6
 @protocol ICCardModule接触式IC卡通用模块
 @abstract 接触式IC卡通用模块
 @discussion
 */
@protocol NLICCardModule <NSObject>
/*!
 @method
 @abstract 设置当前的IC卡类型<p>
 @param cardType IC卡卡类型
 @param slot IC卡卡槽
 @return
 */
- (void)setICCardType:(NLICCardType)cardType slot:(NLICCardSlot)slot;
/*!
 @method
 @abstract 获取当前IC卡状态<p>
 @return 当前各个IC卡槽状态 NSDictionary<NLICCardSlot, NLICCardSlotState>
 */
- (NSDictionary*)checkSlotState;
/*!
 @method
 @abstract 卡槽上电<p>
 @param slot IC卡卡槽
 @param cardType IC卡卡类型
 @return ATR
 */
- (NSData*)powerOnWithSlot:(NLICCardSlot)slot cardType:(NLICCardType)cardType;
/*!
 @method
 @abstract 卡槽下电<p>
 @param slot IC卡卡槽
 @param cardType IC卡卡类型
 */
- (void)powerOffWithSlot:(NLICCardSlot)slot cardType:(NLICCardType)cardType;
/*!
 @method
 @abstract 发起一个IC卡通信请求<p>
 @param slot IC卡卡槽
 @param cardType IC卡卡类型
 @param req 请求
 @param timeout 超时时间
 @return 返回调用后的IC卡响应
 */
- (NSData*)callWithSlot:(NLICCardSlot)slot cardType:(NLICCardType)cardType req:(NSData*)req timeout:(NSTimeInterval)timeout;
@end

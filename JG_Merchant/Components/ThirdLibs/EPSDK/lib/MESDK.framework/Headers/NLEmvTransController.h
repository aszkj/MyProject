//
//  NLEmvTransController.h
//  MTypeSDK
//
//  Created by su on 14-1-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLEmvTransInfo.h"
#import "NLEmvCardInfo.h"
#import "NLSecondIssuanceRequest.h"
/*!
 @protocol
 @abstract 交易接口控制器
 @discussion
 */
@protocol NLEmvTransController <NSObject>
/**
 * 开启一个emv标准的交易流程<p>
 * 若授权金额在初始化时不需要输入,则为空。
 *
 * @param processingCode 交易类型(ISO 8583:1987 Processing Code)
 * @param amount 授权金额（Amount, Authorised)
 * @param forceOnline 强制联机
 * @param isStandardProcessingCode 是否使用标准的emv处理码
 */
- (void)startEmvWithProcessingCode:(int)processingCode innerProcessingCode:(int)innerProcessingCode amount:(NSDecimalNumber*)amount forceOnline:(BOOL)forceOnline;

/**
 * 开启一个emv消费流程<p>
 * @param amount 授权金额（Amount, Authorised)
 * @param cashback 回扣 (Amount, Other)
 * @param forceOnline 强制联机
 */
- (void)startEmvWithAmount:(NSDecimalNumber*)amount cashback:(NSDecimalNumber*)cashback forceOnline:(BOOL)forceOnline;

/**
 * 获得当前交易上下文信息<p>
 *
 * @param (NSArray<Integer>*)tags 期望获得的标签值
 * @return
 */
- (NLEmvTransInfo*)transferInfoWithTags:(NSArray*)tags;

/**
 * 获得当前交易的账户信息<p>
 *
 * @param tags  期望获得的标签值
 * @return
 */
- (NLEmvCardInfo*)cardInfoWithTags:(NSArray*)tags;

/**
 * 选择一个应用<p>
 *
 * @param aid 选中的应用
 */
- (void)selectApplicationWithAid:(NSData*)aid;

/**
 * 返回输入的pin结果<p>
 *
 * @param pinblock 输入的pin结果
 */
- (void)sendPinInputResult:(NSData*)pinblock;
/**
 * 交易信息确认<p>
 *
 * @param confirmed
 */
- (void)transferConfirm:(BOOL)confirmed;
/**
 * 交易二次授权<p>
 *
 * @param tlvPackage 二次授权
 * @return 
 */
- (NLEmvTransInfo*)secondIssuance:(NLSecondIssuanceRequest*)request;
/**
 * 取消emv交易<p>
 */
- (void)cancelEmv;

@end

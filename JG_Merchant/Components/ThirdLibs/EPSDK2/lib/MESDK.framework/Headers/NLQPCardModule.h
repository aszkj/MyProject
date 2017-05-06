//
//  NLQPCardModule.h
//  MTypeSDK
//
//  Created by su on 14-4-8.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLModule.h"
#import "NLQPResult.h"
#import "NLQPCardConstants.h"

/**
 *
 * 非接接口
 *
 */
@protocol NLQPCardModule <NLModule>
/**
 * 寻卡上电
 *
 * @param qPCardType
 *            卡类型，可为空
 * @param timeout
 *            超时时间
 * @return
 */
- (NLQPResult*)powerOnWithCardType:(NLQPCardType)qPCardType timeout:(int)timeout;
/**
 * 下电
 *
 * @param timeout
 *            超时时间
 */
- (void)powerOffWithTimeout:(int)timeout;
/**
 * 非接CPU卡通讯
 *
 * @param req
 *            APDU数据
 * @param timeout
 *            超时时间
 * @param timeunit
 *            时间单位
 * @return
 */
- (NSData*)callWithReq:(NSData*)req timeout:(NSTimeInterval)timeout;
/**
 * 存储密钥
 *
 * @param qpKeyMode
 *            KEY模式
 * @param keyIndex
 *            密钥存储区(接口芯片中)
 * @param key
 *            密钥
 */
- (void)storeKeyWithKeyMode:(NLQPKeyMode)qpKeyMode keyIndex:(int)keyIndex key:(NSData*)key;
/**
 * 加载密钥
 *
 * @param qpKeyMode
 *            KEY模式
 * @param keyIndex
 *            密钥存储区(接口芯片中)
 */
- (void)loadKeyWithKeyMode:(NLQPKeyMode)qpKeyMode keyIndex:(int)keyIndex;
/**
 * 使用加载的密钥进行认证
 *
 * @param qpKeyMode
 *            KEY模式
 * @param SNR
 * @param blockNo
 *            要认证的块号
 */
- (void)authenticateByLoadedKeyWithKeyMode:(NLQPKeyMode)qpKeyMode SNR:(NSData*)SNR blockNo:(int)blockNo;
/**
 * 使用外部的密钥进行认证
 *
 * @param qpKeyMode
 *            KEY模式
 * @param SNR
 * @param blockNo
 *            要认证的块号
 * @param key
 *            外部密钥
 */
- (void)authenticateByExtendKeyWithKeyMode:(NLQPKeyMode)qpKeyMode SNR:(NSData*)SNR blockNo:(int)blockNo key:(NSData*)key;
/**
 * 读块数据
 *
 * @param blockNo
 *            块号
 * @return
 */
- (NSData*)readDataBlock:(int)blockNo;
/**
 * 写块数据
 *
 * @param blockNo
 *            块号
 * @param data
 *            块数据
 */
- (void)writeDataBlock:(int)blockNo data:(NSData*)data;
/**
 * 增量操作
 *
 * @param blockNo 块号
 * @param data 值
 */
- (void)incrementOperationWithBlockNo:(int)blockNo data:(NSData*)data;
/**
 * 减量操作
 *
 * @param blockNo 块号
 * @param data 值
 */
- (void)decrementOperationWithBlockNo:(int)blockNo data:(NSData*)data;
@end

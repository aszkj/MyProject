//
//  NLExCode.h
//  mpos
//
//  Created by su on 13-6-20.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#ifndef mpos_NLExCode_h
#define mpos_NLExCode_h

/**
 * 未知异常
 */
#define NLExCode_UNKNOWN -100
/**
 * 线程处理超时
 */
#define NLExCode_PROCESS_TIMEOUT -101
/**
 * 设备未连接
 */
#define NLExCode_DEVICE_DISCONNECTED -102
/**
 * 设备执行指令失败<p>
 */
#define NLExCode_DEVICE_INVOKE_FAILED -103
/**
 * 不支持的设备连接<p>
 */
#define NLExCode_NOT_SUPPORTED_CONNECTOR_TYPE -104
/**
 * 指令序列化失败<p>
 */
#define NLExCode_SERIALIZE_OR_UNSERIALIZE_FAILED -106
/**
 * 菜单处理码长度错误<p>
 */
#define NLExCode_MENU_PROCESSCODE_LENGTH_ERR -106
/**
 * EMV 交易流程失败
 */
#define NLExCode_EMV_TRANSFER_FAILED -107


/**
 * 取消设备指令
 */
#define NLExCode_DEVICE_INVOKE_CANCELED -9001

#endif

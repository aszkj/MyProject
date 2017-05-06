//
//  NLMESeriesConst.h
//  MTypeSDK
//
//  Created by su on 13-10-23.
//  Copyright (c) 2013年 suzw. All rights reserved.
//
/*!
 @file
 @abstract ME 系列设备常量表
 @version 1.0.4
 */
#import <Foundation/Foundation.h>
/*!
 @class
 @abstract 磁道加密模式
 @discussion
 */
@interface NLTrackEncryptAlgorithm : NSObject
/**
 * 富友
 */
+ (NSString*)BY_FUIOU_MODEL;
/**
 * 使用标准的银联二代规范的磁道处理方式<p>
 */
+ (NSString*)BY_UNIONPAY_MODEL;
+ (NSString *)BY_DUKPT_MODEL;
/**
 * 迷你付
 */
+ (NSString *)BY_MINIPAY_MODEL;
/**
 * 一个全磁道加密的方案,规则如下:   <p>    <ol>
 * <li> 十进制表示一个两位的二磁道原长 + 二磁道数据 +  十进制表示一个三位的三磁道原长+ 三磁道数据 </li>
 * <li> 用0来补全数据到16的整数倍</li>
 * <li> 将数据做压缩BCD处理</li>
 * <li> 生成的数据做des加密</li>
 *</ol>
 * 举例:
 *<pre><blockquote>
 * track2 = 123
 * track3 = 4567
 * encrypt rslt = DES(key, (0x03 0x12 0x30 0x04 0x45 0x67 0x00 0x00));
 * </pre></blockquote>
 */
+ (NSString *)BY_FULLTRACK_ENCRYPT_MODEL;
/**
 * 支付通
 */
+ (NSString *)BY_ICARDPAY_MODEL;
/**
 * 通联
 */
+ (NSString *)BY_ALLINPAY_MODEL;
/**
 * 擎动
 */
+ (NSString *)BY_QDONE_MODEL;
/**
 * 快钱
 */
+ (NSString *)BY_99BILL_MODEL;
/**
 * 银商一盒宝
 */
+ (NSString *)BY_CHINAUMS_BOX_MODEL;
/**
 * 拉卡拉开店宝
 */
+ (NSString *)BY_LAKALA_KAIDIANBAO_MODEL;
/**
 * 和付
 */
+ (NSString *)BY_HEFU_MODEL;
/**
 * 瀚银
 */
+ (NSString*)BY_HANDPAY_MODEL;
/**
 * 银盛(移付宝)
 */
+ (NSString *)BY_EPTOK_MODEL;
+ (NSString *)BY_EPTOK_MODEL2;
/**
 * 国通富友
 */
+ (NSString*)BY_GUOTONGFY_MODEL;
/**
 * 电银
 */
+ (NSString*)BY_DIANYIN_MODEL;
/**
 * 翰鑫
 */
+ (NSString*)BY_HANXIN_MODEL;
/**
 * 移付宝
 */
+ (NSString*)BY_YIFUBAO_MODEL;
/**
 * 即付宝(华中星)
 */
+ (NSString *)BY_JIFUBAO_MODEL;
/**
 * M10
 */
+ (NSString*)BY_M10_MODEL;
/**
 * 环讯
 */
+ (NSString*)BY_HUANXUN_MODEL;
/**
 * 钱海
 */
//+ (NSString*)BY_QIANHAI_MODEL;
/**
 * 安子
 */
+ (NSString*)BY_ANZI_MODEL;
/**
 * ME11明文
 */
+ (NSString*)BY_M11_PLAIN_MODEL;
/**
 * 通银
 */
+ (NSString*)BY_TONGYIN_MODEL;
/**
 * 微亿
 */
+ (NSString*)BY_WEIYI_MODEL;
/**
 * 万事达
 */
+ (NSString*)BY_WANSHIDA_MODEL;

@end

/*!
 @enum
 @abstract 公钥索引
 @constant NLPublicKeyIndexMKSK MK/SK
 @constant NLPublicKeyIndexDUKPT DUKPT
 @constant NLPublicKeyIndexFIXED 一盒宝
 */
typedef enum {
    NLPublicKeyIndexMKSK = 0xFF,
    NLPublicKeyIndexDUKPT = 0x01,
    NLPublicKeyIndexFIXED = 0x02
} NLPublicKeyIndex;

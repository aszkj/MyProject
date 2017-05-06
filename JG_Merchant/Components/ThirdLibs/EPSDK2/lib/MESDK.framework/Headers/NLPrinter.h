//
//  NLPrinter.h
//  MTypeSDK
//
//  Created by su on 13-10-10.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLFoundation.h"
#import "NLModule.h"
//#import "NLPrintTemplate.h"


/*!
 @enum
 @abstract 字体设置覆盖的范围
 @constant NLFontSettingScopeWidth 设置宽
 @constant NLFontSettingScopeHeight 设置高
 */
typedef enum {
    NLFontSettingScopeWidth,
    NLFontSettingScopeHeight
} NLFontSettingScope;

/*!
 @enum
 @abstract 字体类型
 @constant NLFontTypeNormal 设普通
 @constant NLFontTypeDouble 双倍长
 */
typedef enum {
    NLFontTypeNormal,
    NLFontTypeDouble
} NLFontType;

/*!
 @enum
 @abstract 文字类型
 @constant NLLiteralTypeChinese 中文
 @constant NLLiteralTypeWestern 西文
 */
typedef enum {
    NLLiteralTypeChinese,
    NLLiteralTypeWestern
} NLLiteralType;


/*!
 @enum
 @abstract 走纸类型
 @constant NLThrowTypeLine 行走纸
 @constant NLThrowTypeStep 步走纸
 */
typedef enum {
    NLThrowTypeLine,
    NLThrowTypeStep
} NLThrowType;

/*!
 @enum
 @abstract 字库设置
 @constant NLWordStockTypePix24 24点阵
 @constant NLWordStockTypePix16 16点阵
 */
typedef enum {
    NLWordStockTypePix24,
    NLWordStockTypePix16
} NLWordStockType;

/*!
 @enum
 @abstract 打印数据校验类型
 @constant NLPrintMacCheckTypeNone 不做mac校验
 @constant NLPrintMacCheckTypeX99 做mac x99校验
 */
typedef enum {
    NLPrintMacCheckTypeNone,
    NLPrintMacCheckTypeX99
} NLPrintMacCheckType;


/*!
 @enum
 @abstract 打印机状态
 @constant NLPrinterStatusNormal 正常
 @constant NLPrinterStatusOutOfPaper 缺纸
 @constant NLPrinterStatusHeatLimited 超温
 @constant NLPrinterStatusFlashReadWriteError 闪存读写错误
 @constant NLPrinterStatusBusy 打印机忙
 */
typedef enum {
    NLPrinterStatusNormal,
    NLPrinterStatusOutOfPaper,
    NLPrinterStatusHeatLimited,
    NLPrinterStatusFlashReadWriteError,
    NLPrinterStatusBusy
} NLPrinterStatus;


typedef enum {
    NLPrintResult_Succeed,              //“00” 打印成功
    NLPrintResult_DataError,            //”01“ 打印数据解析错误
    NLPrintResult_Error,                //“02” 通用错误
    NLPrintResult_OutOfPaper,           //“04” 缺纸
    NLPrintResult_HeatLimited,          //“08” 超温
    NLPrintResult_FlashReadWriteError,  //“40” Flash 读写错误
    NLPrintResult_Busy,                 //“80” 打印头忙
    NLPrintResult_CheckMacError,        //“41” MAC 校验错误
    NLPrintResult_AlgorithmError,       //“42” 错误算法标识
    NLPrintResult_KeyIndexError,        //“43” 错误密钥 ID
    NLPrintResult_WorkingKeyLenError,    //“45” 错误工作密钥长度
    NLPrintResult_CmdTimeOut,
    NLPrintResult_CmdCancel,
    NLPrintResult_RespUnknown
}NLPrintResult;

@class NLPrintContext;
@class UIImage;
/*!
 @protocol Printer通用打印机
 @abstract 通用打印机
 @discussion
 */
@protocol NLPrinter <NLModule>
/*!
 @method
 @abstract 打印机初始化
 */
- (void)initialize;
/*!
 @method
 @abstract 获得打印机当前状态
 @return 打印机状态
 */
- (NLPrinterStatus)status;
/*!
 @method
 @abstract 打印机走纸
 @param type 走纸类型
 @param distance 走纸距离
 */
- (void)paperThrowWithType:(NLThrowType)type distance:(int)distance;
/*!
 @method
 @abstract 设置打印机字库
 @param type 字库类型
 */
- (void)setWordStockType:(NLWordStockType)type;
/*!
 @method
 @abstract 设置行间隔
 @param value 数值
 */
- (void)setLineSpace:(int)value;
/*!
 @method
 @abstract 设置浓度
 @param value 数值
 */
- (void)setDensity:(int)value;
/*!
 @method 设置字体类型<p>
 @param fontType 设置的字体类型
 @param literalType 针对的文字类型<p>
 @param settingScope 设置针对的范围
 */
- (void)setFontType:(NLFontType)fontType literalType:(NLLiteralType)literalType settingScope:(NLFontSettingScope)settingScope;
/*!
 @todo 是否需要设置打印时偏移量
 @method 
 @abstract 打印图片
 @param bitmap
 */
- (void)printWithBitmap:(UIImage*)bitmap timeout:(NSTimeInterval)timeout NL_DEPRECATED_API;
/*!
 @version 1.0.6
 @method
 @abstract 打印图片
 @param bitmap 位图
 @param position 图片偏移量
 @param timeout 超时时间
 */
- (void)printWithBitmap:(UIImage*)bitmap position:(int)position timeout:(NSTimeInterval)timeout;
/*!
 @method 
 @abstract 打印字符串
 @param string
 */
- (void)printWithString:(NSString*)string timeout:(NSTimeInterval)timeout;
///*!
// @method
// @abstract 指令集打印<p>
//            将根据输入指令集<tt>data</tt>的内容打印。<p>
//            若输入mac不为空，设备将校验mac值，若校验失败，则不打印。<p>
// @param data 输入打印指令
// @param mac 8位打印校验码
// */
//- (void)printWithData:(NSData*)data mac:(NSData*)mac timeout:(NSTimeInterval)timeout;
///*!
// @method
// @abstract 打印一个打印模板.<p>
// @param printTemplate 打印一个模板.
// */
//- (void)printWithPrintTemplate:(id<NLPrintTemplate>)printTemplate;
/*!
 @method
 @abstract 指令集打印<p>
 @discussion 将根据输入指令集<tt>data</tt>的内容打印。<p>
            若输入mac不为空，设备将校验mac值，若校验失败，则不打印。<p>
 @param data 输入打印指令
 @param mac 8位打印校验码
 */
- (void)printWithContext:(NLPrintContext*)context data:(NSData*)data timeout:(NSTimeInterval)timeout NL_DEPRECATED_API;
/*!
 @method
 @abstract 通过打印指令直接打印数据<p>
 @discussion 将根据输入指令集<tt>data</tt>的内容打印。<p>
 若输入mac不为空，设备将校验mac值，若校验失败，则不打印。<p>
 @param data 输入打印指令
 @param mac 8位打印校验码
 */
- (void)checkThenPrintWithContext:(NLPrintContext*)context data:(NSData*)data timeout:(NSTimeInterval)timeout;


@end

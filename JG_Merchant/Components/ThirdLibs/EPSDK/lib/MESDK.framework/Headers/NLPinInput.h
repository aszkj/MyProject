//
//  NLPinInput.h
//  mpos
//
//  Created by su on 13-6-18.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLFoundation.h"
#import "NLModule.h"
#import "NLPinInputConstants.h"
#import "NLWorkingKey.h"
#import "NLPinInputFinishedEvent.h"
#import "NLPinEncryptResult.h"
#import "NLDeviceEventListener.h"
#import "NLMacResult.h"

#import "NLLoadPKResultCode.h"
#import "NLLoadPKType.h"
#import "NLKSNKeyType.h"
#import "NLKSNLoadResultCode.h"
/*!
 @protocol PinInput密码键盘类
 @abstract 密码键盘类
 @discussion 
    TODO
 */
@protocol NLPinInput <NLModule>
/*!
 @method 开启一个pin输入过程
 @abstract
 @param wk 工作密钥
 @param pinManageType pin管理类型
 @param acctInputType 关联账号输入方式
 @param acctSymbol 关联账号标识,若主账号则使用asc表示,若是hash标示则使用16进制表示.将自动匹配上次刷卡对应的主账号结果.
 @param inputMaxLen 最大密钥输入长度
 @param isEnterEnabled 是否启用回车,若不启用,则输入完成后自动返回.
 @param displayContent 显示内容
 @param timeout 超时时间
 @param timeunit 超时时间量级
 @param inputListener 输入监听器(得到的事情是NLPinInputFinishedEvent)
 @return
 */
- (void)startPinInputWithWorkingKey:(NLWorkingKey*)wk
                      pinManageType:(NLPinManageType)pinManageType
                      acctInputType:(NLAccountInputType)acctInputType
                         acctSymbol:(NSString*)acctSymbol
                        inputMaxLen:(int)inputMaxLen
                         pinPadding:(NSData*)pinPadding
                     isEnterEnabled:(BOOL)isEnterEnabled
                     displayContent:(NSString*)displayContent
                            timeout:(int)timeout
                      inputListener:(id<NLDeviceEventListener>)inputListener;
/*!
 @version 1.0.6
 @method 开启一个pin输入过程
 @abstract 通过同步的方式调用一个pin输入过程,并阻塞到数据返回<p>
 若用户撤消,则返回为<tt>null</tt></p>
 任何失败则用异常形式通知上层.</p>
 这种调用方式,不支持过程中的输入状态通知,直接返回处理完成的密文.
 @param wk 工作密钥
 @param pinManageType pin管理类型
 @param acctInputType 关联账号输入方式
 @param acctSymbol 关联账号标识,若主账号则使用asc表示,若是hash标示则使用16进制表示.将自动匹配上次刷卡对应的主账号结果.
 @param inputMaxLen 最大密钥输入长度
 @param isEnterEnabled 是否启用回车,若不启用,则输入完成后自动返回.
 @param displayContent 显示内容
 @param timeout 超时时间
 @param timeunit 超时时间量级
 @return
 */
- (NLPinInputFinishedEvent*)startPinInputWithWorkingKey:(NLWorkingKey*)wk
                      pinManageType:(NLPinManageType)pinManageType
                      acctInputType:(NLAccountInputType)acctInputType
                         acctSymbol:(NSString*)acctSymbol
                        inputMaxLen:(NSInteger)inputMaxLen
                         pinPadding:(NSData*)pinPadding
                     isEnterEnabled:(BOOL)isEnterEnabled
                     displayContent:(NSString*)displayContent
                            timeout:(NSInteger)timeout;
/*!
 @version 1.1.4
 @deprecated
 @method
 @abstract 无键盘输入密码
 @param wk 工作密钥 (index 及wkBody必须传)
 @param pinManageType 密钥的管理类型
 @param acctInputType 关联账号输入方式
 @param acctSymbol 关联账号标识
 @param inputMaxLen 输入的最大长度
 @param pinPadding 加密算法中后补数据填充
 @param pin 密码明文
 @return
 */
- (NLPinEncryptResult*)startPinInputWithoutKeyboard:(NLWorkingKey*)wk
                                    pinManageType:(NLPinManageType)pinManageType
                                    acctInputType:(NLAccountInputType)acctInputType
                                       acctSymbol:(NSString*)acctSymbol
                                      inputMaxLen:(NSInteger)inputMaxLen
                                       pinPadding:(NSData*)pinPadding
                                              pin:(NSData*)plainPin NL_DEPRECATED_API;
/*!
 @version 1.2.4
 @method
 @abstract 无键盘输入密码
 @param wk 工作密钥 (index 及wkBody必须传)
 @param pinManageType 密钥的管理类型
 @param acctInputType 关联账号输入方式
 @param acctSymbol 关联账号标识
 @param pin 密码明文
 @return
 */
- (NLPinEncryptResult*)startPinInputWithoutKeyboardNew:(NLWorkingKey*)wk
                                         pinManageType:(NLPinManageType)pinManageType
                                         acctInputType:(NLAccountInputType)acctInputType
                                            acctSymbol:(NSString*)acctSymbol
                                                   pin:(NSData*)plainPin;
/*!
 @version 1.1.7
 @method
 @abstract 无键盘输入密码
 @param wk 工作密钥 (index 及wkBody必须传)
 @param pinManageType 密钥的管理类型
 @param acctInputType 关联账号输入方式
 @param acctSymbol 关联账号标识
 @param pin 密码明文
 @return
 */
- (NLPinEncryptResult*)startPinInputWithoutKeyboard:(NLWorkingKey*)wk
                                      pinManageType:(NLPinManageType)pinManageType
                                      acctInputType:(NLAccountInputType)acctInputType
                                         acctSymbol:(NSString*)acctSymbol
                                                pin:(NSData*)plainPin;
/*!
 @method 撤消密码输入
 @abstract
 @return
 */
- (void)cancelPinInput;
/*!
 @method 加密一串数据
 @abstract
 @param wk 工作密钥
 @param encryptType 加密类型
 @param input 输入数据
 @param cbcInit cbc初始化数据
 @throws PinFailedException 若失败，且带具体的应答，抛出该异常。
 TODO
 @return
 */
- (NSData*)encryptWithWorkingKey:(NLWorkingKey*)wk
                     encryptType:(NLEncryptType)encryptType
                           input:(NSData*)input
                         cbcInit:(NSData*)cbcInit;
/*!
 @method 解密一串数据
 @abstract
 @param wk 工作密钥
 @param encryptType 加密类型
 @param input 输入数据
 @param cbcInit cbc初始化数据
 @throws PinFailedException 若失败，且带具体的应答，抛出该异常。
 TODO
 @return
 */
- (NSData*)decryptWithWorkingKey:(NLWorkingKey*)wk
                     encryptType:(NLEncryptType)encryptType
                           input:(NSData*)input
                         cbcInit:(NSData*)cbcInit;
/*!
 @method 计算mac
 @abstract
 @param wk 使用工作密钥
 @param input 输入数据
 @throws PinFailedException 若失败，且带具体的应答，抛出该异常。
 TODO
 @return
 */
- (NSData*)calcMac:(NLWorkingKey*)wk input:(NSData*)input;
/*!
 @version 1.0.6
 @method 计算mac(mk/sk)
 @abstract
 @param wk 使用工作密钥
 @param input 输入数据
 @param macAlgorithm MAC算法
 @throws PinFailedException 若失败，且带具体的应答，抛出该异常。
 TODO
 @return
 */
- (NSData*)calcMac:(NLWorkingKey*)wk input:(NSData*)input macAlgorithm:(NLMacAlgorithm)macAlgorithm;
/*!
 @version 1.0.6
 @method  计算mac过程中，指定具体的密钥体系
 @abstract
 @param wk 使用工作密钥
 @param input 输入数据
 @param macAlgorithm MAC算法
 @param pinManageType 密钥类型
 @return
 */
- (NSData*)calcMac:(NLWorkingKey*)wk input:(NSData*)input macAlgorithm:(NLMacAlgorithm)macAlgorithm pinManageType:(NLPinManageType)pinManageType;
/*!
 @version 1.0.6
 @method 计算mac过程中，相关的因子也参与运算。<p>
 @abstract 例如：DUKPT的ksn号，以及部分用于分散出工作密钥的算法，要求返回参与运算的随机数<p>
 @param wk 使用工作密钥
 @param input 输入数据
 @param macAlgorithm MAC算法
 @param pinManageType 密钥类型
 @throws PinFailedException 若失败，且带具体的应答，抛出该异常。
 TODO
 @return
 */
- (NLMacResult*)calcMacWithKsn:(NLWorkingKey*)wk
             input:(NSData*)input
      macAlgorithm:(NLMacAlgorithm)macAlgorithm
     pinManageType:(NLPinManageType)pinManageType;
/*!
 @version 1.1.4
 @method
 @abstract 大数据mac计算
 @discussion
 <p>
 例如：DUKPT的ksn号，以及部分用于分散出工作密钥的算法，要求返回参与运算的随机数
 <p>
 @param wk 使用工作密钥
 @param input 输入数据
 @param macAlgorithm MAC算法
 @param pinManageType 密钥类型
 @return
 */
- (NLMacResult*)calcMacWithBigData:(NLWorkingKey*)wk input:(NSData*)input macAlgorithm:(NLMacAlgorithm)macAlgorithm pinManageType:(NLPinManageType)pinManageType;
/*!
 @method 装载一个工作密钥
 @abstract
 @param type 工作密钥类型
 @param mainKeyIndex 关联的主密钥索引
 @param workingKeyIndex 装入的工作密钥索引
 @param data 密钥数据
 @throws PinFailedException 若失败，且带具体的应答，抛出该异常。
 @return checkValue 更新后的校验值
 */
- (NSData*)loadWorkingKeyWithWorkingKeyType:(NLWorkingKeyType)type
                               mainKeyIndex:(int)mainKeyIndex
                            workingKeyIndex:(int)workingKeyIndex
                                       data:(NSData*)data
                                      error:(NSError**)err;
/*!
 @version 1.1.5
 @method 装载工作密钥（支持pos校验kcv）
 @abstract
 @param type 工作密钥类型
 @param mainKeyIndex 关联的主密钥索引
 @param workingKeyIndex 装入的工作密钥索引
 @param data 密钥数据
 @param checkValue 校验值
 @error throws 若失败，且带具体的应答，抛出该异常。
 @return kcv,当输入参数传入checkValue时返回全0数据，反之则返回kcv用于外部自行校验
 */
- (NSData*)loadWorkingKeyWithWorkingKeyType:(NLWorkingKeyType)type
                               mainKeyIndex:(int)mainKeyIndex
                            workingKeyIndex:(int)workingKeyIndex
                                       data:(NSData*)data
                                 checkValue:(NSData*)checkValue
                                      error:(NSError**)err;
/*!
 @method 装载一个主密钥
 @abstract
 @param kekKeyIndex KEK密钥索引
 @param masterKeyIndex 装入的主密钥索引
 @param data 密钥数据
 @throws PinFailedException 若失败，且带具体的应答，抛出该异常。
 @return
 */
- (void)loadMasterKeyWithKEKKeyIndex:(int)kekKeyIndex
                      masterKeyIndex:(int)masterKeyIndex
                                data:(NSData*)data
                               error:(NSError**)err NL_DEPRECATED_API;
/*!
 @version 1.0.6
 @method 装载一个主密钥
 @abstract
 @param keyUsingType kekUsingType kek传输计算方式
 @param mainIndex mainIndex 主密钥索引
 @param data 主密钥数据
 @return kcv,默认为对8个字节的<tt>null</tt>加密，返回结果6个字节
 */
- (NSData*)loadMainKeyWithKeyUsingType:(NLKekUsingType)keyUsingType
                             mainIndex:(NSInteger)mainIndex
                                  data:(NSData*)data
                                 error:(NSError**)err;
/*!
 @version 1.0.6
 @method 装载一个主密钥
 @abstract
 @param keyUsingType kekUsingType kek传输计算方式
 @param mainIndex mainIndex 主密钥索引
 @param transportKeyIndex 传输主密钥索引
 @param data 主密钥数据
 @return kcv,默认为对8个字节的<tt>null</tt>加密，返回结果6个字节
 */
- (NSData*)loadMainKeyWithKeyUsingType:(NLKekUsingType)keyUsingType
                             mainIndex:(NSInteger)mainIndex
                     transportKeyIndex:(NSInteger)transportKeyIndex
                                  data:(NSData*)data error:(NSError**)err;
/*!
 @version 1.1.5
 @method 装载主密钥（支持pos校验kcv）
 @abstract
 @param keyUsingType kekUsingType 主密钥装载方式
 @param mainIndex mainIndex 主密钥索引
 @param transportKeyIndex 传输密钥索引（该字段只在kekUsingType为PRIVATE_KEY时设置，其他情况下置为-1即可）
 @param data 待加载的主密钥数据
 @param checkValue 主密钥校验值
 @return kcv 当输入参数传入checkValue时返回全0数据，反之则返回kcv用于外部自行校验
 */
- (NSData*)loadMainKeyWithKeyUsingType:(NLKekUsingType)keyUsingType
                             mainIndex:(NSInteger)mainIndex
                     transportKeyIndex:(NSInteger)transportKeyIndex
                                  data:(NSData*)data
                            checkValue:(NSData*)checkValue
                                 error:(NSError**)err;
/**
 *  装载公钥
 *
 *  @param keyType    KEK 模式
 *  @param pkIndex    公钥索引
 *  @param pkLength   公钥长度
 *  @param pkModule   公钥的 Module
 *  @param pkExponent 公钥的 Exponent
 *  @param index      主密钥索引[作为传输 密钥]
 *  @param mac        MAC
 *
 *  @return NLLoadPKResultCode
 */
-(NLLoadPKResultCode)loadPublicKeyWithLoadPKType:(NLLoadPKType)keyType
                                         pkIndex:(NSInteger)pkIndex
                                        pkLength:(NLLoadPKLenType)pkLength
                                        pkModule:(NSData *)pkModule
                                      pkExponent:(NSData *)pkExponent
                                           index:(NSData *)index
                                             mac:(NSData *)mac;
/**
 *  装载DUKPT的KNS和初始密钥
 *
 *  @param keytype        KEK 模式
 *  @param ksnIndex       KSN 索引
 *  @param ksn            KSN
 *  @param defaultKeyData 装载的初始密钥数据
 *  @param mainKeyIndex   主密钥索引[作为传输 密钥]
 *  @param checkValue     CheckValue
 *
 *  @return NLKSNLoadResultCode
 */
-(NLKSNLoadResultCode)ksnLoadWithKSNKeyType:(NLKSNKeyType)keytype
                                   ksnIndex:(NSInteger)ksnIndex
                                        ksn:(NSData *)ksn
                             defaultKeyData:(NSData *)defaultKeyData
                               mainKeyIndex:(NSInteger)mainKeyIndex
                                 checkValue:(NSData *)checkValue;

@end

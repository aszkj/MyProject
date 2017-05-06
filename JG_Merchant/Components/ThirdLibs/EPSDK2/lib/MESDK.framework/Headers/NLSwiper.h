//
//  NLSwiper.h
//  mpos
//
//  Created by su on 13-6-16.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLFoundation.h"
#import "NLModule.h"
#import "NLSwipeResult.h"
#import "NLWorkingKey.h"
#import "NLTrackSecurityPaddingType.h"

/*!
 @enum
 @abstract 
    刷卡过程读取类型
 @constant NLSwiperReadModelReadFirstTrack 读取第一磁道
 @constant NLSwiperReadModelReadSecondTrack 读取第二磁道
 @constant NLSwiperReadModelReadThirdTrack 读取第三磁道
 @constant NLSwiperReadModelReadICSecondTrack 读取 IC 卡二磁道等效信息
 */
typedef enum {
    NLSwiperReadModelReadFirstTrack = 0x01,
    NLSwiperReadModelReadSecondTrack = 0x02,
    NLSwiperReadModelReadThirdTrack = 0x04,
    NLSwiperReadModelReadICSecondTrack = 0x12
}NLSwiperReadModel;

/*!
 @protocol Swiper刷卡器接口
 @abstract 刷卡器接口
 @discussion
    当调用{@link NLCardReader#openCardReader}后,若返回类型为{@link ModuleType#COMMON_SWIPER},则可以调用该接口的方法具体读取磁道数据<p>
 */
@protocol NLSwiper <NLModule>
/*!
 @method 等待timeout秒进行刷卡
 @abstract  如果无法刷卡将返回No、刷卡失败也返回No；成功进入刷卡模式，将阻塞timeout秒，等待用户刷卡，成功返回YES
 @param timeout 刷卡等待时间
 @return 是否刷卡成功
 */
- (BOOL)checkOpenSwiperWithTimeout:(int)timeout;
- (void)closeSwiper;
/*!
 @method 按标准的公钥保护体系获取刷卡结果。
 @abstract  刷卡结果的磁道信息将受到磁道公钥保护。
 @param readModel 读取模式
 @param flowId 12位平台流水号
 @param random 8位随机数
 @return 刷卡结果
 */
- (NLSwipeResult*)readPKIResultWithReadModel:(NLSwiperReadModel)readModel flowId:(NSString*)flowId random:(NSData*)random NL_DEPRECATED_AT(1_0_6);
/*!
 @method 通过安全认证后，使用明文方式返回刷卡结果。
 @abstract 刷卡结果的磁道信息返回结果为明文。若不支持该方法，该方法可能抛出<tt>UnsupportedOperationException
 @param readModel 读取模式
 @return 刷卡数据
 */
- (NLSwipeResult*)readPlainResultWithReadModel:(NLSwiperReadModel)readModel NL_DEPRECATED_AT(1_0_6);
/*!
 @since version 1.1.3
 @method 通过安全认证后，使用明文方式返回刷卡结果。
 @abstract 刷卡结果的磁道信息返回结果为明文。若不支持该方法，该方法可能抛出<tt>UnsupportedOperationException
 @param readModels 读取模式集合
 @return 刷卡数据
 */
- (NLSwipeResult*)readPlainResultWithReadModels:(NSArray*)readModels;
/*!
 @method 按传统密钥体系返回刷卡结果
 @abstract 刷卡结果的磁道信息返回将使用传统的<tt>MK/WK</tt>方式.
 @discussion
     无论正反刷磁条卡，设备在读取指定磁道数据后，除了对读取磁道数据进行正确性校验，获取主账号数据和字节补位外，不做任何处理.<p>
     之后根据指令要求的加密方式对磁道数据进行加密。为了防止磁道加密数据的重复使用，磁道加密前，将填充完的平台流水号（12个字节）+随机数(或金额)（8个字节）+ MPOS硬件序列号（20个字节）+磁道加密数据合并进行加密。
     平台解密后需先验证随机数，再进行交易，平台流水号用于标识交易。
 @param readModel 磁道读取方式
 @param wk 工作密钥
 @param seed 随机因子(或金额)
 @param flowId 12位流水号
 @param encryptAlgorithm 加密算法
 @return 刷卡数据
 */
- (NLSwipeResult*)readSimposResultWithReadModel:(NSArray*)readModel
                                             wk:(NLWorkingKey*)wk
                                           seed:(NSData*)seed
                                         flowId:(NSString*)flowId
                               encryptAlgorithm:(NSString*)encryptAlgorithm NL_DEPRECATED_API;
/*!
 @deprecated at 1.0.6
 @method 按传统密钥体系返回刷卡结果
 @abstract 刷卡结果的磁道信息返回将使用传统的<tt>MK/WK</tt>方式.
 @discussion
 无论正反刷磁条卡，设备在读取指定磁道数据后，除了对读取磁道数据进行正确性校验，获取主账号数据和字节补位外，不做任何处理.<p>
 之后根据指令要求的加密方式对磁道数据进行加密。为了防止磁道加密数据的重复使用，磁道加密前，将填充完的平台流水号（12个字节）+随机数(或金额)（8个字节）+ MPOS硬件序列号（20个字节）+磁道加密数据合并进行加密。
 平台解密后需先验证随机数，再进行交易，平台流水号用于标识交易。
 @param readModel 磁道读取方式
 @param wk 工作密钥
 @param seed 随机因子(或金额)
 @param flowId 12位流水号
 @param encryptAlgorithm 加密算法
 @return 刷卡数据
 */
- (NLSwipeResult*)readSimposResultWithReadModel:(NSArray*)readModel
                       trackSecurityPaddingType:(NLTrackSecurityPaddingType)trackSecurityPaddingType
                                             wk:(NLWorkingKey*)wk
                                           seed:(NSData*)seed
                                         flowId:(NSString*)flowId
                               encryptAlgorithm:(NSString*)encryptAlgorithm;
/*!
 @method
 @abstract
 磁道算法标示不再关注是否填充,是否需要填充由算法自行判定<p>
 @discussion
 @since 1.0.3
 @return
 */
- (NLSwipeResult*)readEncryptResultWithReadModel:(NSArray*)readModel
                               securePaddingType:(NLTrackSecurityPaddingType)securePaddingType
                                              wk:(NLWorkingKey*)wk
                                encryptAlgorithm:(NSString*)encryptAlgorithm
                                            seed:(NSData*)seed
                                          flowId:(NSString*)flowId;
/*!
 @method
 @abstract
 按主密钥/工作密钥(MK/SK)的方式，返回磁条卡数据<p>
 使用不填充安全数据方式读取<p>
 @discussion
 @see #readSimposResult
 @since ver1.0
 @param readModel 磁道的读取模式
 @param wk 参与运算的工作密钥
 @param encryptAlgorithm 算法标示,使用那种算法加密输出的磁道数据
 @return
 */
- (NLSwipeResult*)readEncryptResultWithReadModel:(NSArray*)readModel
                                              wk:(NLWorkingKey*)wk
                                encryptAlgorithm:(NSString*)encryptAlgorithm;

@end

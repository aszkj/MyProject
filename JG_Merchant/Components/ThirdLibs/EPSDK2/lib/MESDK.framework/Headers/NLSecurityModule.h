//
//  NLSecurityModule.h
//  mpos
//
//  Created by su on 13-6-18.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLModule.h"
#import "NLDeviceInfo.h"
typedef enum {
    NLCertifiedModelSymmetric,
    NLCertifiedModelASymmetric,
} NLCertifiedModel;


/*!
 @protocol SecurityModule设备安全模块
 @abstract 设备安全模块<p>该接口用于定义大部分端对端认证的实现，这部分密钥体系独立于<tt>pos</tt>密钥体系。<p>
 @discussion 考虑以下的认证过程：<p>
 * <ol><li>
 * 新设备接入新环境，要求接入环境进行认证。</li><li>
 * 应用向设备申请一个随机数<b>R1</b>。</li><li>
 * 应用将该设备<b>设备号</b>和<b>R1</b>发给服务器</li><li>
 * 服务器使用对应设备的<p>对称密钥</p>或<b>设备公钥</b>对<b>R1</b>进行加密，生成认证信息<b>C1</b></li><li>
 * 服务器端同时生成一个随机数<b>R2</b>,同时返回<b>C1</b>和<b>R2</b></li><li>
 * 应用将<b>C1</b>和<b>R2</b>返回给设备</li><li>
 * 设备认证<b>C1</b>，通过后，使用对成密钥或<b>服务器公钥</b>对<b>R2</b>进行处理，生成认证信息<b>C2</b>(生成过程参考{@link #deviceIdentify})，返回给应用。同时认为环境安全，该连接将可以接受其他指令。</li><li>
 * 应用将<b>	C2</b>送给服务器，服务器将在Session中设置安全标示，可以接收该连接所有的交易请求。</li>
 
 * </ol>
 *
 * 安全模块用于提供以上认证过程的接口支撑。<p>
 * TODO
 *
 */
@protocol NLSecurityModule <NLModule>
/*!
 @method 获得设备信息
 @abstract
 @return
 */
- (id<NLDeviceInfo>)deviceInfo;
/*!
 @method 获得一个线路保护的随机数
 @abstract 该随机数有效性持续到下一个设备认证指令结束为止
 @return
 */
- (NSData*)securityRandom;
/*!
 @method
 @abstract 设备认证
 @discussion
     非对称密钥认证流程：客户端发起监测到有设备投入使用时，向后台申请8个字节的随机数对设备进行认证，刷卡设备用自己的设备私钥对设备硬件编号+随机数计算签名返回给后台做验证<p>
     对称密钥认证流程：客户端发起监测到有设备投入使用时，向后台申请8个字节的随机数对设备进行认证，设备用内置认证密钥离散出的子密钥(会话密钥)（用认证密钥对随机数加密作为会话密钥）对设备硬件编号（前8字节）+随机数（8字节）做3DES加密返回结果给后台做验证
 @param model 认证方式
 @param random 随机数
 @return
 */
- (NSString*)deviceIdentifyWithCertifiedModel:(NLCertifiedModel)model random:(NSData*)random;
/*!
 @method
 @abstract 服务端认证
 @discussion
    该命令用于设备外部认证。使用设备主控密钥对服务器端产生的加密的随机数进行验证，加密数据计算的输入数据为从设备获取8字节的随机数.
 @param model 认证方式
 @param security 随机数
 */
- (void)serverIdentifyWithCertifiedModel:(NLCertifiedModel)model security:(NSData*)security;
/*!
 @version 1.0.6
 @method
 @abstract 在线更新密钥接口
 @discussion
 * 若<tt>model</tt>设置为：<ol><li>
 * {@link CertifiedModel#SYMMETRIC}:该方法更新的是设备认证的<b>对称密钥</b>。</li><li>
 * {@link CertifiedModel#ASYMMETRIC}:该方法更新的是设备认证的<b>服务器端公钥</b>。</li>
 * </ol><p>
 @param model 认证方式
 @param security 随机数
 */
- (void)updateIdentifySecurity:(NLCertifiedModel)model pkData:(NSData*)pkData;
/*!
 @version 1.0.6
 @method
 @abstract 设置CSN
 @discussion
 @param csn 客户序列号
 */
- (void)setCSN:(NSString*)csn;

@end

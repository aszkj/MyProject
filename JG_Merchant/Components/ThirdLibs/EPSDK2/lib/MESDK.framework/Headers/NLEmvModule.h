//
//  NLEmvModule.h
//  MTypeSDK
//
//  Created by su on 14-1-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "NLModule.h"
#import "NLEmvTagRef.h"
#import "NLAIDConfig.h"
#import "NLCAPublicKey.h"
#import "NLTerminalConfig.h"
#import "NLOnlinePinConfig.h"
#import "NLEmvCardInfo.h"
#import "NLEmvTransController.h"
#import "NLEmvControllerListener.h"

/*!
 @protocol
 @abstract emv通用模块接口
 @discussion
 */
@protocol NLEmvModule <NLModule>
/**
 * 获得一个系统内支持的标签的参考参考<p>
 * 若系统内不支持该标签定义则返回为空.
 *
 * @return
 */
- (id<NLEmvTagRef>)systemSupportTagRef:(int)tag;

/**
 * 清理一个rid以下全部的全部公钥
 *
 * @param rid 认证中心(应用提供方)标识.(Registered Application Provider Identifier)
 */
- (BOOL)clearAllCAPublicKey:(NSData*)rid;

/**
 * 删除一个rid以下某个索引对应公钥<p>
 *
 * @param rid 认证中心(应用提供方)标识.(Registered Application Provider Identifier)
 * @param index 对应的公钥索引
 */
- (BOOL)deleteCAPublicKey:(NSData*)rid index:(int)index;

/**
 * 增加一组公钥
 *
 * @param capk 被导入的公钥
 */
- (BOOL)addCAPublicKeyData:(NSData *)capk;
/**
 * 增加一组公钥
 *
 * @param capk 被导入的公钥
 * @param rid 被导入的公钥rid
 */
- (BOOL)addCAPublicKey:(NLCAPublicKey*)capk rid:(NSData*)rid;

/**
 * 清理所有应用配置参数
 */
- (BOOL)clearAllAID;

/**
 * 增加一个应用配置参数
 *
 * @param aid 应用标识(Application Identifier)\应用配置参数
 */
- (BOOL)addAIDData:(NSData*)aidConfig;

/**
 * 增加一个应用配置参数
 *
 * @param aid 应用标识(Application Identifier)
 * @param appConfig 应用配置参数
 */
- (BOOL)addAID:(NLAIDConfig*)aidConfig;


/**
 * 删除一个应用配置参数
 *
 * @param aid 应用标识(Application Identifier)
 */
- (BOOL)deleteAID:(NSData*)aid;

/**
 * 设置终端参数 <p>
 *
 * @param trmnlConfig 对应的终端参数配置
 */
- (BOOL)setTrmnlParams:(NLTerminalConfig*)trmnlConfig;

/**
 * 获得一个emv流程下的账户信息
 *
 * @param tags 可以根据需求获取在EMV标准流程中相关的交易数据信息.该<tt>tags</ttt>表示这样的一个集合.
 * @return
 * 		卡信息,以及根据请求扩展的标签数据
 */
- (NLEmvCardInfo*)accountInfoWithTags:(NSArray*)tags;

-(void)setOnlinePinConfig:(NLOnlinePinConfig *)cofig;
-(NLOnlinePinConfig *)getOnlinePinConfig;

/**
 * 获得一个EMV交易控制器<p>
 * 每次交易都要单独申请一个控制器，其会单一流程的完成整个EMV交易，不能重复使用。<p>
 *
 * @param emvControllerListener EMV监听器,客户通过定义,定制希望在这个交易过程的响应处理.
 * @return
 * 		EMV控制器
 */
- (NSObject<NLEmvTransController>*)emvTransControllerWithListener:(id<NLEmvControllerListener>)emvControllerListener;
/**
 * 获得一个EMV交易控制器<p>
 * 每次交易都要单独申请一个控制器，其会单一流程的完成整个EMV交易，不能重复使用。<p>
 *
 * @param emvControllerListener EMV监听器,客户通过定义,定制希望在这个交易过程的响应处理.
 * @param tlvPackage 初始化参数如流水号等（该参数中若tag与后续参数重复则参数赋值会被覆盖）
 * @return
 * 		EMV控制器
 */
- (NSObject<NLEmvTransController>*)emvTransControllerWithListener:(id<NLEmvControllerListener>)emvControllerListener tlvPackage:(id<TLVPackage>)tlvPackage;
@end

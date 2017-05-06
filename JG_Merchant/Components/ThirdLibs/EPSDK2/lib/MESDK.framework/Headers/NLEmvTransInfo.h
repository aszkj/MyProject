//
//  NLEmvTransInfo.h
//  MTypeSDK
//
//  Created by su on 14-1-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "NLAbstractEmvPackage.h"

@interface NLEmvTransInfo : NLAbstractEmvPackage<NLEmvTagDefinedDataSource>
/**
 * 卡号
 */
@property (nonatomic, strong) NSString *cardNo;
/**
 * 设备序列号
 */
@property (nonatomic, strong) NSString *interface_device_serial_number;
/**
 * 卡序列号 23域
 */
@property (nonatomic, strong) NSString *cardSequenceNumber;
/**
 * 卡的过期日期
 */
@property (nonatomic, strong) NSString *cardExpirationDate;
/**
 * 应用密文<p>
 */
@property (nonatomic, strong) NSData *appCryptogram;
/**
 * pboc执行结果
 */
@property (nonatomic) int executeRslt;
/**
 * 密文信息数据
 */
@property (nonatomic) Byte cryptogramInformationData;
@property (nonatomic, strong) NSData *issuerApplicationData;
@property (nonatomic, strong) NSData *unpredictableNumber;
/**
 * 交易计数器<p>
 */
@property (nonatomic, strong) NSData *appTransactionCounter;
/**
 * 终端认证结果(TVR)<p>
 */
@property (nonatomic, strong) NSData *terminalVerificationResults;
/**
 * 交易日期<p>
 */
@property (nonatomic, strong) NSString *transactionDate;
/**
 * 交易类型<p>
 */
@property (nonatomic) int transactionType;
/**
 * 授权金额
 */
@property (nonatomic, strong) NSString *amountAuthorisedNumeric;
@property (nonatomic, strong) NSString *transactionCurrencyCode;
@property (nonatomic, strong) NSData *applicationInterchangeProfile;
@property (nonatomic, strong) NSString *terminalCountryCode;
/**
 * 授权金额（其他）
 */
@property (nonatomic, strong) NSString *amountOtherNumeric;
@property (nonatomic, strong) NSData *additionalTerminalCapabilities;
@property (nonatomic, strong) NSData *ecIssuerAuthorizationCode;

/**********************************************可选信息子域列表***************************************************/
@property (nonatomic, strong) NSData *cvmRslt;
@property (nonatomic, strong) NSString *terminalType;
//	@property (nonatomic, strong) NSString *integererfaceDeviceSerialNumber;
@property (nonatomic, strong) NSData *dedicatedFileName;
@property (nonatomic, strong) NSData* appVersionNumberTerminalData;
@property (nonatomic, strong) NSData *transactionSequenceCounter;
@property (nonatomic, strong) NSData *issuerAuthenticationData;
@property (nonatomic, strong) NSData *issuerScriptTemplate1;
@property (nonatomic, strong) NSData *issuerScriptTemplate2;
/**
 * 脚本执行结果<p>
 */
@property (nonatomic, strong) NSData *scriptExecuteRslt;
/**
 * 脚本执行结果<p>
 */
@property (nonatomic, strong) NSData *cardProductIdatification;
@property (nonatomic, strong) NSString *authorisationResponseCode;
/**
 * 芯片序列号
 */
@property (nonatomic, strong) NSData *chipSerialNo;
/**
 * 过程密钥数据
 */
@property (nonatomic, strong) NSData *sessionKeyData;
/**
 * 终端读取数据时间
 */
@property (nonatomic, strong) NSString *terminalReadingTime;
/**
 * 在线pin输入标志
 */
@property (nonatomic, strong) NSData *onLinePin;
@property (nonatomic, strong) NSString *pbocCardFunds;
@property (nonatomic, strong) NSString *qpbocCardFunds;
@property (nonatomic, strong) NSData *terminal_capabilities;
@property (nonatomic, strong) NSData *inner_transaction_type;
@property (nonatomic, strong) NSData *track_2_eqv_data;
@property (nonatomic, strong) NSData *aid_card;
@property (nonatomic, strong) NSString *transaction_time;
@property (nonatomic, strong) NSData *errorcode;
@property (nonatomic, strong) NSString *point_of_service_entry_mode;
@property (nonatomic, strong) NSData *transaction_status_information;
@property (nonatomic, strong) NSString *app_preferred_name;
@property (nonatomic, strong) NSString *application_label;
#pragma mark - ME11
/**
 * DF78 加密的55域及相关信息
 */
@property (nonatomic, strong) NSData *encrypt_data;
/**
 *  df79 ksn
 */
@property (nonatomic, strong) NSData *ksn;
/**
 *  df77
 */
@property (nonatomic, strong) NSData * e_cash_details;
- (int)appVersionNumberTerminal;
@end

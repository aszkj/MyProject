//
//  NLTerminalConfig.h
//  MTypeSDK
//
//  Created by su on 14-1-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "NLAbstractEmvPackage.h"

@interface NLTerminalConfig : NLAbstractEmvPackage<NLEmvTagDefinedDataSource>
@property (nonatomic, strong) NSData *trmnlICSConfig;
@property (nonatomic) int terminalType;
@property (nonatomic, strong) NSData *terminalCapabilities;
@property (nonatomic, strong) NSData *additionalTerminalCapabilities;
@property (nonatomic) int pointOfServiceEntryMode;
@property (nonatomic, strong) NSString *acquirerIdentifier;
@property (nonatomic, strong) NSString *merchantCategryCode;
@property (nonatomic, strong) NSString *merchantIdentifier;
@property (nonatomic, strong) NSString *transactionCurrencyCode;
@property (nonatomic, strong) NSString *transactionCurrencyExp;
@property (nonatomic, strong) NSString *transationReferenceCurrencyCode;
@property (nonatomic, strong) NSString *transationReferenceCurrencyExp;
@property (nonatomic, strong) NSData *terminalCountryCode;
@property (nonatomic, strong) NSString *interfaceDeviceSerialNumber;
@property (nonatomic, strong) NSString *terminalIdentification;
/**
 * 默认的交易证书数据对象列表(TDOL)
 */
@property (nonatomic, strong) NSData *defaultTDOL;
/**
 * 是否支持部分AID匹配
 */
@property (nonatomic) Byte aidPartlyMatchSupported;
/**
 * fallback posentry
 */
@property (nonatomic, strong) NSData *fallbackPosentry;
@end

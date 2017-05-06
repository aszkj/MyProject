//
//  NLEmvCardInfo.h
//  MTypeSDK
//
//  Created by su on 14-1-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "NLAbstractEmvPackage.h"

/*!
 @class
 @abstract 获取一个emv流程中的被处理卡信息
 @discussion
 */
@interface NLEmvCardInfo : NLAbstractEmvPackage<NLEmvTagDefinedDataSource>
/**
 * 卡号
 */
@property (nonatomic, strong) NSString *cardNo;
/**
 * IFD序列号
 */
@property (nonatomic, strong) NSString *interface_device_serial_number;
@property (nonatomic, strong) NSString *card_sequence_number;
/**
 * 卡的过期日期
 */
@property (nonatomic, strong) NSString *cardExpirationDate;
/**
 * 卡余额
 */
@property (nonatomic, strong) NSString *cardBalance;
- (id)initWithCardNo:(NSString*)cardNo interface_device_serial_number:(NSString*)interface_device_serial_number card_sequence_number:(NSString*)card_sequence_number cardExpirationDate:(NSString*)cardExpirationDate;
@end

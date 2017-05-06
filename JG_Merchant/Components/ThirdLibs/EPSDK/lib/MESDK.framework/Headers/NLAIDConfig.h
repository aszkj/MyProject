//
//  NLAIDConfig.h
//  MTypeSDK
//
//  Created by su on 14-1-26.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "NLAbstractEmvPackage.h"

@interface NLAIDConfig : NLAbstractEmvPackage<NLEmvTagDefinedDataSource>
@property (nonatomic, strong) NSData *aid;
/**
 * 应用选择指示符（ASI）
 */
@property (nonatomic) NSInteger appSelectIndicator;
/**
 * 应用版本号
 */
@property (nonatomic, strong) NSData *appVersionNumberTerminal;
/**
 *  TAC缺省
 */
@property (nonatomic, strong) NSData *tacDefault;
/**
 * TAC联机
 */
@property (nonatomic, strong) NSData *tacOnLine;
/**
 * TAC拒绝
 */
@property (nonatomic, strong) NSData *tacDenial;

@property (nonatomic, strong) NSData *terminalFloorLimit;
/**
 * 偏置随机选择的阈值
 */
@property (nonatomic, strong) NSData *thresholdValueForBiasedRandomSelection;

/**
 * 偏置随机选择的最大目标百分数
 */
@property (nonatomic) NSInteger maxTargetPercentageForBiasedRandomSelection;
/**
 * 随机选择的目标百分数
 */
@property (nonatomic) NSInteger targetPercentageForRandomSelection;
/**
 * 缺省的DDOL
 */
@property (nonatomic, strong) NSData *defaultDDOL;
/**
 * 终端联机PIN支持能力
 */
@property (nonatomic) NSInteger onLinePinCapability;
/**
 * 电子现金交易限额
 */
@property (nonatomic, strong) NSData *ecTransLimit;
/**
 * 非接卡脱机最低限额
 */
@property (nonatomic, strong) NSData *nciccOffLineFloorLimit;
/**
 * 非接卡交易限额
 */
@property (nonatomic, strong) NSData *nciccTransLimit;
/**
 * 非接交易触发CVM交易限额
 */
@property (nonatomic, strong) NSData *nciccCVMLimit;
/**
 * 是否支持电子现金
 */
@property (nonatomic) NSInteger ecCapability;
/**
 * 核心配置类型
 */
@property (nonatomic) NSInteger coreConfigType;
/**
 * 交易类型
 */
@property (nonatomic) int transactionType;
@end

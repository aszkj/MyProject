//
//  PhysicalReportDetailModel.h
//  jingGang
//
//  Created by HanZhongchou on 15/10/28.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhysicalReportDetailModel : NSObject
/**
 *  体检报告id
 */
@property (nonatomic, copy) NSNumber *id;
/**
 *  体检项目
 */
@property (nonatomic, copy) NSString *physicalName;
/**
 *  最小值
 */
@property (nonatomic, copy) NSString *minVale;
/**
 *  最大值
 */
@property (nonatomic, copy) NSString *maxValue;
/**
 *  实际值
 */
@property (nonatomic, copy) NSString *referenceValue;
/**
 *  阴阳参考值0阴1阳阳性
 */
@property (nonatomic, copy) NSString *positive;
/**
 *  单位
 */
@property (nonatomic, copy) NSString *unit;
/**
 *  结果|0正常、1超标
 */
@property (nonatomic, copy) NSString *result;
/**
 *  结果|输入型参考值
 */
@property (nonatomic, copy) NSString *value;
/**
 *  结果|0数值型（录入）、1选项型（阴、阳值）
 */
@property (nonatomic, assign) NSInteger type;

@end

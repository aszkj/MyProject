//
//  JGIntegralValueModel.h
//  jingGang
//
//  Created by dengxf on 15/12/26.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGIntegralValueModel : NSObject


/**
 *  云币变更数值
 */
@property (nonatomic,copy) NSString *pdLogAmount;
/**
 *  变更信息
 */
@property (nonatomic,copy) NSString *pdLogInfo;
/**
 *  云币变更时间
 */
@property (nonatomic,copy) NSString *addTime;
/**
 *  实时剩余云币、积分
 */
@property (nonatomic,assign) CGFloat balance;
/**
 *  云币变更类型
 */
@property (nonatomic,copy) NSString *pdOpType;


#pragma mark ---- 积分明细数据模型
/**
 *  积分变更类型
 */
@property (nonatomic,copy) NSString *type;
/**
 *  变更时间,积分
 */
@property (nonatomic,copy) NSString *addtime;
/**
 *  变更详细积分
 */
@property (nonatomic,copy) NSString *integral;


@end

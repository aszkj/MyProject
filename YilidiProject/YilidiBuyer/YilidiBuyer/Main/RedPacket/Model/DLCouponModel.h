//
//  DLCouponModel.h
//  YilidiBuyer
//
//  Created by mm on 16/10/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface DLCouponModel : BaseModel

/**
 各类券ID
 */
@property (nonatomic,copy)NSString *ticketId;

/**
 奖券数量
 */
@property (nonatomic,assign)NSInteger ticketCount;
/**
 奖券类型
 1：优惠券
 2：抵用券
 */
@property (nonatomic,assign)NSInteger ticketType;
/**
奖券类型名称：对应ticketType值
 */
@property (nonatomic,copy)NSString *ticketTypeName;

/**
有效期开始时间
 */
@property (nonatomic,copy)NSString *beginTime;
/**
 有效期结束时间
 */
@property (nonatomic,copy)NSString *endTime;
/**
奖券金额
 */
@property (nonatomic,assign)NSInteger ticketAmount;
/**
 奖券限制使用金额
 */
@property (nonatomic,assign)NSInteger limitedAmount;
/**
 使用范围描述
 */
@property (nonatomic,copy)NSString *userCope;
/**
奖券描述
 */
@property (nonatomic,copy)NSString *ticketDescription;
/**
 奖券的状态类型
 */
@property (nonatomic,assign)NSInteger ticketStatus;
/**
奖券的状态类型名称
 */
@property (nonatomic,copy)NSString *ticketStatusName;

/**
 订单能否使用该奖券：（前端需要根据该字段进行重新排序）
 0：不能使用
 1：能使用
 */
@property (nonatomic,assign)NSInteger wouldUse;


-(long)validTicketEndTime;


@end

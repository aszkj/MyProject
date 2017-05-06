//
//  KJOrderStatusQuery.h
//  jingGang
//
//  Created by 张康健 on 15/8/24.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

//查询订单状态
#import <Foundation/Foundation.h>

typedef void(^RollingResultBlock)(BOOL success);

typedef void(^CloudPayResultBlock) (BOOL success,id response);

@interface KJOrderStatusQuery : NSObject

-(id)initWithQueryOrderID:(NSNumber *)orderID;

/**
 *  开启轮询云币支付 */
- (void)beginRollingQueryCloudPayResultIntervalTime:(NSInteger)rollingInterval rollingResult:(CloudPayResultBlock)rollingResult;

//开启轮询
-(void)beginRollingQueryWithIntervalTime:(NSInteger)rollingInterval rollingResult:(RollingResultBlock)rollingResult;

//这里用枚举最好，，没改
//是否是服务订单查询，默认no
@property (nonatomic, assign)BOOL isServiceOrderQuery;

//是否积分商品订单
@property (nonatomic, assign)BOOL isIntegralGoodsOrderQuery;

/**
 *  充值云币 */
@property (assign, nonatomic) BOOL isCloudPayOrderQuery;



@end

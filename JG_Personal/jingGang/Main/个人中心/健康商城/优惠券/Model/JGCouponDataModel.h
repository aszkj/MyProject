//
//  JGCouponDataModel.h
//  jingGang
//
//  Created by HanZhongchou on 16/1/22.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGCouponDataModel : NSObject
/**
 *  优惠券名称
 */
@property (nonatomic,copy) NSString *couponName;
/**
 *  优惠券ID
 */
@property (nonatomic,copy) NSString *id;
/**
 *  优惠券金额
 */
@property (nonatomic,copy) NSString *couponAmount;
/**
 *  优惠券发行数量
 */
@property (nonatomic,copy) NSString *couponCount;
/**
 *  优惠券所能使用的订单金额，订单满足该金额时才可以使用该优惠券
 */
@property (nonatomic,copy) NSString *couponOrderAmount;
/**
 *  优惠券状态  0默认   1已使用 -1已过期
 */
@property (nonatomic,assign) NSInteger couponStatus;
/**
 *  优惠券所属店铺名称
 */
@property (nonatomic,copy) NSString *storeName;
/**
 *  优惠券使用开始时间
 */
@property (nonatomic,copy) NSString *couponBeginTime;
/**
 *  优惠券使用结束时间
 */
@property (nonatomic,copy) NSString *couponEndTime;
/**
 *  优惠券类型
 */
@property (nonatomic,assign) NSInteger couponType;
@end

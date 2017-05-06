//
//  IncomeStatisticsModel.h
//  Operator_JingGang
//
//  Created by HanZhongchou on 15/11/4.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IncomeStatisticsModel : NSObject
/**
 *   返润收益     注册返润收益|辖区返润收益|隶属返润收益|支付手续收益
 */
@property (nonatomic,copy) NSString *profitAmount;
/**
 *  one Itme  数据  推荐运营商|本辖本消|本隶本消|隶属支付
 */
@property (nonatomic,copy) NSString *recommedAmount;
/**
 *  two Item  数据  推荐商户|本辖外销|本隶外消|辖区支付
 */
@property (nonatomic,copy) NSString *storeAmount;
/**
 *  three Item 数据 推荐会员|外辖本消|外隶本消|推荐收益
 */
@property (nonatomic,copy) NSString *userAmount;

/**
 *  type  类型|1注册返润 2辖区返润 3隶属返润 4支付手续 5推荐购买分润 6推荐产品分润
 */
@property (nonatomic,copy) NSString *type;
/**
 *  rcRebate  推荐购买分润
 */
@property (nonatomic,copy) NSString *rcRebate;
/**
 *  rsRebate  推荐产品分润
 */
@property (nonatomic,copy) NSString *rsRebate;
@end

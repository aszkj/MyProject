//
//  JGChristmasMananger.h
//  jingGang
//
//  Created by dengxf on 15/12/18.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserIntegral.h"
@class ActivityHotSaleApiBO;
/** 圣诞节活动管理类 */
@interface JGChristmasMananger : NSObject

+ (instancetype)sharedInstanced;

/** 查询活动信息 */
- (void)queryActivityInformationSuccess:(void(^)(ActivityHotSaleApiBO *apiBO))success fail:(void(^)())fail;

/**
 *  查积分商品
 *
 *  @param pageSize    查询的个数
 *  @param pageNum     查询的页数
 *  @param minIntegral 最小积分
 *  @param maxIntegral 最大积分
 *  @param findAll     是否查全部
 *  @param success     请求成功 返回一个IntegralListBO模型的数组
 *  @param fail        请求失败
 */
- (void)queryIntegarlListWithPageSize:(NSNumber *)pageSize
                              pageNum:(NSNumber *)pageNum
                          minIntegral:(NSString *)minIntegral
                          maxIntegral:(NSString *)maxIntegral
                              findAll:(BOOL)findAll
                              Suceess:(void (^)(NSArray *integralBOList))success
                                 fail:(void (^)())fail;

/**
 *  查询我的积分情况
 */
- (void)queryUserIntegaralInfoSuccess:(void(^)(UserIntegral *userIntegral))success fail:(void(^)(void))fail;


// 带token查询我的积分
- (void)queryUserIntegaralInfoWithTokenSuccess:(void(^)())success fail:(void(^)())fail;
@end

//
//  APIManager+Helper.h
//  jingGang
//
//  Created by ray on 15/10/28.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "APIManager.h"

@interface APIManager (Helper)

/**
 *  我的体检报告列表
 *
 *  @param pageSize 每页数量
 *  @param pageNum  页数
 */
- (void)reportCheckList:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum
             successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk;
- (void)reportCheckList:(NSNumber *)pageSize pageNum:(NSNumber *)pageNum;
/**
 *  获取用户地址
 */
- (void)getDefaultAddressSuccessBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk;
/**
 *  创建积分订单
 *
 *  @param goodsJson {"goodsId":1,"count":2}
 *  @param addressId 地址Id
 *  @param message   附加信息
 */
- (void)createIntegralOrder:(NSString *)goodsJson
                  addressId:(NSNumber *)addressId igoMsg:(NSString *)message
                 successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk;
/**
 *  获取积分订单详情
 *
 *  @param orderId   订单Id
 */
- (void)getIntegralOrderDetail:(NSNumber *)orderId
                    successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk;
/**
 *  获取用户积分
 */
- (void)getUsersIntegralsuccessBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk;
/**
 *  计算积分订单需要的积分和运费
 *
 *  @param goodsJson 积分商品：[{"goodsId":1,"count":2}]
 *  @param addressId 收货地址ID
 */
- (void)integralComputeOrder:(NSString *)goodsJson addressId:(NSNumber *)addressId                     successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk;
/**
 *  更新密码
 *
 *  @param newPassword 新密码
 *  @param oldPassword 旧密码
 */
- (void)updatePassword:(NSString *)newPassword oldPassword:(NSString *)oldPassword            successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk;

@end

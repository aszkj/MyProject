//
//  ComplainDetailModel.h
//  Operator_JingGang
//
//  Created by HanZhongchou on 15/11/12.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComplainDetailModel : NSObject

/**
 *  订单状态
 */
@property (nonatomic, copy) NSNumber *orderStatus;
/**
 *  订单编号
 */
@property (nonatomic, copy) NSString *orderId;
/**
 *  下单时间
 */
@property (nonatomic, copy) NSDate *payTime;
/**
 *  订单总额
 */
@property (nonatomic, copy) NSNumber *goodsAmount;
/**
 *  商户名称
 */
@property (nonatomic, copy) NSString *groupInfo;
/**
 *  商户电话
 */
@property (nonatomic, copy) NSString *storeTelephone;
/**
 *  地区id
 */
@property (nonatomic, copy) NSString *areaId;
/**
 *  商户所在址
 */
@property (nonatomic, copy) NSString *areaText;
/**
 *  商户详细地址
 */
@property (nonatomic, copy) NSString *storeAddress;
/**
 *  投诉人|买家名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  投诉状态
 */
@property (nonatomic, copy) NSString *status;
/**
 *  投诉人手机
 */
@property (nonatomic, copy) NSString *mobile;
/**
 *  投诉时间
 */
@property (nonatomic, copy) NSDate *addTime;
/**
 *  投诉id
 */
@property (nonatomic, copy) NSNumber *apiId;
/**
 *  问题描述
 */
@property (nonatomic, copy) NSString *problemDesc;
/**
 *  投诉内容
 */
@property (nonatomic, copy) NSString *fromUserContent;
/**
 *  被投诉商户|服务商家
 */
@property (nonatomic, copy) NSString *storeName;
/**
 *  投诉证据1
 */
@property (nonatomic, copy) NSString *fromAcc1;
/**
 *  投诉证据2
 */
@property (nonatomic, copy) NSString *fromAcc2;
/**
 *  投诉证据3
 */
@property (nonatomic, copy) NSString *fromAcc3;
/**
 *  服务名称
 */
@property (nonatomic, copy) NSString *groupName;
/**
 *  服务图片
 */
@property (nonatomic, copy) NSString *groupPhoto;
/**
 *  服务价格
 */
@property (nonatomic, copy) NSString *price;
/**
 *  投诉证据数组
 */
@property (nonatomic, copy) NSArray *fromAccArry;
/**
 *  昵称
 */
@property (nonatomic, copy) NSString *nickname;
/**
 *  仲裁意见
 */
@property (nonatomic, copy) NSString *handleContent;


////昵称
//@property (nonatomic, copy) NSString *nickname;
////仲裁意见
//@property (nonatomic, copy) NSString *handleContent;


@end

//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "IntegralComputeOrderResponse.h"

@interface IntegralComputeOrderRequest : AbstractRequest
/** 
 * 积分商品：[{"goodsId":1,"count":2}]
 */
@property (nonatomic, readwrite, copy) NSString *api_goodsJson;
/** 
 * 收货地址ID
 */
@property (nonatomic, readwrite, copy) NSNumber *api_addressId;
/** 
 * 收货人
 */
@property (nonatomic, readwrite, copy) NSString *api_trueName;
/** 
 * 收货地区ID
 */
@property (nonatomic, readwrite, copy) NSNumber *api_areaId;
/** 
 * 邮政编码
 */
@property (nonatomic, readwrite, copy) NSString *api_zip;
/** 
 * 详细收货地址
 */
@property (nonatomic, readwrite, copy) NSString *api_areaInfo;
/** 
 * 联系手机
 */
@property (nonatomic, readwrite, copy) NSString *api_mobile;
/** 
 * 联系电话
 */
@property (nonatomic, readwrite, copy) NSString *api_telephone;
/** 
 * 兑换附言
 */
@property (nonatomic, readwrite, copy) NSString *api_igoMsg;
@end

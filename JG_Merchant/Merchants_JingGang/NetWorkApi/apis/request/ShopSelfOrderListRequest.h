//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ShopSelfOrderListResponse.h"

@interface ShopSelfOrderListRequest : AbstractRequest
/** 
 * 订单类型
 */
@property (nonatomic, readwrite, copy) NSString *api_orderStatus;
/** 
 * 开始时间
 */
@property (nonatomic, readwrite, copy) NSString *api_beginTime;
/** 
 * 结束时间
 */
@property (nonatomic, readwrite, copy) NSString *api_endTime;
/** 
 * 订单号
 */
@property (nonatomic, readwrite, copy) NSString *api_orderId;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end

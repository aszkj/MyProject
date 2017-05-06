//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SelfOrderListResponse.h"

@interface SelfOrderListRequest : AbstractRequest
/** 
 * 订单类型 order_submit:为已提交待付款 order_pay:为已付款待发货，order_shipping:为已发货待收货 order_receive:为已收货order_finish:买家评价完毕
 */
@property (nonatomic, readwrite, copy) NSString *api_orderStatus;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end

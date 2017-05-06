//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GroupOrderOnlineListResponse.h"

@interface GroupOrderOnlineListRequest : AbstractRequest
/** 
 * 订单状态|0为订单取消，10为已提交待付款，20为已付款，30为买家已使用，全部使用后更新该值,50买家评价完毕 ,60卖家已评价,65订单不可评价
 */
@property (nonatomic, readwrite, copy) NSNumber *api_orderStatus;
/** 
 * 订单类型|1线上订单2线下订单
 */
@property (nonatomic, readwrite, copy) NSNumber *api_orderType;
/** 
 * 线下订单状态
 */
@property (nonatomic, readwrite, copy) NSNumber *api_localStatus;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end

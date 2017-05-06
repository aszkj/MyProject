//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GroupOrderLineDetailsResponse.h"

@interface GroupOrderLineDetailsRequest : AbstractRequest
/** 
 * 订单类型，1 线上订单  2 线下刷卡订单
 */
@property (nonatomic, readwrite, copy) NSNumber *api_orderType;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end

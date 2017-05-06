//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GroupConsumShareListResponse.h"

@interface GroupConsumShareListRequest : AbstractRequest
/** 
 * 订单状态|线上线下服务收入必传|1 线上订单  2 线下刷卡订单
 */
@property (nonatomic, readwrite, copy) NSNumber *api_orderType;
/** 
 * 开始时间
 */
@property (nonatomic, readwrite, copy) NSString *api_startTime;
/** 
 * 结束时间
 */
@property (nonatomic, readwrite, copy) NSString *api_endTime;
@end

//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "OperatorProfitStatisListResponse.h"

@interface OperatorProfitStatisListRequest : AbstractRequest
/** 
 * 开始时间|yyyy-MM-dd HH:mm:ss
 */
@property (nonatomic, readwrite, copy) NSString *api_startTime;
/** 
 * 结束时间|yyyy-MM-dd HH:mm:ss
 */
@property (nonatomic, readwrite, copy) NSString *api_endTime;
/** 
 * 查询类型|0全部,w本周统计,m本月统计,q本季统计,h本半年统计,y本年统计
 */
@property (nonatomic, readwrite, copy) NSString *api_queryType;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end

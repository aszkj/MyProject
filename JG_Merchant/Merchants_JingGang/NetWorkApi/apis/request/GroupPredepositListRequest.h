//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GroupPredepositListResponse.h"

@interface GroupPredepositListRequest : AbstractRequest
/** 
 * 操作类型1充值2提现3消费4兑换金币5人工操作
 */
@property (nonatomic, readwrite, copy) NSNumber *api_opType;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end

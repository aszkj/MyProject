//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GroupOrderCountListResponse.h"

@interface GroupOrderCountListRequest : AbstractRequest
/** 
 * 订单类型
 */
@property (nonatomic, readwrite, copy) NSNumber *api_orderType;
@end

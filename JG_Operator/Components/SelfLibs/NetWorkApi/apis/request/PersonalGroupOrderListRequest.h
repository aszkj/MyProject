//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PersonalGroupOrderListResponse.h"

@interface PersonalGroupOrderListRequest : AbstractRequest
/** 
 * 状态|0已取消,10未付款20未使用,30已使用100退款|
 */
@property (nonatomic, readwrite, copy) NSNumber *api_status;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end

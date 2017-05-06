//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "OperatorBusinessManagementListResponse.h"

@interface OperatorBusinessManagementListRequest : AbstractRequest
/** 
 * 所属类型|0隶属1辖区
 */
@property (nonatomic, readwrite, copy) NSNumber *api_isBeLong;
/** 
 * 时间类型｜1周2月3季4年
 */
@property (nonatomic, readwrite, copy) NSNumber *api_timeType;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end

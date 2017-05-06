//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersCircleInvitationListResponse.h"

@interface UsersCircleInvitationListRequest : AbstractRequest
/** 
 * 圈子id|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_circleId;
/** 
 * 帖子类型|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_invitationType;
/** 
 * 开始查询时间
 */
@property (nonatomic, readwrite, copy) NSNumber *api_times;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end

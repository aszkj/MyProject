//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersInvitationQueryResponse.h"

@interface UsersInvitationQueryRequest : AbstractRequest
/** 
 * 收藏类型 1帖子2医生
 */
@property (nonatomic, readwrite, copy) NSString *api_type;
/** 
 * 帖子类型1用户2官方
 */
@property (nonatomic, readwrite, copy) NSNumber *api_circleType;
/** 
 * 最后一条记录的时间
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

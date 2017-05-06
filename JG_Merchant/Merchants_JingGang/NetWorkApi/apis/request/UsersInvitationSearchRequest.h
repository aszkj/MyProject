//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersInvitationSearchResponse.h"

@interface UsersInvitationSearchRequest : AbstractRequest
/** 
 * 帖子标题|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_title;
/** 
 * 最后一条记录时间
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

//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ComplaintsUsersListResponse.h"

@interface ComplaintsUsersListRequest : AbstractRequest
/** 
 * id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_id;
/** 
 * 名称搜索
 */
@property (nonatomic, readwrite, copy) NSString *api_name;
/** 
 * 投诉状态：1为处理中，3为已完成|必须
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

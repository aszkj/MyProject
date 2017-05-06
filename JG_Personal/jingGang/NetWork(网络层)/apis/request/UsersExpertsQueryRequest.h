//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersExpertsQueryResponse.h"

@interface UsersExpertsQueryRequest : AbstractRequest
/** 
 * 专家类型1专家2健康管理师
 */
@property (nonatomic, readwrite, copy) NSNumber *api_expertsType;
/** 
 * 收藏类型1帖子2专家
 */
@property (nonatomic, readwrite, copy) NSString *api_type;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end

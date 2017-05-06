//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersExpertsListResponse.h"

@interface UsersExpertsListRequest : AbstractRequest
/** 
 * 专家类型:1抗衰老专家，2健康管理师
 */
@property (nonatomic, readwrite, copy) NSNumber *api_experType;
/** 
 * 每页记录数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageSize;
/** 
 * 页数|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_pageNum;
@end

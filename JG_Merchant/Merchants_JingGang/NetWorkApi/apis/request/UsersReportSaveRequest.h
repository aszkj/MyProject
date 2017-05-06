//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersReportSaveResponse.h"

@interface UsersReportSaveRequest : AbstractRequest
/** 
 * 举报对象 id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_targetId;
/** 
 * 举报名称
 */
@property (nonatomic, readwrite, copy) NSString *api_tipsType;
/** 
 * 举报类型|0帖子1资讯
 */
@property (nonatomic, readwrite, copy) NSNumber *api_type;
@end

//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SnsInformationAllListResponse.h"

@interface SnsInformationAllListRequest : AbstractRequest
/** 
 * 资讯分类id，查询当前分类下的所有帖子
 */
@property (nonatomic, readwrite, copy) NSNumber *api_classId;
@end

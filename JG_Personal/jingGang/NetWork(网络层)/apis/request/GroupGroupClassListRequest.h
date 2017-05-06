//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "GroupGroupClassListResponse.h"

@interface GroupGroupClassListRequest : AbstractRequest
/** 
 * 父id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_parentId;
/** 
 * 类别1主类目(parentId不用传)2详细类目
 */
@property (nonatomic, readwrite, copy) NSNumber *api_ret;
@end

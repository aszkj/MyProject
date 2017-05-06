//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "SnsFoodCaloriesListResponse.h"

@interface SnsFoodCaloriesListRequest : AbstractRequest
/** 
 * 分类id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_classId;
@end

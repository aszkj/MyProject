//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersCircleQueryResponse.h"

@interface UsersCircleQueryRequest : AbstractRequest
/** 
 * 圈子id|必填
 */
@property (nonatomic, readwrite, copy) NSNumber *api_circleId;
@end

//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersExpertsDetailResponse.h"

@interface UsersExpertsDetailRequest : AbstractRequest
/** 
 * 专家用户id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_uid;
@end

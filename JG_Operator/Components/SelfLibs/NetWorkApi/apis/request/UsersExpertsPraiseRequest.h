//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersExpertsPraiseResponse.h"

@interface UsersExpertsPraiseRequest : AbstractRequest
/** 
 * 专家用户userid
 */
@property (nonatomic, readwrite, copy) NSNumber *api_expertsId;
@end

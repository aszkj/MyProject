//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersExpertsCancleResponse.h"

@interface UsersExpertsCancleRequest : AbstractRequest
/** 
 * 要取消收藏的专家id
 */
@property (nonatomic, readwrite, copy) NSString *api_expertsId;
@end

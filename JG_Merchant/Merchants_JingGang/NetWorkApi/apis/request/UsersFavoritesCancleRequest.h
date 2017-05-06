//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersFavoritesCancleResponse.h"

@interface UsersFavoritesCancleRequest : AbstractRequest
/** 
 * 帖子ID
 */
@property (nonatomic, readwrite, copy) NSString *api_fid;
@end

//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersCanclePraiseResponse.h"

@interface UsersCanclePraiseRequest : AbstractRequest
/** 
 * 帖子id|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_fid;
@end

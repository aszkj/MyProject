//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersNoticesDetailsResponse.h"

@interface UsersNoticesDetailsRequest : AbstractRequest
/** 
 * 公告id|营运商发给商户公告id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_id;
@end

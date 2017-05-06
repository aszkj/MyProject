//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersSysNoticesDetailsResponse.h"

@interface UsersSysNoticesDetailsRequest : AbstractRequest
/** 
 * 公告id|营运商公告和商户平台公告id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_id;
@end

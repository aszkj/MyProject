//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersSignLoginResponse.h"

@interface UsersSignLoginRequest : AbstractRequest
/** 
 * 是否签到|1签到2不签到
 */
@property (nonatomic, readwrite, copy) NSNumber *api_type;
@end

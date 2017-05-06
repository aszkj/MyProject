//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "RegisterNvitationCodeExistsResponse.h"

@interface RegisterNvitationCodeExistsRequest : AbstractRequest
/** 
 * 邀请码
 */
@property (nonatomic, readwrite, copy) NSString *api_code;
@end

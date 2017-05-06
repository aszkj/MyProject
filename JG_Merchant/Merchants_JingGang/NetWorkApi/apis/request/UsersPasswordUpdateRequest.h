//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersPasswordUpdateResponse.h"

@interface UsersPasswordUpdateRequest : AbstractRequest
/** 
 * 旧密码|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_odlPassword;
/** 
 * 新密码|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_newPassword;
@end

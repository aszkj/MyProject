//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "OperatorPasswordUpdateResponse.h"

@interface OperatorPasswordUpdateRequest : AbstractRequest
/** 
 * 旧密码
 */
@property (nonatomic, readwrite, copy) NSString *api_oldPassword;
/** 
 * 新密码
 */
@property (nonatomic, readwrite, copy) NSString *api_newPassword;
@end

//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "RegisterUsersCreateResponse.h"

@interface RegisterUsersCreateRequest : AbstractRequest
/** 
 * 昵称
 */
@property (nonatomic, readwrite, copy) NSString *api_nickname;
/** 
 * 验证码|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_verifyCode;
/** 
 * 手机|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_mobile;
/** 
 * 密码|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_password;
/** 
 * 邀请码
 */
@property (nonatomic, readwrite, copy) NSString *api_invitationCode;
@end

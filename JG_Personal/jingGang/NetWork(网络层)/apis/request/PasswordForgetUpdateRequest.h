//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PasswordForgetUpdateResponse.h"

@interface PasswordForgetUpdateRequest : AbstractRequest
/** 
 * 登录用户名（手机号）|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_mobile;
/** 
 * 新密码|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_password;
/** 
 * 验证码|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_verifyCode;
@end

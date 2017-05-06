//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "BindingRegisterResponse.h"

@interface BindingRegisterRequest : AbstractRequest
/** 
 * 手机号码
 */
@property (nonatomic, readwrite, copy) NSString *api_mobile;
/** 
 * 用户昵称
 */
@property (nonatomic, readwrite, copy) NSString *api_nickName;
/** 
 * 密码
 */
@property (nonatomic, readwrite, copy) NSString *api_password;
/** 
 * 邀请码
 */
@property (nonatomic, readwrite, copy) NSString *api_InvitationCode;
/** 
 * 第三方平台id
 */
@property (nonatomic, readwrite, copy) NSString *api_openId;
/** 
 * 平台unionid
 */
@property (nonatomic, readwrite, copy) NSString *api_unionId;
/** 
 * token
 */
@property (nonatomic, readwrite, copy) NSString *api_token;
/** 
 * 类型|3:QQ 4:微信5:微博
 */
@property (nonatomic, readwrite, copy) NSNumber *api_type;
@end

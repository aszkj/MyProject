//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "BindingMobileResponse.h"

@interface BindingMobileRequest : AbstractRequest
/** 
 * 手机
 */
@property (nonatomic, readwrite, copy) NSString *api_mobile;
/** 
 * 验证码
 */
@property (nonatomic, readwrite, copy) NSString *api_code;
/** 
 * 第三方平台id
 */
@property (nonatomic, readwrite, copy) NSString *api_openId;
/** 
 * 类型|3:QQ 4:微信5:微博
 */
@property (nonatomic, readwrite, copy) NSNumber *api_type;
/** 
 * token
 */
@property (nonatomic, readwrite, copy) NSString *api_token;
/** 
 * 平台unionid
 */
@property (nonatomic, readwrite, copy) NSString *api_unionId;
@end

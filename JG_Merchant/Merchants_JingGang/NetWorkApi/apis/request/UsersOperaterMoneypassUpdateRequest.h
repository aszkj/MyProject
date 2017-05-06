//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersOperaterMoneypassUpdateResponse.h"

@interface UsersOperaterMoneypassUpdateRequest : AbstractRequest
/** 
 * 手机号
 */
@property (nonatomic, readwrite, copy) NSString *api_mobile;
/** 
 * 验证码
 */
@property (nonatomic, readwrite, copy) NSString *api_code;
/** 
 * 新密码
 */
@property (nonatomic, readwrite, copy) NSString *api_password;
@end

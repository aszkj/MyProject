//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "CloudBuyerMoneyPasswordSaveResponse.h"

@interface CloudBuyerMoneyPasswordSaveRequest : AbstractRequest
/** 
 * 新密码
 */
@property (nonatomic, readwrite, copy) NSString *api_new_password;
/** 
 * 验证码
 */
@property (nonatomic, readwrite, copy) NSString *api_mobile_verify_code;
@end

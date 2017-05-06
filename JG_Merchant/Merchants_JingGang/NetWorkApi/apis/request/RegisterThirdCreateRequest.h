//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "RegisterThirdCreateResponse.h"

@interface RegisterThirdCreateRequest : AbstractRequest
/** 
 * 用户名
 */
@property (nonatomic, readwrite, copy) NSString *api_longName;
/** 
 * 用户类型 3:QQ ，4：微信，5:微博
 */
@property (nonatomic, readwrite, copy) NSString *api_loginType;
/** 
 * 用户昵称
 */
@property (nonatomic, readwrite, copy) NSString *api_nickName;
@end

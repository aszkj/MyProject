//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PersonalCancelResponse.h"

@interface PersonalCancelRequest : AbstractRequest
/** 
 * 取消id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_fid;
/** 
 * 类型|4商城5服务6商户
 */
@property (nonatomic, readwrite, copy) NSNumber *api_type;
@end

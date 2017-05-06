//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "OpenIdBindingDeleteResponse.h"

@interface OpenIdBindingDeleteRequest : AbstractRequest
/** 
 * 类型| 3:QQ4:微信5:微博 
 */
@property (nonatomic, readwrite, copy) NSString *api_type;
@end

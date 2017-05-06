//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersCustomerUpdateImgResponse.h"

@interface UsersCustomerUpdateImgRequest : AbstractRequest
/** 
 * 修改后的用户头像地址
 */
@property (nonatomic, readwrite, copy) NSString *api_headImgPath;
@end
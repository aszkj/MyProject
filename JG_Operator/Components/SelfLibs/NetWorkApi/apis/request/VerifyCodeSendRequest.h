//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "VerifyCodeSendResponse.h"

@interface VerifyCodeSendRequest : AbstractRequest
/** 
 * 手机|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_mobile;
@end

//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "OperCodeSendResponse.h"

@interface OperCodeSendRequest : AbstractRequest
/** 
 * 手机|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_mobile;
@end

//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersShareInfoSaveResponse.h"

@interface UsersShareInfoSaveRequest : AbstractRequest
/** 
 * 我的分享内容
 */
@property (nonatomic, readwrite, copy) NSString *api_shareInfo;
@end

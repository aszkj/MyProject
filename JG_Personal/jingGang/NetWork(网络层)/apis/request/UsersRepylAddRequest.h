//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersRepylAddResponse.h"

@interface UsersRepylAddRequest : AbstractRequest
/** 
 * 帖子id|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_invitationId;
/** 
 * 回复id|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_replyId;
/** 
 * 回复内容|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_content;
/** 
 * 发表图片|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_pic;
@end

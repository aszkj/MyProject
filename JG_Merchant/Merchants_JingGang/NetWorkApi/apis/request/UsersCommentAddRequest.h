//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersCommentAddResponse.h"

@interface UsersCommentAddRequest : AbstractRequest
/** 
 * 图片|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_pic;
/** 
 * 帖子Id|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_invitationId;
/** 
 * 回复内容|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_content;
@end

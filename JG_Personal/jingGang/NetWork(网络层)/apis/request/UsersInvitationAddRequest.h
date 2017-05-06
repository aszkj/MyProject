//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersInvitationAddResponse.h"

@interface UsersInvitationAddRequest : AbstractRequest
/** 
 * 圈子id|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_circleId;
/** 
 * 帖子标题|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_title;
/** 
 * 帖子内容|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_context;
/** 
 * 图片
 */
@property (nonatomic, readwrite, copy) NSString *api_images;
@end

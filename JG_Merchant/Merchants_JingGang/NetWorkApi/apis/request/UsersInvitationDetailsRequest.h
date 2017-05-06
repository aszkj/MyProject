//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersInvitationDetailsResponse.h"

@interface UsersInvitationDetailsRequest : AbstractRequest
/** 
 * invnId
 */
@property (nonatomic, readwrite, copy) NSNumber *api_invnId;
/** 
 * 帖子访问来源(app原生与其他分享的区别标志,1:jg app)
 */
@property (nonatomic, readwrite, copy) NSNumber *api_jgyes_app;
/** 
 * 分享人邀请码信息
 */
@property (nonatomic, readwrite, copy) NSString *api_invitationCode;
@end

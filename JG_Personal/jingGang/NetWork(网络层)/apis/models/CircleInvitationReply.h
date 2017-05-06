//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface CircleInvitationReply : MTLModel <MTLJSONSerializing>

	//用户Id
	@property (nonatomic, readonly, copy) NSNumber *uid;
	//评论时间
	@property (nonatomic, readonly, copy) NSDate *addTime;
	//楼层号
	@property (nonatomic, readonly, copy) NSNumber *levelCount;
	//用户Id
	@property (nonatomic, readonly, copy) NSNumber *deleteStatus;
	//对应的帖子Id
	@property (nonatomic, readonly, copy) NSNumber *invitationId;
	//上级回复信息id
	@property (nonatomic, readonly, copy) NSNumber *parentId;
	//回复数量
	@property (nonatomic, readonly, copy) NSNumber *replyCount;
	//回复人Id
	@property (nonatomic, readonly, copy) NSNumber *userId;
	//回复人Id
	@property (nonatomic, readonly, copy) NSString *userName;
	//回复人头像路径
	@property (nonatomic, readonly, copy) NSString *userPhoto;
	//回复信息
	@property (nonatomic, readonly, copy) NSString *content;
	
@end

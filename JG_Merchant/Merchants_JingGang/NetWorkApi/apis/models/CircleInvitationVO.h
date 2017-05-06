//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface CircleInvitationVO : MTLModel <MTLJSONSerializing>

	//帖子Id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//帖子标题
	@property (nonatomic, readonly, copy) NSString *title;
	//帖子点赞数量
	@property (nonatomic, readonly, copy) NSNumber *praiseCount;
	//帖子总回复数量
	@property (nonatomic, readonly, copy) NSNumber *replyCount;
	//最后回复人姓名
	@property (nonatomic, readonly, copy) NSString *replyName;
	//头像
	@property (nonatomic, readonly, copy) NSString *headImgPath;
	//用户Id
	@property (nonatomic, readonly, copy) NSNumber *uid;
	
@end

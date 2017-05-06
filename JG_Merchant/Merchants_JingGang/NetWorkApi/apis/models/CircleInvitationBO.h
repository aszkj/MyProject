//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface CircleInvitationBO : MTLModel <MTLJSONSerializing>

	//帖子id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//添加时间
	@property (nonatomic, readonly, copy) NSDate *addTime;
	//所属圈子
	@property (nonatomic, readonly, copy) NSNumber *circleId;
	//圈子名称
	@property (nonatomic, readonly, copy) NSString *circleName;
	//加精
	@property (nonatomic, readonly, copy) NSNumber *invitaionPerfect;
	//点赞数量
	@property (nonatomic, readonly, copy) NSNumber *praiseCount;
	//回复数量
	@property (nonatomic, readonly, copy) NSNumber *replyCount;
	//帖子标题
	@property (nonatomic, readonly, copy) NSString *title;
	//类型
	@property (nonatomic, readonly, copy) NSString *type;
	//发帖人姓名
	@property (nonatomic, readonly, copy) NSString *userName;
	//帖子类型
	@property (nonatomic, readonly, copy) NSNumber *circleType;
	//帖子详情
	@property (nonatomic, readonly, copy) NSString *content;
	//帖子附加信息
	@property (nonatomic, readonly, copy) NSString *itemInfo;
	//帖子图片信息
	@property (nonatomic, readonly, copy) NSString *photoInfo;
	//帖子点赞信息
	@property (nonatomic, readonly, copy) NSString *praiseInfo;
	//帖子回复人姓名
	@property (nonatomic, readonly, copy) NSString *replyName;
	//用户头像
	@property (nonatomic, readonly, copy) NSString *headImgPath;
	
@end

//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface CircleInvitation : MTLModel <MTLJSONSerializing>

	//帖子id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//帖子发布时间
	@property (nonatomic, readonly, copy) NSString *publicTime;
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
	//帖子类型1用户2官方
	@property (nonatomic, readonly, copy) NSNumber *circleType;
	//帖子详情
	@property (nonatomic, readonly, copy) NSString *content;
	//帖子附加信息
	@property (nonatomic, readonly, copy) NSString *itemInfo;
	//帖子图片信息
	@property (nonatomic, readonly, copy) NSString *photoInfo;
	//帖子点赞信息
	@property (nonatomic, readonly, copy) NSString *praiseInfo;
	//最后回复人姓名
	@property (nonatomic, readonly, copy) NSString *replyName;
	//头像
	@property (nonatomic, readonly, copy) NSString *headImgPath;
	//帖子最后回复时间
	@property (nonatomic, readonly, copy) NSString *replyTime;
	//用户点赞过此帖
	@property (nonatomic, readonly, copy) NSNumber *isPraise;
	//用户收藏过此帖
	@property (nonatomic, readonly, copy) NSNumber *isFavo;
	//帖子收藏信息
	@property (nonatomic, readonly, copy) NSString *favoritesInfo;
	//压缩图片
	@property (nonatomic, readonly, copy) NSString *thumbnail;
	
@end

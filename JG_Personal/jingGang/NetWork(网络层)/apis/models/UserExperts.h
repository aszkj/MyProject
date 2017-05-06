//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface UserExperts : MTLModel <MTLJSONSerializing>

	//用户Id
	@property (nonatomic, readonly, copy) NSNumber *uid;
	//用户名称
	@property (nonatomic, readonly, copy) NSString *name;
	//职称
	@property (nonatomic, readonly, copy) NSString *title;
	//性别
	@property (nonatomic, readonly, copy) NSNumber *sex;
	//介绍
	@property (nonatomic, readonly, copy) NSString *description;
	//头像路径
	@property (nonatomic, readonly, copy) NSString *headImgPath;
	//邮箱
	@property (nonatomic, readonly, copy) NSString *email;
	//手机
	@property (nonatomic, readonly, copy) NSString *mobile;
	//用户状态
	@property (nonatomic, readonly, copy) NSString *status;
	//用户Id
	@property (nonatomic, readonly, copy) NSNumber *expertType;
	//点赞用户信息，记录用户id，使用逗号间隔1,2,3,4,5,6,7,
	@property (nonatomic, readonly, copy) NSString *praiseInfo;
	//点赞数量
	@property (nonatomic, readonly, copy) NSNumber *praiseCount;
	//收藏数量
	@property (nonatomic, readonly, copy) NSNumber *favorCount;
	//收藏用户信息
	@property (nonatomic, readonly, copy) NSString *favorInfo;
	//是否收藏
	@property (nonatomic, readonly, copy) NSNumber *isFavor;
	//是否点赞
	@property (nonatomic, readonly, copy) NSNumber *isPraise;
	//简介|已过滤标签
	@property (nonatomic, readonly, copy) NSString *desc;
	
@end

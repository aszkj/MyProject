//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Circle : MTLModel <MTLJSONSerializing>

	//圈子Id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//时间
	@property (nonatomic, readonly, copy) NSDate *addTime;
	//总关注人数
	@property (nonatomic, readonly, copy) NSNumber *attentionCount;
	//圈子所属分类id
	@property (nonatomic, readonly, copy) NSNumber *classId;
	//圈子所属分类名称
	@property (nonatomic, readonly, copy) NSString *className;
	//总帖子数量
	@property (nonatomic, readonly, copy) NSNumber *invitationCount;
	//1为推荐
	@property (nonatomic, readonly, copy) NSNumber *recommend;
	//圈子标题
	@property (nonatomic, readonly, copy) NSString *title;
	//圈子创建人姓名
	@property (nonatomic, readonly, copy) NSString *userName;
	//圈子说明 
	@property (nonatomic, readonly, copy) NSString *content;
	//圈子图标信息 
	@property (nonatomic, readonly, copy) NSString *photoInfo;
	
@end

//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Relation : MTLModel <MTLJSONSerializing>

	//用户id
	@property (nonatomic, readonly, copy) NSNumber *uid;
	//邀请人用户id
	@property (nonatomic, readonly, copy) NSNumber *refereeUserId;
	//姓名
	@property (nonatomic, readonly, copy) NSString *name;
	//昵称
	@property (nonatomic, readonly, copy) NSString *nickname;
	//头像路径 
	@property (nonatomic, readonly, copy) NSString *headImgPath;
	//手机
	@property (nonatomic, readonly, copy) NSString *mobile;
	//注册时间
	@property (nonatomic, readonly, copy) NSDate *registerTime;
	//注册时间
	@property (nonatomic, readonly, copy) NSString *time;
	
@end

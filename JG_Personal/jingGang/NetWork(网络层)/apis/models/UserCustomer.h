//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface UserCustomer : MTLModel <MTLJSONSerializing>

	//用户Id
	@property (nonatomic, readonly, copy) NSNumber *uid;
	//用户姓名
	@property (nonatomic, readonly, copy) NSString *name;
	//用户昵称
	@property (nonatomic, readonly, copy) NSString *nickName;
	//药物过敏
	@property (nonatomic, readonly, copy) NSString *allergicHistory;
	//性别
	@property (nonatomic, readonly, copy) NSNumber *sex;
	//身高
	@property (nonatomic, readonly, copy) NSNumber *height;
	//体重
	@property (nonatomic, readonly, copy) NSNumber *weight;
	//生日
	@property (nonatomic, readonly, copy) NSString *birthdate;
	//邮箱
	@property (nonatomic, readonly, copy) NSString *email;
	//手机
	@property (nonatomic, readonly, copy) NSString *mobile;
	//用户状态
	@property (nonatomic, readonly, copy) NSString *status;
	//家族药物过敏史
	@property (nonatomic, readonly, copy) NSString *transHistory;
	//家族遗传病史
	@property (nonatomic, readonly, copy) NSString *transGenetic;
	//用户头像
	@property (nonatomic, readonly, copy) NSString *headImgPath;
	//血型
	@property (nonatomic, readonly, copy) NSString *blood;
	//邀请码
	@property (nonatomic, readonly, copy) NSString *invitationCode;
	//推荐人
	@property (nonatomic, readonly, copy) NSString *referee;
	//隶属商户
	@property (nonatomic, readonly, copy) NSString *merchant;
	//是否已设置云币密码
	@property (nonatomic, readonly, copy) NSNumber *isCloudPassword;
	
@end

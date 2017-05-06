//
//  UserInfoViewModel.h
//  jingGang
//
//  Created by ray on 15/11/24.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "XKO_ViewModel.h"

@interface MyUserCustomer : NSObject

//用户Id
@property (nonatomic, copy) NSNumber *uid;
//用户姓名
@property (nonatomic, copy) NSString *name;
//用户昵称
@property (nonatomic, copy) NSString *nickName;
//药物过敏
@property (nonatomic, copy) NSString *allergicHistory;
//性别
@property (nonatomic, copy) NSNumber *sex;
//身高
@property (nonatomic, copy) NSNumber *height;
//体重
@property (nonatomic, copy) NSNumber *weight;
//生日
@property (nonatomic, copy) NSString *birthdate;
//邮箱
@property (nonatomic, copy) NSString *email;
//手机
@property (nonatomic, copy) NSString *mobile;
//用户状态
@property (nonatomic, copy) NSString *status;
//家族药物过敏史
@property (nonatomic, copy) NSString *transHistory;
//家族遗传病史
@property (nonatomic, copy) NSString *transGenetic;
//用户头像
@property (nonatomic, copy) NSString *headImgPath;
//血型
@property (nonatomic, copy) NSString *blood;
//邀请码
@property (nonatomic, copy) NSString *invitationCode;
//推荐人
@property (nonatomic, copy) NSString *referee;
//隶属商户
@property (nonatomic, copy) NSString *merchant;

@property (nonatomic) NSString *sexStr;
@property (nonatomic) NSString *heightStr;
@property (nonatomic) NSString *weightStr;
@end

@interface UserInfoViewModel : XKO_ViewModel

@property (nonatomic) MyUserCustomer *userInfo;
@property (nonatomic) RACCommand *getUserInfoCommand;
@property (nonatomic) RACCommand *updateUserInfoCommand;
@property (nonatomic) RACCommand *changeActionCommand;

- (RACSignal *)checkSignal;

@end

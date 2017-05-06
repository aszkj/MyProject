//
//  DLUserInfoModel.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/6/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface DLUserInfoModel : BaseModel

@property (nonatomic,copy)NSString *userId;
@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSNumber *memberType;
@property (nonatomic,strong)NSString *nickName;
@property (nonatomic,strong)NSNumber *userSex;
@property (nonatomic,strong)NSString *birthday;
@property (nonatomic,strong)NSString *userImageUrl;
@property (nonatomic,strong)NSString *vipExpireDate;
@property (nonatomic,strong)NSNumber *binding;
@property (nonatomic,strong)NSDictionary  *bindQQInfo;
@property (nonatomic,strong)NSDictionary  *bindWXInfo;
@property (nonatomic,strong)NSString *wechatName;
@property (nonatomic,strong)NSString *qqName;

@end

//
//  DLUserInfoModel.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/6/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLUserInfoModel.h"

@implementation DLUserInfoModel
-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.userId = [dic[@"userId"] stringValue];
        self.userName = dic[@"userName"];
        self.memberType = dic[@"memberType"];
        self.nickName = dic[@"nickName"];
        self.userSex = dic[@"userSex"];
        self.birthday = dic[@"birthday"];
        self.userImageUrl = dic[@"userImageUrl"];
        self.vipExpireDate = dic[@"vipExpireDate"];
        self.binding = dic[@"binding"];
        self.bindQQInfo = dic[@"bindQQInfo"];
        self.bindWXInfo = dic[@"bindWXInfo"];
        if (!isEmpty(dic[@"bindQQInfo"])) {
            self.qqName = dic[@"bindQQInfo"][@"nickName"];
        }
        if (!isEmpty(dic[@"bindWXInfo"])) {
            self.wechatName = dic[@"bindWXInfo"][@"nickName"];
        }
        
        
    }
    return self;
}
@end

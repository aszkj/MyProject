//
//  XKO_MembersManagerResponseInfo.h
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_BaseHttpResponseModel.h"

@interface XKO_MembersManagerResponseInfo : XKO_BaseHttpResponseModel

//id
@property (nonatomic, readwrite, copy) NSNumber *apiId;
//会员来源：0邀请码1首次消费
@property (nonatomic, readwrite, copy) NSNumber *relationType;
//注册时间
@property (nonatomic, copy) NSString *createTime;
//会员名称
@property (nonatomic, readwrite, copy) NSString *groupStoreName;
//昵称
@property (nonatomic, readwrite, copy) NSString *nickname;
//会员类型
@property (nonatomic, readwrite, copy) NSString *relationName;
//商户名称
@property (nonatomic, readwrite, copy) NSString *storeName;

@end

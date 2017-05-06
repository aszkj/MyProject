//
//  OrderDetailModel.m
//  jingGang
//
//  Created by 鹏 朱 on 15/9/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation OrderDetailModel
@end

@implementation JGOrderDetailModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.groudId = TNSString(dic[@"groupId"]);
        self.status = TNSString(dic[@"status"]);
        self.groupName = TNSString(dic[@"groupName"]);
        self.groupAccPath = TNSString(dic[@"groupAccPath"]);
        self.groupSn = TNSString(dic[@"groupSn"]);
        self.totalPrice = TNSString(dic[@"totalPrice"]);
    }
    return self;
}

@end

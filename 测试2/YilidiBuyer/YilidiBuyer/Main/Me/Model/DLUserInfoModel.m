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
        self.userId = dic[@"userId"];
        self.userName = dic[@"userName"];
        self.memberType = dic[@"memberType"];
        JLog(@"userId:%@",dic[@"userId"]);
    }
    return self;
}
@end

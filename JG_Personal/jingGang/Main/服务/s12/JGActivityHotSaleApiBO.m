//
//  JGActivityHotSaleApiBO.m
//  jingGang
//
//  Created by dengxf on 15/12/10.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGActivityHotSaleApiBO.h"

@implementation JGActivityHotSaleApiBO

- (instancetype)initWithResponseDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        dic = dic[@"activityHotSaleApiBO"];
        self.aid = [dic[@"id"] longLongValue];
        self.firstImage = dic[@"firstImage"];
        self.footImage = dic[@"footImage"];
        self.headImage = dic[@"headImage"];
        self.hotName = dic[@"hotName"];
        self.endTime = TNSString(dic[@"endTime"]);
        self.startTime = TNSString(dic[@"startTime"]);
    }
    return self;
}

@end

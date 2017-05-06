//
//  ActivityHotSaleApiBO+Extension.m
//  jingGang
//
//  Created by dengxf on 15/12/23.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "ActivityHotSaleApiBO+Extension.h"

@implementation ActivityHotSaleApiBO (Extension)

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.apiId = [NSNumber numberWithInteger:[TNSString(dic[@"id"]) integerValue]];
        self.firstImage = dic[@"firstImage"];
        self.headImage = dic[@"headImage"];
        self.hotName = dic[@"hotName"];
        self.endTime = @"";
        self.startTime = @"";
        
    }
    return self;
}

@end

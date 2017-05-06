//
//  UserIntegral+InitExtend.m
//  jingGang
//
//  Created by 张康健 on 15/12/25.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "UserIntegral+InitExtend.h"

@implementation UserIntegral (InitExtend)

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.uid = [NSNumber numberWithInteger:[dic[@"uid"] integerValue]] ;
        self.freezeBlance = [NSNumber numberWithInteger:[dic[@"freezeBlance"] integerValue]];
        self.integral = [NSNumber numberWithInteger:[dic[@"integral"] integerValue]];
    }
    return self;
}
@end

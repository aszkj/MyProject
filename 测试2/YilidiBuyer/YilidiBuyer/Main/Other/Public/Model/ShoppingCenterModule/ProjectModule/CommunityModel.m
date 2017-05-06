//
//  CommunityModel.m
//  YilidiBuyer
//
//  Created by yld on 16/6/11.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "CommunityModel.h"

@implementation CommunityModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.communityId = [dic[@"communityId"] stringValue];
        self.communityName = dic[@"communityName"];
        self.communityAdressDetail = dic[@"addressDetail"];
        self.provinceCode = dic[@"provinceCode"];
        self.cityCode = dic[@"cityCode"];
        self.countyCode = dic[@"countyCode"];
        self.countyName = dic[@"countyName"];
        self.cityName = dic[@"cityName"];
        self.provinceName = dic[@"provinceName"];
        self.townName = dic[@"countyName"];
        self.communityStore = [[StoreModel alloc] initWithDefaultDataDic:dic[@"storeInfo"]];
    }
    return self;
}

@end

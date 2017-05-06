//
//  CommunityModel.m
//  YilidiBuyer
//
//  Created by yld on 16/6/11.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "CommunityModel.h"
#import "NSMutableDictionary+safeSet.h"

@implementation CommunityModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.modelOriginalDic = dic;
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

- (NSDictionary *)modelDic {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    DicSaveSetObject(dic, @"communityId", @(self.communityId.longLongValue));
    DicSaveSetObject(dic, @"communityName", self.communityName);
    DicSaveSetObject(dic, @"addressDetail", self.communityAdressDetail);
    DicSaveSetObject(dic, @"provinceCode", self.provinceCode);
    DicSaveSetObject(dic, @"cityCode", self.cityCode);
    DicSaveSetObject(dic, @"countyCode", self.countyCode);
    DicSaveSetObject(dic, @"countyName", self.townName);
    DicSaveSetObject(dic, @"cityName", self.cityName);
    DicSaveSetObject(dic, @"provinceName", self.provinceName);
    DicSaveSetObject(dic, @"storeInfo", [self.communityStore modelDic]);
    return self.modelOriginalDic;

}


@end

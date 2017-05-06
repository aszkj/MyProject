//
//  AdressModel.m
//  YilidiBuyer
//
//  Created by yld on 16/5/26.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AdressModel.h"
#import "CommunityModel.h"
#import "GlobleConst.h"
@implementation AdressModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic
{
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.consigneAdressId = [dic[@"addressId"] stringValue];
        self.consigneePersonalDetailAdress = dic[@"addressDetail"];
        self.communityModel = [[CommunityModel alloc] initWithDefaultDataDic:dic[@"community"]];
        self.consigneePersonName = dic[@"consigneeName"];
        self.consigneePersonPhoneNumber = dic[@"phoneNo"];
        self.cityName = dic[@"cityName"];
        self.provinceName = dic[@"provinceName"];
        self.townName = dic[@"countyName"];
        //设置是否在配送范围
        [self _setInTheDeliverange];
        [self _setDisplayAdress];
    }
    return self;
}

- (void)_setDisplayAdress {
    self.displayAdress = jFormat(@"%@%@",self.communityModel.communityName,self.consigneePersonalDetailAdress);
}

- (void)_setInTheDeliverange {
    if (isEmpty(self.communityModel.communityStore)) {
        self.isInDeliveryRange = NO;
        return;
    }
     self.isInDeliveryRange = [self.communityModel.communityStore.storeId isEqualToString:kCommunityStoreId] ? YES : NO;
}

@end

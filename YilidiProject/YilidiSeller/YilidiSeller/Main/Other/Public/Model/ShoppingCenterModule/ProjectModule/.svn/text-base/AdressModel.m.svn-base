//
//  AdressModel.m
//  YilidiSeller
//
//  Created by yld on 16/5/26.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AdressModel.h"

@implementation AdressModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic
{
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.consigneAdressId = dic[@"shippingAddressId"];
        self.consigneePersonName = dic[@"shippingName"];
        self.consigneenPersonGender = dic[@"gender"];
        self.consigneePersonPhoneNumber = dic[@"mobile"];
        self.cityCode = dic[@"cityCode"];
        self.consigneePersonAdress = dic[@"shippingAddress"];
        self.consigneeHouseNo = dic[@"houseNo"];
        self.townShipCode = dic[@"townshipCode"];
        self.isDefaultConsigneeAdress = dic[@"isDefault"];
    }
    return self;
}


@end

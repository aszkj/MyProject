//
//  DLAdressListModel.m
//  YilidiBuyer
//
//  Created by yld on 16/4/26.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLAdressListModel.h"

@implementation DLAdressListModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic
{
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.consigneAdressId = dic[@"shippingAddressId"];
        self.consigneePersonName = dic[@"shippingName"];
        self.consigneenPersonGender = dic[@"gender"];
        self.consigneePersonPhoneNumber = dic[@"mobile"];
        self.cityCode = dic[@"cityCode"];
        self.cityName = dic[@"cityName"];
        self.consigneePersonAdress = dic[@"shippingAddress"];
        self.consigneeHouseNo = dic[@"houseNo"];
        self.townShipCode = dic[@"townshipCode"];
        self.isDefaultConsigneeAdress = dic[@"isDefault"];
    }
    return self;
}


@end

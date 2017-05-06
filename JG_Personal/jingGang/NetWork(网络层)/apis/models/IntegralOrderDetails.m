//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IntegralOrderDetails.h"

@implementation IntegralOrderDetails
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"igoOrderSn":@"igoOrderSn",
			@"orderStatus":@"orderStatus",
			@"status":@"status",
			@"igoTotalIntegral":@"igoTotalIntegral",
			@"igoTransFee":@"igoTransFee",
			@"addTime":@"addTime",
			@"igoPayment":@"igoPayment",
			@"payment":@"payment",
			@"igoPayTime":@"igoPayTime",
			@"igoMsg":@"igoMsg",
			@"receiverName":@"receiverName",
			@"receiverArea":@"receiverArea",
			@"receiverZip":@"receiverZip",
			@"receiverAreaInfo":@"receiverAreaInfo",
			@"receiverTelephone":@"receiverTelephone",
			@"receiverMobile":@"receiverMobile",
			@"igoExpressInfo":@"igoExpressInfo",
			@"expressInfo":@"expressInfo",
			@"expressCompanyId":@"expressCompanyId",
			@"igoShipCode":@"igoShipCode",
			@"igoShipTime":@"igoShipTime",
			@"igoShipContent":@"igoShipContent",
			@"igoList":@"igoList"
             };
}

+(NSValueTransformer *) igoListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[IGo class]];
}
@end

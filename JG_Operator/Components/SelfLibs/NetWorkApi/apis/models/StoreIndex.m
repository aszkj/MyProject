//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "StoreIndex.h"

@implementation StoreIndex
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"invitationCode":@"invitationCode",
			@"totalPayAmount":@"totalPayAmount",
			@"couponPayAmount":@"couponPayAmount",
			@"chargePayAmount":@"chargePayAmount",
			@"rebateAmount":@"rebateAmount",
			@"profitAmount":@"profitAmount",
			@"storeBannerPath":@"storeBannerPath",
			@"storeLogoPath":@"storeLogoPath",
			@"coverPath":@"coverPath",
			@"storeName":@"storeName",
			@"totalPhoto":@"totalPhoto",
			@"storeTelephone":@"storeTelephone",
			@"area":@"area",
			@"storeAddress":@"storeAddress"
             };
}

@end

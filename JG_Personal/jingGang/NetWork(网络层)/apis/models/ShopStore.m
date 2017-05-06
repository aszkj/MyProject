//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopStore.h"

@implementation ShopStore
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"storeName":@"storeName",
			@"apiId":@"id",
			@"storeCredit":@"storeCredit",
			@"storeInfo":@"storeInfo",
			@"storeLogoPath":@"storeLogoPath",
			@"storeDescription":@"storeDescription",
			@"storeService":@"storeService",
			@"storeShip":@"storeShip"
             };
}

@end

//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PStoreInfo.h"

@implementation PStoreInfo
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"storeName":@"storeName",
			@"storeAddress":@"storeAddress",
			@"storeCredit":@"storeCredit",
			@"storeEvaluationAverage":@"storeEvaluationAverage",
			@"storeInfo":@"storeInfo",
			@"photoPath":@"photoPath",
			@"photoSize":@"photoSize",
			@"distance":@"distance",
			@"storeLon":@"storeLon",
			@"storeLat":@"storeLat",
			@"storeTelephone":@"storeTelephone",
			@"licenseCDesc":@"licenseCDesc"
             };
}

@end

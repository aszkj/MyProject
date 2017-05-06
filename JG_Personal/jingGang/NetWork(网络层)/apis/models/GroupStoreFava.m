//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GroupStoreFava.h"

@implementation GroupStoreFava
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"storeCredit":@"storeCredit",
			@"storeName":@"storeName",
			@"distance":@"distance",
			@"createUserId":@"createUserId",
			@"storeLat":@"storeLat",
			@"storeLon":@"storeLon",
			@"evaluationAverage":@"evaluationAverage",
			@"storeInfoPath":@"storeInfoPath"
             };
}

@end

//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "StoreSearch.h"

@implementation StoreSearch
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"storeName":@"storeName",
			@"storeInfoPath":@"storeInfoPath",
			@"storeAddress":@"storeAddress",
			@"sales":@"sales",
			@"distance":@"distance",
			@"storeEvaluationCount":@"storeEvaluationCount",
			@"storeEvaluationAverage":@"storeEvaluationAverage"
             };
}

@end

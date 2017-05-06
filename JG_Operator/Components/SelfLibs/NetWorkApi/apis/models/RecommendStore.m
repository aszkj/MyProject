//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "RecommendStore.h"

@implementation RecommendStore
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"storeName":@"storeName",
			@"cityId":@"cityId",
			@"areaId":@"areaId",
			@"areaInfo":@"areaInfo",
			@"storeInfoPath":@"storeInfoPath",
			@"storeEvaluationCount":@"storeEvaluationCount",
			@"storeEvaluationAverage":@"storeEvaluationAverage",
			@"storeAddress":@"storeAddress",
			@"evaluationAverage":@"evaluationAverage",
			@"storeMainInfoPath":@"storeMainInfoPath",
			@"sales":@"sales",
			@"distance":@"distance"
             };
}

@end

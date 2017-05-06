//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "RecommStoreInfo.h"

@implementation RecommStoreInfo
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"storeName":@"storeName",
			@"storeAddress":@"storeAddress",
			@"area":@"area",
			@"star":@"star",
			@"distance":@"distance",
			@"storeInfoPath":@"storeInfoPath",
			@"evaluationAverage":@"evaluationAverage"
             };
}

@end

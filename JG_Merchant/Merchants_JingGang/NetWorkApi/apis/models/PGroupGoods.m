//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PGroupGoods.h"

@implementation PGroupGoods
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"ggName":@"ggName",
			@"costPrice":@"costPrice",
			@"ggRebate":@"ggRebate",
			@"groupPrice":@"groupPrice",
			@"ggStatus":@"ggStatus",
			@"groupAccPath":@"groupAccPath",
			@"groupDesc":@"groupDesc",
			@"storeName":@"storeName",
			@"storeAddress":@"storeAddress",
			@"distance":@"distance",
			@"storeId":@"storeId",
			@"evaluationAverage":@"evaluationAverage",
			@"selledCount":@"selledCount",
			@"gradeId":@"gradeId"
             };
}

@end

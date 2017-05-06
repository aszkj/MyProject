//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "FavaGroupGoods.h"

@implementation FavaGroupGoods
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"storeName":@"storeName",
			@"ggName":@"ggName",
			@"groupPrice":@"groupPrice",
			@"groupAccPath":@"groupAccPath"
             };
}

@end

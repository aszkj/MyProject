//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "FoodClass.h"

@implementation FoodClass
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"name":@"name",
			@"calories":@"calories"
             };
}

@end

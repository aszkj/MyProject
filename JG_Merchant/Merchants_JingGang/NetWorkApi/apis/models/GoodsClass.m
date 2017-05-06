//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GoodsClass.h"

@implementation GoodsClass
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"className":@"className",
			@"appIcon":@"appIcon",
			@"mobileIcon":@"mobileIcon"
             };
}

@end

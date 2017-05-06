//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopAccessory.h"

@implementation ShopAccessory
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"info":@"info",
			@"name":@"name",
			@"path":@"path"
             };
}

@end

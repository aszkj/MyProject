//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GoodsProperty.h"

@implementation GoodsProperty
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"val":@"val",
			@"name":@"name",
			@"apiId":@"id"
             };
}

@end

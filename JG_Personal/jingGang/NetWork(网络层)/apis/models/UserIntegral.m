//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UserIntegral.h"

@implementation UserIntegral
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"uid":@"uid",
			@"freezeBlance":@"freezeBlance",
			@"integral":@"integral",
			@"gold":@"gold"
             };
}

@end

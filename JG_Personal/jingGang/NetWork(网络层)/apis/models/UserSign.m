//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UserSign.h"

@implementation UserSign
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"isSign":@"isSign",
			@"integral":@"integral",
			@"day":@"day"
             };
}

@end

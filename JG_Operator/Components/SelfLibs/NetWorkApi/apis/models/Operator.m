//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Operator.h"

@implementation Operator
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"operatorName":@"operatorName"
             };
}

@end
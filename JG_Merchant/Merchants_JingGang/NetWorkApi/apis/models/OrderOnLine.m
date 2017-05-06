//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OrderOnLine.h"

@implementation OrderOnLine
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"orderId":@"orderId",
			@"nickName":@"nickName",
			@"addTime":@"addTime"
             };
}

@end

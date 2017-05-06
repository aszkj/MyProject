//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UPrepositLog.h"

@implementation UPrepositLog
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"addTime":@"addTime",
			@"cashAmount":@"cashAmount",
			@"cashStatus":@"cashStatus"
             };
}

@end

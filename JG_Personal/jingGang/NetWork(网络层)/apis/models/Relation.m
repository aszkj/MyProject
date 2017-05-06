//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Relation.h"

@implementation Relation
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"uid":@"uid",
			@"refereeUserId":@"refereeUserId",
			@"name":@"name",
			@"nickname":@"nickname",
			@"headImgPath":@"headImgPath",
			@"mobile":@"mobile",
			@"registerTime":@"registerTime",
			@"time":@"time"
             };
}

@end

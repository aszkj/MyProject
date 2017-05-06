//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IGo.h"

@implementation IGo
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"images":@"images",
			@"igoName":@"igoName",
			@"igoInteral":@"igoInteral",
			@"count":@"count",
			@"apiId":@"id"
             };
}

@end

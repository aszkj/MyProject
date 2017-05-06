//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UserConsultingListBO.h"

@implementation UserConsultingListBO
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"userExperts":@"userExperts",
			@"apiNewRepayTime":@"newRepayTime",
			@"title":@"title",
			@"apiId":@"id"
             };
}

@end

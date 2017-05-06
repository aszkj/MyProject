//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "WeiXinPaymet.h"

@implementation WeiXinPaymet
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"appid":@"appid",
			@"noncestr":@"noncestr",
			@"package1":@"package1",
			@"partnerid":@"partnerid",
			@"prepayid":@"prepayid",
			@"timestamp":@"timestamp",
			@"sign":@"sign"
             };
}

@end

//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "StoreBank.h"

@implementation StoreBank
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"bankAccountName":@"bankAccountName",
			@"bankCAccount":@"bankCAccount",
			@"bankName":@"bankName"
             };
}

@end

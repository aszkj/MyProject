//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OperatorBank.h"

@implementation OperatorBank
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"bankName":@"bankName",
			@"subBankName":@"subBankName",
			@"bankNo":@"bankNo",
			@"userName":@"userName"
             };
}

@end

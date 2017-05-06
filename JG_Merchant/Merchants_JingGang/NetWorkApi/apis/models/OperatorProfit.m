//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OperatorProfit.h"

@implementation OperatorProfit
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"profitAmount":@"profitAmount",
			@"recommedAmount":@"recommedAmount",
			@"storeAmount":@"storeAmount",
			@"userAmount":@"userAmount",
			@"type":@"type",
			@"rcRebate":@"rcRebate",
			@"rsRebate":@"rsRebate"
             };
}

@end

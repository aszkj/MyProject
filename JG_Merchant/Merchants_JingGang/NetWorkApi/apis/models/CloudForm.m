//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "CloudForm.h"

@implementation CloudForm
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"addTime":@"addTime",
			@"deleteStatus":@"deleteStatus",
			@"cashAccount":@"cashAccount",
			@"cashAmount":@"cashAmount",
			@"cashBank":@"cashBank",
			@"cashPayStatus":@"cashPayStatus",
			@"cashPayment":@"cashPayment",
			@"cashSn":@"cashSn",
			@"cashStatus":@"cashStatus",
			@"cashUserName":@"cashUserName",
			@"cashAdminId":@"cashAdminId",
			@"cashUserId":@"cashUserId",
			@"cashAdminInfo":@"cashAdminInfo",
			@"cashInfo":@"cashInfo",
			@"cashSubbranch":@"cashSubbranch",
			@"cashRelation":@"cashRelation"
             };
}

@end

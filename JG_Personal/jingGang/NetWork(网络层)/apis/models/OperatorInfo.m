//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OperatorInfo.h"

@implementation OperatorInfo
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"userName":@"userName",
			@"sex":@"sex",
			@"phone":@"phone",
			@"address":@"address",
			@"idCard":@"idCard",
			@"nation":@"nation",
			@"level":@"level",
			@"levelName":@"levelName",
			@"area":@"area",
			@"operatorAreaId":@"operatorAreaId",
			@"operatorName":@"operatorName",
			@"refereeName":@"refereeName",
			@"bankName":@"bankName",
			@"subBankName":@"subBankName",
			@"bankNo":@"bankNo",
			@"organizationNo":@"organizationNo",
			@"organizationPath":@"organizationPath",
			@"registrationPath":@"registrationPath",
			@"taxPath":@"taxPath",
			@"registrationNo":@"registrationNo",
			@"taxNo":@"taxNo",
			@"operatorCode":@"operatorCode",
			@"invitationCode":@"invitationCode"
             };
}

@end

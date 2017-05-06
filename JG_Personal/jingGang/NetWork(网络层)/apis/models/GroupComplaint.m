//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GroupComplaint.h"

@implementation GroupComplaint
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"orderStatus":@"orderStatus",
			@"orderId":@"orderId",
			@"payTime":@"payTime",
			@"goodsAmount":@"goodsAmount",
			@"groupInfo":@"groupInfo",
			@"storeTelephone":@"storeTelephone",
			@"areaId":@"areaId",
			@"areaText":@"areaText",
			@"storeAddress":@"storeAddress",
			@"name":@"name",
			@"status":@"status",
			@"mobile":@"mobile",
			@"addTime":@"addTime",
			@"apiId":@"id",
			@"problemDesc":@"problemDesc",
			@"fromUserContent":@"fromUserContent",
			@"storeName":@"storeName",
			@"fromAcc1":@"fromAcc1",
			@"fromAcc2":@"fromAcc2",
			@"fromAcc3":@"fromAcc3",
			@"groupName":@"groupName",
			@"groupPhoto":@"groupPhoto",
			@"price":@"price",
			@"fromAccArry":@"fromAccArry",
			@"nickname":@"nickname",
			@"handleContent":@"handleContent"
             };
}

@end

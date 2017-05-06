//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "StoreAppInfo.h"

@implementation StoreAppInfo
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"storeName":@"storeName",
			@"category":@"category",
			@"industry":@"industry",
			@"licenseBusinessScope":@"licenseBusinessScope",
			@"licenseCDesc":@"licenseCDesc",
			@"groupDetailInfo":@"groupDetailInfo",
			@"detailsInfos":@"detailsInfos",
			@"storeAddress":@"storeAddress",
			@"storeTelephone":@"storeTelephone",
			@"licenseCMobile":@"licenseCMobile",
			@"licenseLegalIdCard":@"licenseLegalIdCard",
			@"commissionRebate":@"commissionRebate",
			@"bankAccountName":@"bankAccountName",
			@"bankCAccount":@"bankCAccount",
			@"bankName":@"bankName",
			@"isEepay":@"isEepay",
			@"licenseLegalIdCardFrontPath":@"licenseLegalIdCardFrontPath",
			@"licenseLegalIdCardBackPath":@"licenseLegalIdCardBackPath",
			@"businessPlacePhotoPath":@"businessPlacePhotoPath",
			@"otherPhotoPath":@"otherPhotoPath",
			@"licenseLegalIdCardReachPath":@"licenseLegalIdCardReachPath",
			@"bankCardFrontPath":@"bankCardFrontPath",
			@"bankCardBackPath":@"bankCardBackPath",
			@"licenseImagePath":@"licenseImagePath",
			@"operateNumber":@"operateNumber",
			@"storeLat":@"storeLat",
			@"storeLon":@"storeLon",
			@"area":@"area",
			@"storeId":@"storeId",
			@"areaId":@"areaId",
			@"groupMainId":@"groupMainId",
			@"inviterNumber":@"inviterNumber",
			@"groupDiscount":@"groupDiscount",
			@"bankAreaId":@"bankAreaId",
			@"bankAreaName":@"bankAreaName",
			@"cartCode":@"cartCode",
			@"licensecName":@"licensecName"
             };
}

@end

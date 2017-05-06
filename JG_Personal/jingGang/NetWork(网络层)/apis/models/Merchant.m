//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Merchant.h"

@implementation Merchant
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"storeName":@"storeName",
			@"industry":@"industry",
			@"licenseBusinessScope":@"licenseBusinessScope",
			@"storeAddress":@"storeAddress",
			@"storeTelephone":@"storeTelephone",
			@"licenseCMobile":@"licenseCMobile",
			@"storeOwerCard":@"storeOwerCard",
			@"commissionRebate":@"commissionRebate",
			@"bankAccountName":@"bankAccountName",
			@"bankCAccount":@"bankCAccount",
			@"bankName":@"bankName",
			@"licenseLegalIdCardFrontPath":@"licenseLegalIdCardFrontPath",
			@"licenseLegalIdCardBackPath":@"licenseLegalIdCardBackPath",
			@"businessPlacePhotoPath":@"businessPlacePhotoPath",
			@"otherPhotoPath":@"otherPhotoPath",
			@"invitationCode":@"invitationCode",
			@"couponPayAmount":@"couponPayAmount",
			@"chargePayAmount":@"chargePayAmount",
			@"rebateAmount":@"rebateAmount",
			@"storeBannerPath":@"storeBannerPath",
			@"storeLogoPath":@"storeLogoPath"
             };
}

@end

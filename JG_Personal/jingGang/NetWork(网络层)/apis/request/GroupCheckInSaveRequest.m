//
//  AppInitRequest.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GroupCheckInSaveRequest.h"

@implementation GroupCheckInSaveRequest



- (NSMutableDictionary *) getHeaders
{
    
    return self.headers;
}

- (NSMutableDictionary *) getQueryParameters
{
	[self.queryParameters setValue:self.api_storeName forKey:@"storeName"];
	[self.queryParameters setValue:self.api_industry forKey:@"industry"];
	[self.queryParameters setValue:self.api_licenseBusinessScope forKey:@"licenseBusinessScope"];
	[self.queryParameters setValue:self.api_licenseCDesc forKey:@"licenseCDesc"];
	[self.queryParameters setValue:[self.api_gcMainId stringValue] forKey:@"gcMainId"];
	[self.queryParameters setValue:self.api_groupDetailInfo forKey:@"groupDetailInfo"];
	[self.queryParameters setValue:[self.api_areaId stringValue] forKey:@"areaId"];
	[self.queryParameters setValue:self.api_storeAddress forKey:@"storeAddress"];
	[self.queryParameters setValue:self.api_storeTelephone forKey:@"storeTelephone"];
	[self.queryParameters setValue:self.api_licenseCMobile forKey:@"licenseCMobile"];
	[self.queryParameters setValue:[self.api_commissionRebate stringValue] forKey:@"commissionRebate"];
	[self.queryParameters setValue:self.api_bankAccountName forKey:@"bankAccountName"];
	[self.queryParameters setValue:self.api_bankCAccount forKey:@"bankCAccount"];
	[self.queryParameters setValue:self.api_bankName forKey:@"bankName"];
	[self.queryParameters setValue:[self.api_isEepay stringValue] forKey:@"isEepay"];
	[self.queryParameters setValue:self.api_licenseLegalIdCardFrontPath forKey:@"licenseLegalIdCardFrontPath"];
	[self.queryParameters setValue:self.api_licenseLegalIdCardBackPath forKey:@"licenseLegalIdCardBackPath"];
	[self.queryParameters setValue:self.api_businessPlacePhotoPath forKey:@"businessPlacePhotoPath"];
	[self.queryParameters setValue:self.api_otherPhotoPath forKey:@"otherPhotoPath"];
	[self.queryParameters setValue:self.api_licenseLegalIdCardReachPath forKey:@"licenseLegalIdCardReachPath"];
	[self.queryParameters setValue:self.api_bankCardFrontPath forKey:@"bankCardFrontPath"];
	[self.queryParameters setValue:self.api_bankCardBackPath forKey:@"bankCardBackPath"];
	[self.queryParameters setValue:self.api_licenseImagePath forKey:@"licenseImagePath"];
	[self.queryParameters setValue:self.api_operateNumber forKey:@"operateNumber"];
	[self.queryParameters setValue:[self.api_storeLat stringValue] forKey:@"storeLat"];
	[self.queryParameters setValue:[self.api_storeLon stringValue] forKey:@"storeLon"];
	[self.queryParameters setValue:[self.api_groupDiscount stringValue] forKey:@"groupDiscount"];
	[self.queryParameters setValue:self.api_cardCode forKey:@"cardCode"];
	[self.queryParameters setValue:[self.api_bankAreaId stringValue] forKey:@"bankAreaId"];
	[self.queryParameters setValue:self.api_licenseCName forKey:@"licenseCName"];
    return self.queryParameters;
}

- (NSMutableDictionary *) getPathParameters
{
    
    return self.pathParameters;
}
- (Class) getResponseClazz
{
    return GroupCheckInSaveResponse.class;
}

- (NSString *) getApiUrl
{
     NSString *url = [NSString stringWithFormat:@"%@/v1/group/checkIn/save",self.baseUrl];
    return url;
}

@end

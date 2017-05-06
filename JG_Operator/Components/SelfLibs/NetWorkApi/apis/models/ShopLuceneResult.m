//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopLuceneResult.h"

@implementation ShopLuceneResult
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"title":@"title",
			@"mainPhotoUrl":@"mainPhotoUrl",
			@"photosUrl":@"photosUrl",
			@"storePrice":@"storePrice",
			@"costPrice":@"costPrice",
			@"storeUsername":@"storeUsername",
			@"hasExchangeIntegral":@"hasExchangeIntegral",
			@"hasMobilePrice":@"hasMobilePrice",
			@"mobilePrice":@"mobilePrice"
             };
}

@end

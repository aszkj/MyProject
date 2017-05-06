//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "ExpressCompany.h"

@interface ShopExpressCompanyListResponse :  AbstractResponse
//快递公司列表
@property (nonatomic, readonly, copy) NSArray *list;
@end

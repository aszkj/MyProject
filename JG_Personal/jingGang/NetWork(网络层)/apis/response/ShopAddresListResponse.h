//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "ShopAddres.h"

@interface ShopAddresListResponse :  AbstractResponse
//地址列表
@property (nonatomic, readonly, copy) NSArray *addressList;
@end

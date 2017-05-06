//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "TransInfo.h"

@interface ShopExpressTransViewResponse :  AbstractResponse
//快递详情
@property (nonatomic, readonly, copy) TransInfo *trans;
@end

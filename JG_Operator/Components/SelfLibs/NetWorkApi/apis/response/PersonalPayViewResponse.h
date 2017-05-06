//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "GroupOrder.h"

@interface PersonalPayViewResponse :  AbstractResponse
//主订单对象
@property (nonatomic, readonly, copy) GroupOrder *order;
@end

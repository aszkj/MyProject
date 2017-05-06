//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"

@interface UsersIntegralDocResponse :  AbstractResponse
//积分|云币规则说明
@property (nonatomic, readonly, copy) NSString *specContent;
@end

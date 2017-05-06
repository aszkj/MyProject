//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"

@interface BindingListResponse :  AbstractResponse
//第三方帐号绑定的信息集合, 具体值的含义 3:QQ4:微信5:微博  
@property (nonatomic, readonly, copy) NSArray *list;
@end

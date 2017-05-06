//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "PhysicalResult.h"

@interface PhysicalListSelectCodeResponse :  AbstractResponse
//某项体检最后七次结果
@property (nonatomic, readonly, copy) NSArray *physicalSeven;
//某项体检所有结果
@property (nonatomic, readonly, copy) NSArray *physicalAll;
@end

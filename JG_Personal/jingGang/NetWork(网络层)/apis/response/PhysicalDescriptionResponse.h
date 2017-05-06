//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "PhysicalResult.h"
#import "PhysicalTypeApiBO.h"

@interface PhysicalDescriptionResponse :  AbstractResponse
//某天某项体检结果
@property (nonatomic, readonly, copy) PhysicalResult *physical;
//某天所有项体检结果
@property (nonatomic, readonly, copy) NSArray *physicalArr;
//体检类型信息
@property (nonatomic, readonly, copy) PhysicalTypeApiBO *physicalType;
@end

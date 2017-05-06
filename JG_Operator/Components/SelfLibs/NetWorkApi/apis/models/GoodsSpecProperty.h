//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@class GoodsSpecification;
@interface GoodsSpecProperty : MTLModel <MTLJSONSerializing>

//商品规格
@property (nonatomic, readonly, copy) GoodsSpecification *spec;
//id
@property (nonatomic, readonly, copy) NSNumber *apiId;
//specId
@property (nonatomic, readonly, copy) NSNumber *specId;
//specImageId
@property (nonatomic, readonly, copy) NSString *specImageId;
//value
@property (nonatomic, readonly, copy) NSString *value;

@end

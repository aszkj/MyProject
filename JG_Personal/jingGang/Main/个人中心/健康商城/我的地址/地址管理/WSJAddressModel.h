//
//  WSJAddressModel.h
//  jingGang
//
//  Created by thinker on 15/8/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSJAddressModel : NSObject

//段头信息,省份
@property (nonatomic, copy) NSString *areaName;
//每段的id
@property (nonatomic, copy) NSNumber *ID;
//每段的内容，该省份的市、区
@property (nonatomic, strong) NSMutableArray *data;

@end

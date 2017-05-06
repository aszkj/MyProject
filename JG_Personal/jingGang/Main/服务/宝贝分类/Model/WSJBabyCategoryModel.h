//
//  WSJBabyCategoryModel.h
//  jingGang
//
//  Created by thinker on 15/8/20.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSJBabyCategoryModel : NSObject

@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSNumber *ID;
@property (nonatomic, strong) NSMutableArray *dataChilds;

@end

//
//  NSObject+ApiResponseErrFliter.h
//  jingGang
//
//  Created by thinker_des on 15/6/28.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Util.h"

@class AbstractResponse;
@interface NSObject (ApiResponseErrFliter)

+ (void)fliterResponse:(AbstractResponse *)response withBlock:(void (^)(int event, id responseObject))block;

@end

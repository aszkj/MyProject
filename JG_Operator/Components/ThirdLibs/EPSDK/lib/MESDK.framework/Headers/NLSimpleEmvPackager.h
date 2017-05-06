//
//  NLSimpleEmvPackager.h
//  MTypeSDK
//
//  Created by su on 14-1-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "NLEmvPackager.h"

@interface NLSimpleEmvPackager : NSObject<NLEmvPackager>
+ (id)sharedPackager;
@end

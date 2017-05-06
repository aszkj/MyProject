//
//  NLAbstractDevice.h
//  mpos
//
//  Created by su on 13-6-21.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLFoundation.h"
#import "NLDevice.h"
#import "NLDeviceExecutor.h"
NL_NOT_SUPPORTED
@interface NLAbstractDevice : NSObject<NLDevice>
{
}
@property (nonatomic, strong,readonly) NSObject<NLDeviceExecutor> *deviceExecutor;
- (id)initWithDeviceExecutor:(NSObject<NLDeviceExecutor>*)deviceExecutor;

@end

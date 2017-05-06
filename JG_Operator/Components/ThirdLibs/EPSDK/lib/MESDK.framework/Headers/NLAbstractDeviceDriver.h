//
//  NLAbstractDeviceDriver.h
//  mpos
//
//  Created by su on 13-6-21.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLDeviceDriver.h"
#import "NLAbstractDevice.h"
#import "NLDeviceExecutor.h"

@protocol NLAbstractDeviceDriverDataSource <NSObject>
@required
- (NSArray*)connectorsInitialized;
- (NLAbstractDevice*)createDevice:(NSObject<NLDeviceExecutor>*)executor;
@end

@interface NLAbstractDeviceDriver : NSObject<NLDeviceDriver, NLAbstractDeviceDriverDataSource> {
    @private
    NSMutableDictionary *connectorMapping;
}
@property (nonatomic, strong, readonly) NSArray *supportTypes;
- (void)initConnectorsAndSupportTypes;
@end

//
//  NLAbstractModule.h
//  mpos
//
//  Created by su on 13-6-21.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLModule.h"
#import "NLAbstractDevice.h"
#import "NLDeviceEvent.h"
#import "NLDeviceCommand.h"
#import "NLDeviceResponse.h"
#import "NLDirectMessageListener.h"
@protocol NLEventMaker;
@interface NLAbstractModule : NSObject<NLModule>
@property (nonatomic, strong, readonly) NLAbstractDevice *owner;
- (id)initWithDevice:(NLAbstractDevice*)owner;
- (NSObject<NLDeviceResponse>*)invoke:(NSObject<NLDeviceCommand>*)deviceCmd timeout:(int)timeout;
- (NSObject<NLDeviceResponse>*)invoke:(NSObject<NLDeviceCommand>*)deviceCmd timeout:(int)timeout error:(NSError**)err;
- (NSObject<NLDeviceResponse>*)invoke:(NSObject<NLDeviceCommand>*)deviceCmd;
- (void)invoke:(NSObject<NLDeviceCommand>*)deviceCmd listener:(id)listener eventMaker:(NSObject<NLEventMaker>*)eventMaker;

- (void)invoke:(NSObject<NLDeviceCommand>*)deviceCmd
                           timeout:(int)timeout
                          listener:(id)listener
                        eventMaker:(NSObject<NLEventMaker>*)eventMaker;

@end


@protocol NLEventMaker <NLDeviceEvent>
- (id)makeEvent:(NSObject<NLDeviceResponse>*)deviceResponse;
@end

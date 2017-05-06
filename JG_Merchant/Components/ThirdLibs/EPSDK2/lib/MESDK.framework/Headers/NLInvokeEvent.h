//
//  NLInvokeEvent.h
//  mpos
//
//  Created by su on 13-6-21.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLDeviceEvent.h"
#import "NLDeviceResponse.h"
@interface NLInvokeEvent : NSObject<NLDeviceEvent> {
    
}
@property (nonatomic, strong, readonly) NSObject<NLDeviceResponse>* deviceResponse;
@property (nonatomic, strong, readonly) NSString *eventName;
@property (nonatomic, assign, readonly) long timestamp;
- (id)initWithEventName:(NSString*)eventName deviceResponse:(NSObject<NLDeviceResponse>*)deviceResponse;
@end

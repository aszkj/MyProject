//
//  NLAbstractDeviceEvent.h
//  mpos
//
//  Created by su on 13-6-18.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLDeviceEvent.h"
/*!
 @class
 @abstract 抽象事件实现
 @discussion
 */
@interface NLAbstractDeviceEvent : NSObject<NLDeviceEvent> {
}
@property (nonatomic, strong, readonly) NSString *eventName;
@property (nonatomic, assign, readonly) NLLong timestamp;
- (id)initWithEventName:(NSString*)eventName;
@end

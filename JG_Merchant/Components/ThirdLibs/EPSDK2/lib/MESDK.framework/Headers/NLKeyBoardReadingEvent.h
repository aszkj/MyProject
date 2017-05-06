//
//  NLKeyBoardReadingEvent.h
//  MTypeSDK
//
//  Created by su on 13-9-9.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLAbstractProcessDeviceEvent.h"

@interface NLKeyBoardReadingEvent : NLAbstractProcessDeviceEvent
- (id)rslt;
- (id)init;
- (id)initWithRslt:(id)rslt;
- (id)initWithError:(NSError*)error;
@end

@interface NLKeyBoardInputStringEvent : NLKeyBoardReadingEvent
- (NSString*)string;
@end

@interface NLKeyBoardInputAmountDecimalEvent : NLKeyBoardReadingEvent
- (NSDecimalNumber*)amount;
@end


@interface NLKeyBoardInputNumberEvent : NLKeyBoardReadingEvent
- (NSDecimalNumber*)number;
@end
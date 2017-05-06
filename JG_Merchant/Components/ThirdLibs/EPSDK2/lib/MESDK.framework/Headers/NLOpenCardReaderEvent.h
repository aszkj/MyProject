//
//  NLOpenCardReaderEvent.h
//  mpos
//
//  Created by su on 13-6-18.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLAbstractProcessDeviceEvent.h"
/*!
 @class
 @abstract
 @discussion
 */
@interface NLOpenCardReaderEvent : NLAbstractProcessDeviceEvent
@property (nonatomic, strong, readonly) NSArray *openedCardReaders;
- (id)initWithOpenedCardReaders:(NSArray*)openedCardReaders;
- (id)initWithError:(NSError*)error;
@end

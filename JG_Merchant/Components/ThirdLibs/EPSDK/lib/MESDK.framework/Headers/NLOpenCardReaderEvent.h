//
//  NLOpenCardReaderEvent.h
//  mpos
//
//  Created by su on 13-6-18.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLAbstractProcessDeviceEvent.h"
#import "NLCardResultType.h"
/*!
 @class
 @abstract
 @discussion
 */
@interface NLOpenCardReaderEvent : NLAbstractProcessDeviceEvent
@property (nonatomic, strong, readonly) NSArray *openedCardReaders;
@property (nonatomic, assign, readonly) NLCardResultType resultType;
@property (nonatomic, copy, readonly) NSData * snr;
- (id)initWithOpenedCardReaders:(NSArray*)openedCardReaders;
- (id)initWithOpenedCardReaders:(NSArray *)openedCardReaders resultType:(NLCardResultType)resultType snr:(NSData *)snr;
- (id)initWithError:(NSError*)error;
@end

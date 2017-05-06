//
//  NLAbstractCommandSerializer.h
//  MTypeSDK
//
//  Created by su on 13-6-24.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLCommandSerializer.h"
#import "NLCommandDescription.h"
#import "NLFieldDescription.h"

@protocol NLAbstractCommandSerializerAbstractBehaviour <NSObject>
@optional
- (NSData*)toRequestPayload:(id<NLDeviceCommand>)deviceCmd cmdDesc:(NLCommandDescription*)cmdDesc;
/*!
 @version 1.0.0
 @method
 @abstract
 */
- (id<NLDeviceResponse>)loadDeviceResponseWithCmdDesc:(NLCommandDescription*)cmdDesc payload:(NSData *)payload;
/*!
 @version 1.0.6
 @method
 @abstract
 */
- (id<NLDeviceResponse>)loadDeviceResponseWithRespDesc:(NLResponseDescription*)respDesc payload:(NSData *)payload error:(NSError**)err;

@end

@interface NLAbstractCommandSerializer : NSObject<NLCommandSerializer, NLAbstractCommandSerializerAbstractBehaviour>
- (id)unpackFieldWithFieldDesc:(NLFieldDescription*)fieldDesc content:(NSData*)content;
- (NSData*)packFieldWithObject:(id)tgt fieldDesc:(NLFieldDescription*)fieldDesc;
@end

//
//  NLCommandSerializer.h
//  MTypeSDK
//
//  Created by su on 13-6-24.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLDeviceResponse.h"
#import "NLDeviceCommand.h"
#import "NLCommandDescription.h"

@protocol NLCommandSerializer <NSObject>

- (NSData*)toRequestPayload:(id<NLDeviceCommand>)deviceCmd;
- (id<NLDeviceResponse>)loadDeviceResponse:(id<NLDeviceCommand>)deviceCmd payload:(NSData*)payload;
- (id<NLDeviceResponse>)loadNotifiedDeviceResponse:(id<NLDeviceCommand>)deviceCmd payload:(NSData*)payload;
- (NLCommandDescription*)cmdDescription:(id<NLDeviceCommand>)deviceCmd;

@end

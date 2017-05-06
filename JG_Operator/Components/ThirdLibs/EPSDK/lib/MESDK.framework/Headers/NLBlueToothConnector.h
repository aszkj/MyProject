//
//  NLBlueToothConnector.h
//  MTypeSDK
//
//  Created by su on 13-6-24.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLDeviceConnector.h"
#import "NLDeviceTouchController.h"
#import "NLCommandSerializer.h"

@interface NLBlueToothConnector : NSObject<NLDeviceConnector>
- (id)initWithTouchController:(id<NLDeviceTouchController>)controller serializer:(id<NLCommandSerializer>)serializer;
@end

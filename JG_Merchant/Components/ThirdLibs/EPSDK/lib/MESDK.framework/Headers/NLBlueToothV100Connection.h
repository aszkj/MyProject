//
//  NLBlueToothV100Connection.h
//  MTypeSDK
//
//  Created by su on 13-6-24.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLAbstractDuplexDeviceConnection.h"
#import "NLBluetoothSocket.h"
@interface NLBlueToothV100Connection : NLAbstractDuplexDeviceConnection
- (id)initWithTouchController:(id<NLDeviceTouchController>)controller serializer:(id<NLCommandSerializer>)serializer socket:(id<NLSocket>)socket connectId:(long)connId;
@end

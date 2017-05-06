//
//  NLPinEncryptResult.h
//  MTypeSDK
//
//  Created by su on 14/11/10.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLPinEncryptResult : NSObject
@property (nonatomic, strong, readonly) NSData* encrypPin;
@property (nonatomic, strong, readonly) NSData* ksn;
- (id)initWithEncryptPin:(NSData*)encryptPin ksn:(NSData*)ksn;
@end

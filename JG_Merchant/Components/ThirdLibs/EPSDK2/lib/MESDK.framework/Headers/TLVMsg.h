//
//  TLVMsg.h
//  mpos
//
//  Created by su on 13-6-20.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TLVMsg <NSObject>

- (int)tag;
- (NSData*)value;
- (NSData*)pack;
- (NSData*)length;
- (NSString*)hexString;

@end

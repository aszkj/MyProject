//
//  TLVPackage.h
//  mpos
//
//  Created by su on 13-6-20.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLVMsg.h"
/*!
 TODO
 */
@protocol TLVPackage <NSObject>
- (NSEnumerator*)elements;
- (void)appendWithMsg:(NSObject<TLVMsg>*)tlvToAppend;
- (void)appendWithTag:(int)tag value:(NSData*)value;
- (void)appendWithTag:(int)tag stringValue:(NSString*)value;
- (void)deleteByIndex:(int)index;
- (void)deleteByTag:(int)tag;
- (NSObject<TLVMsg>*)findForTag:(int)tag;
- (int)findIndexForTag:(int)tag;
- (NSObject<TLVMsg>*)findNextTLV;
- (NSObject<TLVMsg>*)tlvAtIndex:(int)index;
- (NSString*)stringValueForTag:(int)tag;
- (NSData*)valueForTag:(int)tag;
- (BOOL)hasTag:(int)tag;
- (void)unpackWithBuff:(NSData*)buf offset:(int)offset len:(int)len;
- (void)unpackWithBuff:(NSData*)buf;
/*!
 @method
 @version 1.0.4
 */
- (NSData*)pack;

@end

//
//  NLTLVPackageUtils.h
//  MTypeSDK
//
//  Created by su on 13-10-21.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLVMsg.h"
#import "TLVPackage.h"

@interface NLTLVPackageUtils : NSObject
+ (id<TLVMsg>)tlvMsg;
+ (id<TLVPackage>)tlvPackage;
+ (int)transferBERTLVTag:(int)tag;
@end

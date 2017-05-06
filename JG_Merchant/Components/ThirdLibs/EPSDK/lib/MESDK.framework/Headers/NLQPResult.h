//
//  NLQPResult.h
//  MTypeSDK
//
//  Created by su on 14-4-8.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLQPResult : NSObject
@property (nonatomic) Byte qpCardType;
@property (nonatomic, strong) NSData *cardSerialNo;
@property (nonatomic, strong) NSData *ATQA;
- (NSString*)qpCardName;
- (id)initWithCardType:(Byte)qpCardType serialNo:(NSData*)cardSerialNo ATQA:(NSData*)ATQA;


@end

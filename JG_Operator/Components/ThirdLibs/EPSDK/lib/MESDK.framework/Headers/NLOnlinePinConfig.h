//
//  NLOnlinePinConfig.h
//  MTypeSDK
//
//  Created by su on 14-1-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLWorkingKey.h"
#import "NLPinInput.h"

/*!
 @class
 @abstract 联机pin参数设置
 @discussion
 */
@interface NLOnlinePinConfig : NSObject
@property (nonatomic, strong) NLWorkingKey *workingKey;
@property (nonatomic) NLPinManageType pinManageType;
@property (nonatomic) int inputMaxLen;
@property (nonatomic, strong) NSData *pinPadding;
@property (nonatomic) BOOL isEnterEnabled;
@property (nonatomic) int timeout;
@property (nonatomic, strong) NSString *displayContent;
@end

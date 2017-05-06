//
//  NLMacResult.h
//  MTypeSDK
//
//  Created by su on 14/6/19.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 @class
 @abstract mac计算的处理结果
 @discussion
 */
@interface NLMacResult : NSObject
@property (nonatomic, strong) NSData *mac; // 返回处理的结果数据
@property (nonatomic, strong) NSData *ksn; // 返回处理的ksn（或者是给定的随机数等参与运算的数据，由不同算法指定）
- (id)initWithMac:(NSData*)mac ksn:(NSData*)ksn;
@end

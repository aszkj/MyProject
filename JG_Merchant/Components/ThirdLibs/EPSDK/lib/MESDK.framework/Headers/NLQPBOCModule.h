//
//  NLQPBOCModule.h
//  MTypeSDK
//
//  Created by su on 14-1-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "NLModule.h"
#import "NLEmvTransInfo.h"
/*!
 @protocol
 @abstract qpboc交易模块
 @discussion
 */
@protocol NLQPBOCModule <NLModule>
/**
 * 开启一个标准的QPBOC流程<p>
 *
 * @param amount 消费金额
 * @param timeout 超时时间
 * @return
 */
- (NLEmvTransInfo*)startQPBOCWithAmount:(NSDecimalNumber*)amount timeout:(NSTimeInterval)timeout error:(NSError**)err;
- (NLEmvTransInfo*)startQPBOCWithAmount:(NSDecimalNumber*)amount processCode:(int)processCode timeout:(NSTimeInterval)timeout error:(NSError**)err;

@end

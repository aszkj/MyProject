//
//  NLCardReaderResult.h
//  MTypeSDK
//
//  Created by wanglx on 15/5/15.
//  Copyright (c) 2015年 newland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLCardResultType.h"
@interface NLCardReaderResult : NSObject
/**
 *  响应的读卡方式
 */
@property (nonatomic, strong, readonly) NSArray *openedCardReaders;
/**
 *  刷卡结果
 */
@property (nonatomic, assign) NLCardResultType resultType;
/**
 *  如果 resultType 为 (M1)卡,返回获取 的序列号
 *  如果 resultType 为 (A 卡)或者 (B 卡),返 回 ATQA 数据。
 */
@property (nonatomic, copy, readonly) NSData *snr;

-(id)initWithCardReaders:(NSArray*)openedCardReaders resultType:(NLCardResultType)resultType snr:(NSData*)snr;
@end

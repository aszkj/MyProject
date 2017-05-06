//
//  NLAbstractProcessDeviceEvent.h
//  mpos
//
//  Created by su on 13-6-18.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLAbstractDeviceEvent.h"

typedef enum {
    NLProcessStateProcessing,
    NLProcessStateUserCanceled,
    NLProcessStateSuccess,
    NLProcessStateFailed
} NLProcessState;

/*!
 @class
 @abstract 抽象的事务性处理事件
 @discussion
 TODO
 */
@interface NLAbstractProcessDeviceEvent : NLAbstractDeviceEvent
@property (nonatomic, strong, readonly) NSError *error;
@property (nonatomic, assign, readonly) BOOL isSuccess; // 获得该事务处理成功还是失败(true:成功 false:失败)
@property (nonatomic, assign, readonly) BOOL isUserCanceled; // 该事务处理是否被客户撤消
@property (nonatomic, assign, readonly) BOOL isProcessing; // 该事务处理是否还在进行中,即继续接受事件响应
@property (nonatomic, assign, readonly) BOOL isFailed; // 该事务处理是否失败


- (id)initWithEventName:(NSString *)eventName isSuccess:(BOOL)isSuccess error:(NSError*)error;
- (id)initWithEventName:(NSString *)eventName state:(NLProcessState)state error:(NSError *)error;
@end

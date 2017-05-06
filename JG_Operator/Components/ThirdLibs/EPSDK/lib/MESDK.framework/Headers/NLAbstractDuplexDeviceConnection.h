//
//  NLAbstractDuplexDeviceConnection.h
//  MTypeSDK
//
//  Created by su on 13-6-24.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLAbstractDeviceConnection.h"
#import "NLSimIdGenerator.h"

@protocol NLAbstractDuplexDeviceConnectionAbstractBehaviour <NSObject>
@required
/**
 * 要求底层实现一个通道的关闭。<p>
 */
- (void)implClose;
/**
 * 读满一个缓冲区，在未读满，碰到流末尾，出现异常，读取超时前，该方法会一直阻塞。 <p>
 * 该方法期待一个读取超时异常，此时认为之前读取是一个被篡改或者非法的的数据。并期待下面的请求响应可用。<p>
 * 需要将可能关联到超时的异常，（例如：SocketTimeoutException)，转换成一个ReadTimeout异常。以便上层正确处理。
 * @param buffer 缓冲区
 * @return
 * @throws ReadTimeout 读取超时
 * @throws IOException io操作异常
 */
- (NSData*)read:(int)len error:(NSError**)err;
/**
 * 读满一个缓冲区，在未读满，碰到流末尾，出现异常，读取超时前，该方法会一直阻塞。
 * 该方法期待一个读取超时异常，此时认为之前读取是一个被篡改或者非法的的数据。并期待下面的请求响应可用。<p>
 * 需要将可能关联到超时的异常，（例如：SocketTimeoutException)，转换成一个ReadTimeout异常。以便上层正确处理。
 * @param buffer 缓冲区
 * @param offset 起始偏移量
 * @param len 读取长度
 * @return
 * @throws ReadTimeout 读取超时
 * @throws IOException io操作异常
 */
- (NSData*)read:(int)len offset:(int)offset error:(NSError**)err;
/**
 * 写入一组数据
 * @param buffer 缓存区数据
 * @throws IOException io操作异常
 */
- (void)write:(NSData*)buffer error:(NSError**)err;
/**
 * 在出错时后读空缓冲区，该方法应该在良好的时间范围内返回。
 * @param expectedMaxmium 可能的最大长度
 * @throws IOException io 操作异常
 */
- (void)clearBuffer:(int)expectedMaxmium error:(NSError**)err;
@end


@interface NLAbstractDuplexDeviceConnection : NLAbstractDeviceConnection<NLAbstractDuplexDeviceConnectionAbstractBehaviour>
@property (atomic) BOOL isClosed;

- (NLSimIdGenerator *)simIdGenerator;
- (NSObject *)idGenSync;
+ (NSData*)makeupPayload:(NSData *)serial cmdcode:(NSData*)cmdcode body:(NSData*)body;
- (void)stopService;
- (void)startService;
@end
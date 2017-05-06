//
//  NLStoreModule.h
//  MTypeSDK
//
//  Created by wanglx on 14-5-20.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLModule.h"
#import "NLDeviceEventListener.h"
@protocol NLStoreModule <NLModule>
/**
 *  初始化
 *
 *  @param recordName   记录名
 *  @param recordLen    每条记录长度
 *  @param field1Offset 检索字段 1 在记录中的 偏移
 *  @param field1Len    检索字段 1 的长度
 *  @param field2Offset 检索字段 2 在记录中的 偏移
 *  @param field2Len    检索字段 2 的长度
 */
-(void)initStoreWithRecordName:(NSString *)recordName recordLen:(int)recordLen field1Offset:(int)field1Offset field1Len:(int)field1Len field2Offset:(int)field2Offset field2Len:(int)field2Len error:(NSError **)err;
/**
 *  获取存储记录数
 *
 *  @param recordName 记录名
 *
 *  @return 记录数
 */
-(int)getStoreRecordNumWithRecordName:(NSString *)recordName error:(NSError **)err;
/**
 *  增加存储记录
 *
 *  @param recordName    记录名
 *  @param recordContent 记录内容
 *
 *  @return 执行结果 -1:未知错误 0:成功 1:文件系统错误 2:内容长度受限
 */
-(int)addStoreRecordWithRecordName:(NSString *)recordName recordContent:(NSString *)recordContent error:(NSError **)err;
-(int)addStoreRecordWithRecordName:(NSString *)recordName recordContentData:(NSData *)recordContent error:(NSError **)err;
/**
 *  更新存储记录
 *
 *  @param recordName     记录名
 *  @param recordNo       记录号
 *  @param field1         检索字段 1
 *  @param field2         检索字段 2
 *  @param getStoreRecord 记录内容
 *
 *  @return 执行结果 -1:未知错误 0:成功 1:文件系统错误 2:内容长度受限
 */
-(int)updateStoreRecordWithRecordName:(NSString *)recordName recordNo:(int)recordNo field1:(NSString *)field1 field2:(NSString *)field2 recordContent:(NSString *)recordContent error:(NSError **)err;
-(int)updateStoreRecordWithRecordName:(NSString *)recordName recordNo:(int)recordNo field1:(NSString *)field1 field2:(NSString *)field2 recordContentData:(NSData *)recordContent error:(NSError **)err;
/**
 *  获取存储记录
 *
 *  @param recordName     记录名
 *  @param recordNo       记录号
 *  @param field1         检索字段 1
 *  @param field2         检索字段 2
 *
 *  @return nil:失败 recordContent
 */
-(NSString *)getStoreRecordWithRecordName:(NSString *)recordName recordNo:(int)recordNo field1:(NSString *)field1 field2:(NSString *)field2 error:(NSError **)err;
-(NSData *)getStoreRecordDataWithRecordName:(NSString *)recordName recordNo:(int)recordNo field1:(NSString *)field1 field2:(NSString *)field2 error:(NSError **)err;
@end

//
//  DatabaseCache.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabaseQueue;
@class FMDatabase;
@class SessonContentMessage;
@class SessonContentModel;
@class FeedLocalModel;
@class FoundDataBaseModel;

#define KTableNameOfSessionContent       @"t_session_content"
#define KTableNameOfMyFeedContent       @"t_Myfeed_content"
#define KTableNameOfFoundContent        @"t_Found_content"

@interface DatabaseCache : NSObject

@property (nonatomic,strong)NSString *m_dbPath;
@property(nonatomic,retain) FMDatabase *db;
@property(nonatomic,retain) FMDatabaseQueue *dbQueue;

+ (instancetype)shareInstance;
- (NSString *)getDbPath;
- (BOOL)createDBWithPath:(NSString *)path;

#pragma mark - 删除某个表
- (void)dropDataBaseWithName:(NSString *)tableName;

#pragma mark - 查询某个表的所有记录
- (NSMutableArray *)SelectAllByTableName:(NSString*)name;

#pragma mark - 查询某个表的满足所有and条件的记录
- (NSMutableArray *)SelectAllBycondition:(NSDictionary*)dicCondtion TableName:(NSString*)name orderName:(NSArray *)orderNameList;

#pragma mark -  根据表名往表中插入一条记录
- (BOOL)InsertIntoTableFieldDict:(NSDictionary*)dic tableName:(NSString*)name;

#pragma mark - 删除某个表的所有记录
- (BOOL)DeleteAllByTableName:(NSString*)name;

#pragma mark - 删除满足所有and条件的记录
- (BOOL)DeleteBycondition:(NSDictionary*)dicCondtion tableName:(NSString*)name;

#pragma mark - 更新满足所有条件的记录
-(BOOL)UpdateTableField:(NSDictionary*)dic condition:(NSDictionary*)dicCondtion tableName:(NSString*)name;


@end

@interface DatabaseCache(xx_message)

//查询
- (NSMutableArray *)selectDataSource;

//查询一页的数据
- (NSMutableArray *)selectPageDataFromTimestamp:(NSString *)timestamp channel:(NSString *)channel size:(NSInteger)size withTablename:(NSString *)tableName;

// 根据sql查询某个表的所有记录
- (NSMutableArray *)SelectInfoWithSqlString:(NSString *)sqlString;

//新增
- (void)addSessonContentInfo:(SessonContentModel *)info;

//插入多条数据
- (void)addSessonContentInfoWithArray:(NSArray<SessonContentModel *> *)infoList;

//判断是否存在指定的一条信息
- (BOOL)isHasSessonContentMessageWithChannel:(NSString *)channel localid:(NSString *)localid;

//查询单条数据
- (SessonContentModel *)selectSessonContentMessageWithChannel:(NSString *)channel localid:(NSString *)localid;

//更新消息是否已经到达的标记
- (void)updateKeyidWithKeyid:(NSString *)keyid Channel:(NSString *)channel localid:(NSString *)localid;

//更新本地消息时间戳
- (void)updateTimestampWithTimestamp:(NSString *)timestamp Channel:(NSString *)channel localid:(NSString *)localid;
//信息发送成功后，更新key_id 和时间戳
- (void)updateKeyidWithKeyid:(NSString *)keyid Timestamp:(NSString *)timestamp Channel:(NSString *)channel localid:(NSString *)localid;
//信息发送失败
- (void)updateInfoErrorWithChannel:(NSString *)channel localid:(NSString *)localid isSendError:(NSString *)error;
//修改指定消息的url
- (void)updateInfoErrorWithChannel:(NSString *)channel localid:(NSString *)localid contentURL:(NSString *)url;
//删除指定信息
- (void)deleteInfoWithChannel:(NSString *)channel localid:(NSString *)localid;




//根据channel删除本地数据库对应的数据
- (void)deleteMessageWithChannel:(NSString *)channel;

@end

@interface DatabaseCache (Myfeed)

//查询一页的数据
- (NSMutableArray<FeedLocalModel *> *)selectMyfeedPageSize:(NSInteger)size;

//新增
- (void)addMyfeedContentInfo:(FeedLocalModel *)info;

//插入多条数据
- (void)addMyfeedContentInfoWithArray:(NSArray<FeedLocalModel *> *)infoList;

@end

@interface DatabaseCache (Found)
//查询一页的数据
- (NSMutableArray<FoundDataBaseModel *> *)selectFoundPageSize:(NSInteger)size;

//更新或新增一条发现记录
- (void)upDateOraddOneFoundContent:(FoundDataBaseModel *)info;

//更新或新增多条发现记录
- (void)addFoundContentInfoWithArray:(NSArray<FoundDataBaseModel *> *)infoList;

@end


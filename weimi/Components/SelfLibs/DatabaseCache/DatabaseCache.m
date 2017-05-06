//
//  DatabaseCache.m
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "DatabaseCache.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "FileMangeHelper.h"
#import "SessonContentModel.h"
#import <JSONModel.h>
#import "NSDate+Addition.h"
#import "AppDelegate.h"
#import "FeedLocalModel.h"
#import "FoundDataBaseModel.h"

#define CREATE_SQL @"\
CREATE TABLE IF NOT EXISTS t_session_content(session_content_id INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,channel VARCHAR, msgId VARCHAR,localId VARCHAR,msgType VARCHAR, model VARCHAR,uid VARCHAR,contentWidth VARCHAR,contentHeight VARCHAR,contentText VARCHAR,contentUrl VARCHAR,contentCode VARCHAR,contentType VARCHAR,contentTimestamp VARCHAR,contentDuration INTEGER,componentId VARCHAR,componentName VARCHAR,componentUrl VARCHAR,componentVersion VARCHAR,componentDesc VARCHAR,componentOrderCode VARCHAR,componentTaskId VARCHAR,componentState VARCHAR,componentViewType VARCHAR,isMyself VARCHAR,localFileName VARCHAR,sequel VARCHAR,key_id VARCHAR,isHiddenTime VARCHAR,isSendError VARCHAR,hasRead VARCHAR);\
CREATE TABLE IF NOT EXISTS t_Myfeed_content(Myfeed_content_id INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,title VARCHAR, voice_url VARCHAR, image_url VARCHAR,type VARCHAR, timestamp INTEGER, lastUpdate INTEGER, _id VARCHAR, uid VARCHAR, distance VARCHAR, toFriendCircle INTEGER, toLbs INTEGER);\
CREATE TABLE IF NOT EXISTS t_Found_content(found_channnel VARCHAR PRIMARY KEY  NOT NULL,found_poster_Uid VARCHAR, found_poster_avartUrl VARCHAR, found_poster_nickName VARCHAR,found_content_Type VARCHAR,found_content_Text VARCHAR,found_content_ImgUrl VARCHAR,found_content_AudioUrl VARCHAR, found_hasLatestMessage INTEGER, found_repy_Type VARCHAR, found_repy_Text VARCHAR, found_repyer_Uid VARCHAR, found_repyer_NickName VARCHAR,  found_distanceStr VARCHAR, found_fromWhereTypeStr VARCHAR, found_disstributTime INTEGER, found_hasUnreadMessage INTEGER);"


@implementation DatabaseCache

+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (id)init
{
    if (self = [super init])
    {
        self.m_dbPath = [self getDbPath];
    }
    return self;
}

- (BOOL)createDBWithPath:(NSString *)path
{
    if(!IsEmpty(path)) {
        self.m_dbPath = path;
        self.db = [FMDatabase databaseWithPath:self.m_dbPath];
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:self.m_dbPath];
        if (self.dbQueue) {
            
            NSArray * parts = [CREATE_SQL componentsSeparatedByString:@";"];
            for(NSString *str in parts)
            {
                if (!IsEmpty(str)) {
                    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
                        [db executeUpdate:str];
                    }];
                }
            }
        } else {
            return NO;
        }
    } else {
        return NO;
    }
    
    return YES;
}

- (NSString *)getDbPath
{    
    return [[FileMangeHelper shareInstance] getDataBasePath];
}

- (void)dropDataBaseWithName:(NSString *)tableName
{
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql = [NSString stringWithFormat:@"drop TABLE %@",tableName];
        [db executeUpdate:sql];
    }];
}

#pragma mark -  根据表名往表中插入一条记录
- (BOOL)InsertIntoTableFieldDict:(NSDictionary*)dic tableName:(NSString*)name
{
    if([self NSStringIsNULL:name]) return NO;
    if(dic==nil || [dic count]==0) return NO;
    
    NSArray * arrKeys=[dic allKeys];
    NSArray * arrValues=[dic allValues];
    NSUInteger count=[arrKeys count];
    NSString *sql = [NSString stringWithFormat:@"insert or ignore into %@(",name];
    NSMutableString * tempsql=[NSMutableString stringWithString:sql];
    for (int i=0; i<count; i++)
    {
        [tempsql appendString:[arrKeys objectAtIndex:i]];
        if(i != count-1)
        {
            [tempsql appendString:@","];
        }
    }
    [tempsql appendString:@") values("];
    
    for(int k=0; k<count; k++)
    {
        [tempsql appendString:@"?"];
        if(k != count-1)
        {
            [tempsql appendString:@","];
        }
    }
    [tempsql appendString:@")"];
    
    __block BOOL successed = YES;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        BOOL hasSuccessed = [db executeUpdate:tempsql withArgumentsInArray:arrValues];
        successed = hasSuccessed;
    }];
    
    return successed;
}

#pragma mark - 查询某个表的所有记录
- (NSMutableArray *)SelectAllByTableName:(NSString*)name
{
    NSMutableArray *list = [[NSMutableArray alloc] init];

    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql = [NSString stringWithFormat:@"select * from %@",name];
        
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            
            @autoreleasepool {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                for (int i =0 ; i < rs.columnCount; i++) {
                    if ([rs stringForColumnIndex:i]) {
                        
                        NSString *value = [rs stringForColumnIndex:i];
                        NSString *result = value;
                                                
                        [dic setObject:result forKey:[rs columnNameForIndex:i]];
                        
                    } else {
                        [dic setObject:@"" forKey:[rs columnNameForIndex:i]];
                    }
                }
                [list addObject:dic];
            }
        }
    }];
    
    return list;
}

#pragma mark - 根据sql查询某个表的所有记录
- (NSMutableArray *)SelectAllByTableName:(NSString*)name sqlString:(NSString *)sqlString {
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        FMResultSet *rs = [db executeQuery:sqlString];
        while ([rs next]) {
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            for (int i =0 ; i < rs.columnCount; i++) {
                if ([rs stringForColumnIndex:i]) {
                    
                    NSString *value = [rs stringForColumnIndex:i];
                    [dic setObject:value forKey:[rs columnNameForIndex:i]];
                    
                } else {
                    [dic setObject:@"" forKey:[rs columnNameForIndex:i]];
                }
            }
            
            [list addObject:dic];
        }
    }];
    
    return list;
    
}

#pragma mark - 查询某个表的满足所有and条件的记录
- (NSMutableArray *)SelectAllBycondition:(NSDictionary*)dicCondtion TableName:(NSString*)name orderName:(NSArray *)orderNameList
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if(dicCondtion==nil || [dicCondtion count]==0) return list;

    NSArray * arrKeys=[dicCondtion allKeys];
    NSArray * arrValues=[dicCondtion allValues];
    NSUInteger count=[arrKeys count];
    
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where ",name];
    
    NSMutableString * tempsql=[NSMutableString stringWithString:sql];
    for (int i=0; i<count; i++) {
        [tempsql appendString:[arrKeys objectAtIndex:i]];
        [tempsql appendString:@"=? "];
        if(i!=count-1)
        {
            [tempsql appendString:@"and "];
        }
    }
    
    if (orderNameList && orderNameList.count > 0) {
        for (int j = 0; j<orderNameList.count; j++) {
            if (j == 0) {
                [tempsql appendString:[NSString stringWithFormat:@" order by %@",orderNameList[j]]];
            } else {
                [tempsql appendString:[NSString stringWithFormat:@" ,%@",orderNameList[j]]];
            }
        }
    }
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        FMResultSet *rs = [db executeQuery:tempsql withArgumentsInArray:arrValues];
        while ([rs next]) {
            
            @autoreleasepool {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                for (int i =0 ; i < rs.columnCount; i++) {
                    if ([rs stringForColumnIndex:i]) {
                        
                        NSString *value = [rs stringForColumnIndex:i];
                        NSString *key = [rs columnNameForIndex:i];
                        NSString *result = [Util removeDivHtmlWithKey:key value:value];
                        
                        [dic setObject:result forKey:key];
                        
                    } else {
                        [dic setObject:@"" forKey:[rs columnNameForIndex:i]];
                    }
                }
                
                [list addObject:dic];
            }
        }
    }];

    return list;
}

#pragma mark - 删除某个表的所有记录
- (BOOL)DeleteAllByTableName:(NSString*)name
{
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql = [NSString stringWithFormat:@"delete from %@",name];
        [db executeUpdate:sql];
    }];
    return YES;
}

#pragma mark - 删除满足所有and条件的记录
- (BOOL)DeleteBycondition:(NSDictionary*)dicCondtion tableName:(NSString*)name
{
    if([self NSStringIsNULL:name]) return NO;
    if(dicCondtion==nil || [dicCondtion count]==0) return NO;
    
    NSArray * arrKeys=[dicCondtion allKeys];
    NSArray * arrValues=[dicCondtion allValues];
    NSUInteger count=[arrKeys count];
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where ",name];
    NSMutableString * tempsql=[NSMutableString stringWithString:sql];
    for (int i=0; i<count; i++)
    {
        [tempsql appendString:[arrKeys objectAtIndex:i]];
        [tempsql appendString:@"=? "];
        if(i!=count-1)
        {
            [tempsql appendString:@"and "];
        }
    }
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:tempsql withArgumentsInArray:arrValues];
    }];
    return YES;
}

#pragma mark - 更新满足所有条件的记录
-(BOOL)UpdateTableField:(NSDictionary*)dic condition:(NSDictionary*)dicCondtion tableName:(NSString*)name
{
    if([self NSStringIsNULL:name]) return NO;
    if(dicCondtion==nil || [dicCondtion count]==0) return NO;
    NSUInteger count=[dic count];
    if(dic==nil || count==0) return NO;
    NSArray * keyArray=[dic allKeys];
    NSString *sql = [NSString stringWithFormat:@"update %@ set ",name];
    NSMutableString * tempsql=[NSMutableString stringWithString:sql];
    
    for (int i=0; i<count; i++) {
        [tempsql appendString:[keyArray objectAtIndex:i]];
        [tempsql appendString:@"=?"];
        if(i != count-1)
        {
            [tempsql appendString:@", "];
        }
    }
    count=[dicCondtion count];
    [tempsql appendString:@" where "];
    keyArray=[dicCondtion allKeys];
    for (int i=0; i<count; i++) {
        [tempsql appendString:[keyArray objectAtIndex:i]];
        [tempsql appendString:@"=?"];
        if(i != count-1)
        {
            [tempsql appendString:@" and "];
        }
    }
    
    NSMutableArray * valArray=[NSMutableArray arrayWithArray:[dic allValues]];
    NSArray *conditionValArray=[dicCondtion allValues];
    for(int i=0;i<[conditionValArray count];i++)
    {
        [valArray addObject:[conditionValArray objectAtIndex:i]];
    }
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:tempsql withArgumentsInArray:valArray];
    }];
    
    return YES;
}

- (BOOL)NSStringIsNULL:(NSString *)aStirng
{
    if(aStirng == nil) return YES;
    if ([aStirng length] == 0) return YES;
    if ([aStirng isKindOfClass:[NSNull class]])return YES;
    return NO;
}

@end

@implementation DatabaseCache(xx_message)

//查询
- (NSMutableArray *)selectDataSource {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    NSString *name = @"";
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql = [NSString stringWithFormat:@"select * from %@",name];
        
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            
            @autoreleasepool {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                for (int i =0 ; i < rs.columnCount; i++) {
                    if ([rs stringForColumnIndex:i]) {
                        
                        NSString *value = [rs stringForColumnIndex:i];
                        NSString *result = value;
                        
                        [dic setObject:result forKey:[rs columnNameForIndex:i]];
                        
                    } else {
                        [dic setObject:@"" forKey:[rs columnNameForIndex:i]];
                    }
                }
                [list addObject:dic];
            }
        }
    }];
    
    return list;
}

// 根据sql查询某个表的所有记录
- (NSMutableArray *)SelectInfoWithSqlString:(NSString *)sqlString {
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        FMResultSet *rs = [db executeQuery:sqlString];
        while ([rs next]) {
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            for (int i =0 ; i < rs.columnCount; i++) {
                if ([rs stringForColumnIndex:i]) {
                    
                    NSString *value = [rs stringForColumnIndex:i];
                    [dic setObject:value forKey:[rs columnNameForIndex:i]];
                    
                } else {
                    [dic setObject:@"" forKey:[rs columnNameForIndex:i]];
                }
            }
            
            [list addObject:dic];
        }
    }];
    
    return list;
}

//查询一页的数据
- (NSMutableArray *)selectPageDataFromTimestamp:(NSString *)timestamp channel:(NSString *)channel size:(NSInteger)size withTablename:(NSString *)tableName {
    
    NSString *sqlString;
    
    if ([timestamp isEqualToString:@"0"]) {
        sqlString = [NSString stringWithFormat:@"select * from %@ where  channel = '%@' order by contentTimestamp desc limit %ld offset 0",KTableNameOfSessionContent,channel,(long)size];
    } else {
        sqlString = [NSString stringWithFormat:@"select * from %@ where contentTimestamp < '%@' and channel = '%@' order by contentTimestamp desc limit %ld offset 0",KTableNameOfSessionContent,timestamp,channel,(long)size];
    }
    NSMutableArray *contentList = [self SelectInfoWithSqlString:sqlString];
    
    if (contentList && contentList.count > 0) {
        
        return [SessonContentModel arrayOfModelsFromDictionaries:contentList];
    }
    
    return nil;
}

//判断是否存在指定的一条信息
- (BOOL)isHasSessonContentMessageWithChannel:(NSString *)channel localid:(NSString *)localid {
    
//    NSMutableDictionary *condition = [[NSMutableDictionary alloc] init];
    if (!IsEmpty(channel) && !IsEmpty(localid)) {
//        [condition setObject:channel forKey:@"channel"];
//        [condition setObject:localid forKey:@"localId"];
//        NSMutableArray *messageList = [self SelectAllBycondition:condition TableName:KTableNameOfSessionContent orderName:nil];
        
        NSString *sqlString = [NSString stringWithFormat:@"select * from %@ where localId = '%@' and channel = '%@' ",KTableNameOfSessionContent,localid,channel];
        NSMutableArray *contentList = [self SelectInfoWithSqlString:sqlString];
        
        if (contentList && contentList.count > 0) {
            return YES;
        }
    }
    
    return false;
}

//查询单条数据
- (SessonContentModel *)selectSessonContentMessageWithChannel:(NSString *)channel localid:(NSString *)localid {
    
    NSMutableDictionary *condition = [[NSMutableDictionary alloc] init];
    if (!IsEmpty(channel)) {
        [condition setObject:channel forKey:@"channel"];
    }
    if (!IsEmpty(localid)) {
        [condition setObject:localid forKey:@"localId"];
    }
    
    NSMutableArray *messageList = [self SelectAllBycondition:condition TableName:KTableNameOfSessionContent orderName:nil];
    
    if (messageList && messageList.count > 0) {
        
        return [SessonContentModel arrayOfModelsFromDictionaries:messageList][0];
    }
    
    return nil;
}

//插入单条数据
- (void)addSessonContentInfo:(SessonContentModel *)info {
    
    [self InsertIntoTableFieldDict:[info toDictionary] tableName:KTableNameOfSessionContent];
}

//插入多条数据
- (void)addSessonContentInfoWithArray:(NSArray<SessonContentModel *> *)infoList {
    if (!infoList || infoList.count == 0) { return; }
    for (SessonContentModel *info in infoList) {
        [self addSessonContentInfo:info];
    }
}

//更新消息是否已经到达的标记
- (void)updateKeyidWithKeyid:(NSString *)keyid Channel:(NSString *)channel localid:(NSString *)localid {
    
    NSMutableDictionary *condition = [[NSMutableDictionary alloc] init];
    if (!IsEmpty(channel)) {
        [condition setObject:channel forKey:@"channel"];
    }
    if (!IsEmpty(localid)) {
        [condition setObject:localid forKey:@"localId"];
    }
    
    [self UpdateTableField:[NSDictionary dictionaryWithObjectsAndKeys:keyid,@"key_id", nil] condition:condition tableName:KTableNameOfSessionContent];

}

//更新本地消息时间戳
- (void)updateTimestampWithTimestamp:(NSString *)timestamp Channel:(NSString *)channel localid:(NSString *)localid {
    
    NSMutableDictionary *condition = [[NSMutableDictionary alloc] init];
    if (!IsEmpty(channel)) {
        [condition setObject:channel forKey:@"channel"];
    }
    if (!IsEmpty(localid)) {
        [condition setObject:localid forKey:@"localId"];
    }

    [self UpdateTableField:[NSDictionary dictionaryWithObjectsAndKeys:timestamp,@"contentTimestamp", nil] condition:condition tableName:KTableNameOfSessionContent];

}
//信息发送成功后，更新key_id 和时间戳
- (void)updateKeyidWithKeyid:(NSString *)keyid Timestamp:(NSString *)timestamp Channel:(NSString *)channel localid:(NSString *)localid
{
    NSMutableDictionary *condition = [[NSMutableDictionary alloc] init];
    if (!IsEmpty(channel)) {
        [condition setObject:channel forKey:@"channel"];
    }
    if (!IsEmpty(localid)) {
        [condition setObject:localid forKey:@"localId"];
    }
    
    [self UpdateTableField:[NSDictionary dictionaryWithObjectsAndKeys:timestamp,@"contentTimestamp",keyid,@"key_id", nil] condition:condition tableName:KTableNameOfSessionContent];
}
//信息发送失败
- (void)updateInfoErrorWithChannel:(NSString *)channel localid:(NSString *)localid isSendError:(NSString *)error
{
    NSMutableDictionary *condition = [[NSMutableDictionary alloc] init];
    if (!IsEmpty(channel)) {
        [condition setObject:channel forKey:@"channel"];
    }
    if (!IsEmpty(localid)) {
        [condition setObject:localid forKey:@"localId"];
    }
    
    [self UpdateTableField:[NSDictionary dictionaryWithObjectsAndKeys:error,@"isSendError", nil] condition:condition tableName:KTableNameOfSessionContent];
}
//修改指定消息的url
- (void)updateInfoErrorWithChannel:(NSString *)channel localid:(NSString *)localid contentURL:(NSString *)url
{
    NSMutableDictionary *condition = [[NSMutableDictionary alloc] init];
    if (!IsEmpty(channel)) {
        [condition setObject:channel forKey:@"channel"];
    }
    if (!IsEmpty(localid)) {
        [condition setObject:localid forKey:@"localId"];
    }
    
    [self UpdateTableField:[NSDictionary dictionaryWithObjectsAndKeys:url,@"contentUrl", nil] condition:condition tableName:KTableNameOfSessionContent];
}
//删除指定信息
- (void)deleteInfoWithChannel:(NSString *)channel localid:(NSString *)localid
{
    NSMutableDictionary *condition = [[NSMutableDictionary alloc] init];
    if (!IsEmpty(channel)) {
        [condition setObject:channel forKey:@"channel"];
    }
    if (!IsEmpty(localid)) {
        [condition setObject:localid forKey:@"localId"];
    }
    [self DeleteBycondition:condition tableName:KTableNameOfSessionContent];
}
//根据channel删除本地数据库对应的数据
- (void)deleteMessageWithChannel:(NSString *)channel {
    
    NSMutableDictionary *condition = [[NSMutableDictionary alloc] init];
    if (!IsEmpty(channel)) {
        [condition setObject:channel forKey:@"channel"];
        [self DeleteBycondition:condition tableName:KTableNameOfSessionContent];
    }

}

@end

@implementation DatabaseCache (Myfeed)

- (NSMutableArray<FeedLocalModel *> *)selectMyfeedPageSize:(NSInteger)size
{
    NSString *sqlString;
    sqlString = [NSString stringWithFormat:@"select * from %@ order by timestamp desc limit %ld offset 0",KTableNameOfMyFeedContent,(long)size];
    NSMutableArray *contentList = [self SelectInfoWithSqlString:sqlString];
    if (contentList && contentList.count > 0) {
        
        return [FeedLocalModel objectArrayWithKeyValuesArray:contentList];
    }
    
    return nil;
}


//新增
- (void)addMyfeedContentInfo:(FeedLocalModel *)info
{
    [self InsertIntoTableFieldDict:[info keyValues] tableName:KTableNameOfMyFeedContent];
}

//插入多条数据
- (void)addMyfeedContentInfoWithArray:(NSArray<FeedLocalModel *> *)infoList
{
    for (FeedLocalModel *info in infoList) {
        [self addMyfeedContentInfo:info];
    }
}

@end

@implementation DatabaseCache (Found)
//查询一页的数据
- (NSMutableArray<FoundDataBaseModel *> *)selectFoundPageSize:(NSInteger)size {
    NSString *sqlString;
    sqlString = [NSString stringWithFormat:@"select * from %@ order by found_disstributTime desc limit %ld offset 0",KTableNameOfFoundContent,(long)size];
    NSMutableArray *contentList = [self SelectInfoWithSqlString:sqlString];
    if (contentList && contentList.count > 0) {
        return [FoundDataBaseModel arrayOfModelsFromDictionaries:contentList];
    }
    return nil;
}


- (void)upDateOraddOneFoundContent:(FoundDataBaseModel *)info{
    
    NSDictionary *searchThisFoundDic = @{@"found_channnel":info.found_channnel};
    NSMutableArray *searchResult = [self SelectAllBycondition:searchThisFoundDic TableName:KTableNameOfFoundContent orderName:nil];
    if (searchResult&&searchResult.count>0) {
        [self UpdateTableField:[info toDictionary] condition:searchThisFoundDic tableName:KTableNameOfFoundContent];
    }else{
        [self InsertIntoTableFieldDict:[info toDictionary] tableName:KTableNameOfFoundContent];
    }
}


//插入多条数据
- (void)addFoundContentInfoWithArray:(NSArray<FoundDataBaseModel *> *)infoList {

    for (FoundDataBaseModel *info in infoList) {
        [self upDateOraddOneFoundContent:info];
    }
}


@end




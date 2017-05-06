//
//  WemiMainViewModel.m
//  weimi
//
//  Created by ray on 16/1/18.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "WemiMainViewModel.h"
#import "WEMEFeedcontrollerApi+RACSignal.h"
#import "DatabaseCache.h"

@interface WemiMainViewModel ()

@property (nonatomic) NSString *channel;
@property (nonatomic) NSMutableArray<FeedLocalModel *> *subjectArray;
@property (nonatomic) NSMutableArray<WEMEReply *> *subMessageArray;

@end

@implementation WemiMainViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.footerSelector = @selector(takeListAddSignal);
        self.headerSelector = @selector(takeListResetSignal);
        self.pageNum = @(0);
        self.wemiArray = [NSMutableArray array];
        self.subMessageArray = [NSMutableArray array];
        self.subjectArray = [NSMutableArray array];
    }
    return self;
}

- (RACSignal *)initializeDataSource {

        NSMutableArray<FeedLocalModel *> *list = [[DatabaseCache shareInstance]selectMyfeedPageSize:10];
    
        if (list && list.count > 0) {
            [self.subjectArray addObjectsFromArray:list];
            //获取离线消息
            return [self getUnpullData:YES];
        } else {
            return [self getUnpullData:NO];
        }
}


- (NSArray<NSIndexPath*> *)updateData:(SessonContentModel *)model {

    __block NSIndexPath *indexPath = nil;
    for (NSInteger i = 0; i < self.wemiArray.count; i++) {
        NSArray *sectionData = self.wemiArray[i];
        [sectionData enumerateObjectsUsingBlock:^(WEMEReply * _Nonnull replay, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([replay._id isEqualToString:model.channel]
//                &&[replay.uid isEqualToString:model.uid]
                ) {
                *stop = YES;
                indexPath = [NSIndexPath indexPathForRow:idx inSection:i];
            };
        }];
        if (indexPath != nil) {
            WEMEReply *replay = (WEMEReply *)self.wemiArray[indexPath.section][indexPath.row];
//            replay.snapshot.content.text = model.contentText;
            replay.readed = @(model.hasRead);
//            replay.snapshot.content.type = model.contentType;
            return @[indexPath];
        }
    }
    
    if (indexPath == nil) {
        return nil;
    } else {
        return @[indexPath];
    }
}

- (NSIndexPath *)insertData:(SessonContentModel *)model {
    NSIndexPath *indexPath = nil;
    
    return indexPath;
}

/**
 *  获取离线数据和历史数据
 *
 *  @param searchLast YES搜索离线消息,NO搜索历史记录
 *
 */
- (RACSignal *)getUnpullData:(BOOL)searchLast {
    @weakify(self);
    
    RACSubject *subject = [RACSubject subject];
    RACCompleteBlock completeBlock = [WEMEFeedcontrollerApi completeBlock:subject];

    RACSubject *subMessage = [RACSubject subject];
    RACCompleteBlock completeBlock2 = [WEMEFeedcontrollerApi completeBlock:subMessage];
    
    if (searchLast) {
        [[WEMEFeedcontrollerApi sharedAPI] myFeedUsingGETWithCompletionBlock:[self feedLastUpdate] page:@0 datesearch:@(0) completionHandler:^(WEMEPageResponseOfFeed *output, NSError *error) {
            completeBlock(output,error);
        }];
        
        [[WEMEFeedcontrollerApi sharedAPI] findUnPullMyFeedReplyUsingGETWithCompletionBlock:[self replayLastUpdate] page:@(0) completionHandler:^(WEMEPageResponseOfReply *output, NSError *error) {
            completeBlock2(output,error);
        }];
    } else {
        NSNumber *feedOldUpdate = [self feedOldUpdate];
        int datesearch = 0;
        feedOldUpdate.integerValue > 0 ? datesearch++ : datesearch;
        [[WEMEFeedcontrollerApi sharedAPI] myFeedUsingGETWithCompletionBlock:[self feedOldUpdate] page:@0 datesearch:@(datesearch) completionHandler:^(WEMEPageResponseOfFeed *output, NSError *error) {
            completeBlock(output,error);
        }];
    }
    
    [subject subscribeNext:^(WEMEPageResponseOfFeed *response) {
        @strongify(self);
//        self.subjectArray = response.page.content;
        [self.subjectArray addObjectsFromArray:[FeedLocalModel convertWithWEMEFeedArray:response.page.content]];
        
        if (!searchLast && IsEmpty(self.subjectArray)) completeBlock2(nil,nil);
        else if (!searchLast) {
            [self.subjectArray enumerateObjectsUsingBlock:^(FeedLocalModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSNumber *replayLastupdate = [self replayLastUpdate];
                [[WEMEFeedcontrollerApi sharedAPI] myFeedRepliesUsingGETWithCompletionBlock:obj._id lastupdate:replayLastupdate page:@0 completionHandler:^(WEMEPageResponseOfReply *output, NSError *error) {
                    
                    if (idx == self.subjectArray.count-1) { completeBlock2(output,error);}
                    else { [self.subMessageArray addObjectsFromArray:output.page.content]; }
                }];
            }];
        }
    } error:^(NSError *error) {
        self.error = error;
    }];
    
    [subMessage subscribeNext:^(WEMEPageResponseOfReply *response) {
        @strongify(self);
        [self.subMessageArray addObjectsFromArray:response.page.content];
    } error:^(NSError *error) {
        self.error = error;
    }];
    
    RACSignal *combineSignal =  [RACSignal combineLatest:@[subMessage,subject] reduce:^id{
        @strongify(self);
        return @(self.subjectArray.count > 0 && self.subMessageArray.count > 0);
    }];

    return [combineSignal doNext:^(id x) {
        @strongify(self);
        [self newArray];
    }];
//    return [combineSignal doCompleted:^{
//        @strongify(self);
//        [self newArray];
//    }];
}

- (RACSignal *)takeListResetSignal {
    return [self getUnpullData:YES];
}

- (RACSignal *)takeListAddSignal {
    return [self getUnpullData:NO];
}

- (void)newArray {
    
    NSMutableArray *combineArray = [NSMutableArray array];
    NSMutableArray *newIndexPath = [NSMutableArray array];
    
    [self.subjectArray enumerateObjectsUsingBlock:^(FeedLocalModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [combineArray addObject:@[obj]];
        [[DatabaseCache shareInstance] addMyfeedContentInfo:obj];
    }];
    
    NSIndexSet *newSectionSet = [[NSIndexSet alloc] init];
    NSRange feedRange = NSMakeRange(0, combineArray.count);
    BOOL dataSearch = self.subjectArray.firstObject.timestamp < [self feedOldUpdate];
    if (dataSearch) {
        feedRange = NSMakeRange(self.wemiArray.count, combineArray.count);
    }
    newSectionSet = [NSIndexSet indexSetWithIndexesInRange:feedRange];
    [self.wemiArray insertObjects:combineArray atIndexes:newSectionSet];
    
    [self.wemiArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray<WEMEReply *> *subMessageArray = [NSArray arrayWithArray:self.subMessageArray];
        if (subMessageArray.count == 0) *stop = YES;
        
        NSString *_id = ((WEMEFeed *)obj.firstObject)._id;
        NSMutableArray *sectionArray = [NSMutableArray arrayWithArray:obj];
//        [self.wemiArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        
        [subMessageArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(WEMEReply * _Nonnull replay, NSUInteger removeIdx, BOOL * _Nonnull stop) {
            if ([replay.fid isEqualToString:_id]) {
                [sectionArray insertObject:replay atIndex:1];
                [self.subMessageArray removeObjectAtIndex:[self.subMessageArray indexOfObject:replay]];
            }
        }];
        
        NSInteger addCount = sectionArray.count - obj.count;
        if (addCount > 0) {
            [self.wemiArray replaceObjectAtIndex:idx withObject:sectionArray];
        }
        if (addCount > 0 && ![newSectionSet containsIndex:idx]) {
            for (NSInteger i = 0; i < addCount; i++) {
                [newIndexPath addObject:[NSIndexPath indexPathForRow:i+1 inSection:idx]];
            }
        }
        
    }];
    
    if (newSectionSet.count > 0) {
        self.insertSection = newSectionSet.copy;
        _insertSection = nil;
    }
    if (newIndexPath.count > 0) {
        self.addPathArray = newIndexPath.copy;
        _addPathArray = nil;
    }
    [self.subjectArray removeAllObjects];
}

- (BOOL)hasReadAllRepaly
{
    if (self.wemiArray.count == 0) {
        return YES;
    }
    __block BOOL hasReadAllRepaly = NO;
    
    for (NSArray *array in self.wemiArray) {
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj isKindOfClass:[WEMEReply class]] ) {
                WEMEReply *replay = (WEMEReply *)obj;
                if(![replay.readed boolValue]) {
                    *stop = YES;
                } else if (idx == array.count - 1) {
                    hasReadAllRepaly = YES;
                }
            } else if (idx == array.count - 1) {
                hasReadAllRepaly = YES;
            }
        }];
        
        if (!hasReadAllRepaly) {
            break;
        }
    }

    return hasReadAllRepaly;
}

- (void)sortDatasource:(NSMutableArray *)dataArray {
    //    self.subMessageArray = [NSMutableArray arrayWithArray:[self.subMessageArray sortedArrayUsingComparator:^NSComparisonResult(WEMEReply * _Nonnull obj1, WEMEReply * _Nonnull obj2) {
    //        return obj2.timestamp.longLongValue > obj1.timestamp.longLongValue;
    //    }]];
}

#pragma mark - getter and setter

- (RACCommand *)receiveNewReplayCommand {
    if (_receiveNewReplayCommand != nil) return _receiveNewReplayCommand;
    @weakify(self);
    _receiveNewReplayCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
//        RACSubject *subject = [RACSubject subject];
//        RACCompleteBlock completeBlock = [WEMEFeedcontrollerApi completeBlock:subject];
//        [[WEMEFeedcontrollerApi sharedAPI] findUnPullMyFeedReplyUsingGETWithCompletionBlock:[self replayLastUpdate] page:@(0) completionHandler:^(WEMEPageResponseOfReply *output, NSError *error) {
//            completeBlock(output,error);
//        }];
//        return [[subject doNext:^(WEMEPageResponseOfReply *response) {
//            [self.subMessageArray addObjectsFromArray:response.page.content];
//            [self newArray];
//        }] doError:^(NSError *error) {
//            self.error = error;
//        }];
        return [self getUnpullData:YES];
    }];
    return _receiveNewReplayCommand;
}

- (RACCommand *)sendNewFeedCommand {
    if (_sendNewFeedCommand != nil) return _sendNewFeedCommand;
    @weakify(self);
    _sendNewFeedCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        RACSubject *subject = [RACSubject subject];
        RACCompleteBlock completeBlock = [WEMEFeedcontrollerApi completeBlock:subject];
        [[WEMEFeedcontrollerApi sharedAPI] myFeedUsingGETWithCompletionBlock:[self feedLastUpdate] page:@(0) datesearch:@(0) completionHandler:^(WEMEPageResponseOfFeed *output, NSError *error) {
            completeBlock(output,error);
        }];
        return [[subject doNext:^(WEMEPageResponseOfFeed *response) {
            [self.subjectArray addObjectsFromArray:[FeedLocalModel convertWithWEMEFeedArray:response.page.content]];
            [self newArray];
        }] doError:^(NSError *error) {
            self.error = error;
        }];
    }];
    return _sendNewFeedCommand;
}

- (RACCommand *)initializeDataSourceCommand {
    if (_initializeDataSourceCommand != nil) return _initializeDataSourceCommand;
    @weakify(self);
    _initializeDataSourceCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        return [self initializeDataSource];
    }];
    return _initializeDataSourceCommand;
}

- (NSNumber *)feedLastUpdate {
    NSNumber *lastUpdate = nil;
    NSArray *lastArray = self.wemiArray.firstObject;
    if (lastArray == nil && self.subjectArray.count > 0) {
        lastArray = self.subjectArray;
    }
    if ([lastArray isKindOfClass:[NSArray class]] && [lastArray.firstObject isKindOfClass:[FeedLocalModel class]]) {
        lastUpdate = ((FeedLocalModel *)lastArray.firstObject).timestamp;
    }
    return  lastUpdate != nil ? lastUpdate : @(0);
}

- (NSNumber *)feedOldUpdate {
    NSNumber *lastUpdate = nil;
    NSArray *lastArray = self.wemiArray.lastObject;
    if ([lastArray isKindOfClass:[NSArray class]] && [lastArray.firstObject isKindOfClass:[FeedLocalModel class]]) {
        lastUpdate = ((FeedLocalModel *)lastArray.lastObject).timestamp;
    }
    return  lastUpdate != nil ? lastUpdate : @(0);
}

- (NSNumber *)replayLastUpdate {
    __block NSNumber *lastUpdate = nil;
    [self.wemiArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *lastArray = obj;
        if ([lastArray isKindOfClass:[NSArray class]] && lastArray.count > 1 && [lastArray[1] isKindOfClass:[WEMEReply class]]) {
            lastUpdate = ((WEMEReply *)lastArray[1]).lastUpdate;
            *stop = YES;
        }
    }];
    return  lastUpdate != nil ? lastUpdate : @(0);
}

- (NSNumber *)replayOldUpdate {
    __block NSNumber *lastUpdate = nil;
    [self.wemiArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *lastArray = obj;
        if ([lastArray isKindOfClass:[NSArray class]] && lastArray.count > 1 && [lastArray[1] isKindOfClass:[WEMEReply class]]) {
            lastUpdate = ((WEMEReply *)lastArray[1]).lastUpdate;
            *stop = YES;
        }
    }];
    return  lastUpdate != nil ? lastUpdate : @(0);
}

@end

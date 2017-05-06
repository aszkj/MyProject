//
//  ChatViewModel.m
//  weimi
//
//  Created by ray on 16/2/22.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "ChatViewModel.h"
#import "DatabaseCache.h"
#import "SessonContentModel.h"
#import "WEMEFeedcontrollerApi+RACSignal.h"
#import "WEMEMessagecontrollerApi.h"

@interface ChatViewModel ()

@property (nonatomic) NSString *channel;
@property (nonatomic) NSNumber *datesearch;

@end


@implementation ChatViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.channel = @"";
        self.dataList = [NSMutableArray array];
        _addPathArray = [NSArray array];
    }
    return self;
}


- (RACSignal *)initializeDataSource {
    
    NSArray<SessonContentModel *> *list = [[DatabaseCache shareInstance] selectPageDataFromTimestamp:[self.firstupdate stringValue] channel:@"" size:10 withTablename:KTableNameOfSessionContent];
    
    if (list && list.count > 0) {
        [self.dataList addObjectsFromArray:list];
        [Util sortWithArray:self.dataList orderWithKey:@"contentTimestamp" ascending:YES];
        //获取离线消息
        return [self getUnpullData:YES];
    } else {
        return [self getUnpullData:NO];
    }
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
    
    if (searchLast) {
        self.datesearch = @(0);
        [[WEMEMessagecontrollerApi sharedAPI] getmessageUsingGET1WithCompletionBlock:[self lastupdate] page:@(0) datesearch:self.datesearch completionHandler:^(WEMEPageResponseOfMongoMessage *output, NSError *error) {
            completeBlock(output,error);
        }];
        
        [subject subscribeNext:^(WEMEPageResponseOfMongoMessage *output) {
            @strongify(self)
            if ([output.page.totalPages integerValue] > 1) {
                //如果获取到离线消息多余一页，就删除该channel对应的所有数据，重新加载
                [[DatabaseCache shareInstance] deleteMessageWithChannel:self.channel];
                self.dataList = [NSMutableArray array];
            }
            
            self.addMessages = output.page.content;
            [self addNewMessages:nil];
        } error:^(NSError *error) {
            self.error = error;
        }];

    } else {
        if ([self.firstupdate isEqual:@0]) {
            self.datesearch = @0;
        } else {
            self.datesearch = @1;
        }
        
        [[WEMEMessagecontrollerApi sharedAPI] getmessageUsingGET1WithCompletionBlock:self.firstupdate page:@(0) datesearch:self.datesearch completionHandler:^(WEMEPageResponseOfMongoMessage *output, NSError *error) {
            completeBlock(output,error);
        }];
        
        [subject subscribeNext:^(WEMEPageResponseOfMongoMessage *output) {
            @strongify(self)
            self.addMessages = output.page.content;
            [self addNewMessages:nil];

        } error:^(NSError *error) {
            self.error = error;
        }];
    }
    
    return subject;
}

- (void)addNewMessages:(NSArray<SessonContentModel *> *)modelList {
    
    NSMutableArray *newPathIndex = [NSMutableArray array];
    NSMutableArray <SessonContentModel *> *tempList = [[NSMutableArray alloc] init];
    if (modelList) {
        [tempList addObjectsFromArray:modelList];
        [self.dataList addObjectsFromArray:modelList];
    } else {
        //就把该离线消息加入到本地缓存
        for (WEMEMongoMessage *myFeed in self.addMessages)
        {
            SessonContentModel *message = [[SessonContentModel alloc] initWithSimpleMyFeed:myFeed channel:self.channel];
            if (!IsEmpty(message.contentType) && ![[DatabaseCache shareInstance] isHasSessonContentMessageWithChannel:self.channel localid:myFeed.localId]) {
                [self.dataList addObject:message];
                [tempList addObject:message];
            }
        }
    }
    
    [tempList enumerateObjectsUsingBlock:^(SessonContentModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:idx inSection:0];
        [newPathIndex addObject:path];
    }];
    
    //按时间戳排序
    self.lastTimeInterval = [Util sortWithArray:self.dataList orderWithKey:@"contentTimestamp" ascending:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[DatabaseCache shareInstance] addSessonContentInfoWithArray:tempList];
    });

    self.addMessages = tempList.copy;
    self.addPathArray = newPathIndex.copy;
    _addPathArray = nil;
}

- (RACSignal *)historySignal {
    RACSubject *subject = [RACSubject subject];
    
    NSArray<SessonContentModel *> *list = [[DatabaseCache shareInstance] selectPageDataFromTimestamp:[self.firstupdate stringValue] channel:@"" size:10 withTablename:KTableNameOfSessionContent];
//    return [self getUnpullData:NO];

    if (list && list.count > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subject sendNext:list];
            [subject sendCompleted];
        });      
        return [subject doNext:^(id x) {
            [self addNewMessages:list];
        }];
    } else {
        return [self getUnpullData:NO];
    }
}

#pragma mark - getter

- (RACCommand *)pullOfflineMessageCommand {
    if (_pullOfflineMessageCommand != nil) { return _pullOfflineMessageCommand; }
    @weakify(self);
    _pullOfflineMessageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [self getUnpullData:YES];
    }];
    return _pullOfflineMessageCommand;
}

- (RACCommand *)getHistoryCommand {
    if (_getHistoryCommand != nil) { return _getHistoryCommand; }
    @weakify(self);
    _getHistoryCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [self historySignal];
    }];
    return _getHistoryCommand;
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

- (NSNumber *)lastupdate {
    SessonContentModel *lastContentModel = [self.dataList lastObject];
    if (lastContentModel != nil) {
        return @(lastContentModel.contentTimestamp);
    } else {
        return @(0);
    }
}

- (NSNumber *)firstupdate {
    SessonContentModel *firstContentModel = [self.dataList firstObject];
    if (firstContentModel != nil) {
        return @(firstContentModel.contentTimestamp);
    } else {
        return @(0);
    }
}

@end

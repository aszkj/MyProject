//
//  ChatViewModel.h
//  weimi
//
//  Created by ray on 16/2/22.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "XKO_ViewModel.h"

@class SessonContentModel;
@class WEMEMongoMessage;

@interface ChatViewModel : XKO_ViewModel

@property (nonatomic) NSString *channel;
@property (nonatomic) NSNumber *firstupdate;
@property (nonatomic, strong) NSMutableArray<SessonContentModel *> *dataList;
@property (nonatomic) RACCommand *initializeDataSourceCommand;
@property (nonatomic, assign) NSTimeInterval lastTimeInterval; //保存最后时间
@property (nonatomic) RACCommand *getHistoryCommand;
@property (nonatomic) NSArray<NSIndexPath *> *addPathArray;
@property (nonatomic) NSArray<WEMEMongoMessage *> *addMessages;
@property (nonatomic) RACCommand *pullOfflineMessageCommand;

@end

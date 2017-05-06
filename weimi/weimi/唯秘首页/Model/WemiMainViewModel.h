//
//  WemiMainViewModel.h
//  weimi
//
//  Created by ray on 16/1/18.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "XKO_TableViewModel.h"
#import "SessonContentModel.h"
#import "FeedLocalModel.h"

@interface WemiMainViewModel : XKO_TableViewModel

@property (atomic) NSMutableArray *wemiArray;
@property (nonatomic) NSArray<NSIndexPath *> *addPathArray;
@property (nonatomic) NSIndexSet *insertSection;

@property (nonatomic) RACCommand *initializeDataSourceCommand;
@property (nonatomic) RACCommand *sendNewFeedCommand;
@property (nonatomic) RACCommand *receiveNewReplayCommand;

- (NSArray<NSIndexPath*> *)updateData:(SessonContentModel *)model;
- (NSIndexPath *)insertData:(SessonContentModel *)model;
- (BOOL)hasReadAllRepaly;

@end

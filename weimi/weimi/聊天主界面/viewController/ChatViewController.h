//
//  ChatViewController.h
//  weimi
//
//  Created by 鹏 朱 on 16/1/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKO_BaseViewController.h"
#import "FileMangeHelper.h"
#import "ChatBottomView.h"

@class WEMEPageResponseOfMongoMessage;
@class SessonContentModel;

typedef void (^TopViewBeginMovedBlock)(void);
typedef void (^HeaderHiddenCompleteBlock)(void);
typedef void(^BackDeliverMessageBlock)(NSArray *messageArr);

@interface ChatViewController : XKO_BaseViewController <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) WEMEPageResponseOfMongoMessage *message;
@property(nonatomic,strong) NSString *userName;
@property(nonatomic,strong) NSString *channel;
@property(nonatomic,strong) NSNumber *firstupdate;
@property(nonatomic,strong) NSNumber *page;
@property(nonatomic,strong) NSNumber *datesearch;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) ChatBottomView *chatBottomView;
//消息页面返回，传递消息
@property (nonatomic, copy)BackDeliverMessageBlock backDeliverMessageBlock;

/**
 *  初始化数据源
 */
- (void)initDataSource;

/**
 *  获取离线消息
 */
- (void)pullOfflineMessage;

- (void)helpAction;
- (void)pushToPersoncenter;

@end

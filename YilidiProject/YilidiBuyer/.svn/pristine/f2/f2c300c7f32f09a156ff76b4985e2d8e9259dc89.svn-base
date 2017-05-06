//
//  DLActivityMessageVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/3/17.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLActivityMessageVC.h"
#import "DLActivityMessageCell.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "GlobleConst.h"
#import "NSDictionary+SUISafeAccess.h"
#import "PushMessageManager.h"
#import "PushMessageManager+messageListener.h"
@interface DLActivityMessageVC ()
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation DLActivityMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"一里递活动";
    
    

    
    [self _initMessageTable];
    [self _requestData];
    [self startPushMessageListen];
}

- (void)startPushMessageListen {
    [[PushMessageManager sharedManager] startListenPushMessage:^(PushMessageModel *model) {
        
    }];
}

-(void)_initMessageTable{
    WEAK_SELF

    self.activityTableView.cellHeight = 260.0f;
    self.activityTableView.noDataLogicModule.nodataAlertTitle = @"没有消息哦";
    self.activityTableView.noDataLogicModule.nodataAlertImage = @"无消息";
    [self.activityTableView configurecellNibName:@"DLActivityMessageCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        
        DLActivityMessageCell *messageCell = (DLActivityMessageCell *)cell;
        messageCell.dic = (NSDictionary *)cellModel;
        
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
        
        
    }];
    
    [self.activityTableView headerRreshRequestBlock:^{
        [weak_self _requestData];
    }];
    
    [self.activityTableView footerRreshRequestBlock:^{
        [weak_self _requestData];
    }];
    

    
    
}

#pragma mark ------------------------Private-------------------------


#pragma mark ------------------------Api----------------------------------
- (void)_requestData{
    
     NSDictionary *requestParam = @{@"typeValue":_type,kRequestPageNumKey:@(self.activityTableView.dataLogicModule.requestFromPage), kRequestPageSizeKey:@(kRequestDefaultPageSize)};
    
    self.activityTableView.dataLogicModule.currentDataModelArr = [_dataArr mutableCopy];
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GetMessageType block:^(NSDictionary *resultDic, NSError *error) {
 
        [self hideLoadingHub];
        
        NSDictionary *dic = [resultDic sui_dictionaryForKey:EntityKey];
        NSArray *array = [dic sui_arrayForKey:@"list"];
        
        [self.activityTableView configureTableAfterRequestPagingData:[array mutableCopy]];
        

        

    }];
    
}

#pragma mark ------------------------Page Navigate---------------------------

#pragma mark ------------------------View Event---------------------------
- (void)goBack {
    [[PushMessageManager sharedManager] messagePageBack];
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

- (void)dealloc {
    [[PushMessageManager sharedManager] endListenPushMessage];
}



@end

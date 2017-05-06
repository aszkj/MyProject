//
//  DLRefundMessageVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/3/17.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLRefundMessageVC.h"
#import "DLPrivilegeMessageCell.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "DLRefundDetailsVC.h"
#import "GlobleConst.h"
#import "NSDictionary+SUISafeAccess.h"
#import "PushMessageManager.h"
#import "PushMessageManager+messageListener.h"

@interface DLRefundMessageVC ()
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation DLRefundMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"退款消息";
    
    
    
    
    [self _initMessageTable];
    [self _requestData];
    
    [self startPushMessageListen];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startPushMessageListen {
    [[PushMessageManager sharedManager] startListenPushMessage:^(PushMessageModel *model) {
        
    }];
}


-(void)_initMessageTable{
    WEAK_SELF
    self.refundMessageTable.cellHeight = 92.0f;
    self.refundMessageTable.noDataLogicModule.nodataAlertTitle = @"没有消息哦";
    self.refundMessageTable.noDataLogicModule.nodataAlertImage = @"无消息";
    [self.refundMessageTable configurecellNibName:@"DLPrivilegeMessageCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        
        DLPrivilegeMessageCell *messageCell = (DLPrivilegeMessageCell *)cell;
        messageCell.dic = (NSDictionary *)cellModel;
        
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
        
        DLRefundDetailsVC *vc = [[DLRefundDetailsVC alloc]init];
        [weak_self navigatePushViewController:vc animate:YES];
        
    }];
    
    
    [self.refundMessageTable headerRreshRequestBlock:^{
        [weak_self _requestData];
    }];
    
    [self.refundMessageTable footerRreshRequestBlock:^{
        [weak_self _requestData];
    }];
 
    
}

#pragma mark ------------------------Private-------------------------


#pragma mark ------------------------Api----------------------------------
- (void)_requestData{
    
       NSDictionary *requestParam = @{@"typeValue":_type,kRequestPageNumKey:@(self.refundMessageTable.dataLogicModule.requestFromPage), kRequestPageSizeKey:@(kRequestDefaultPageSize)};
    
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GetMessageType block:^(NSDictionary *resultDic, NSError *error) {
        
        [self hideLoadingHub];
        NSDictionary *dic = [resultDic sui_dictionaryForKey:EntityKey];
        NSArray *array = [dic sui_arrayForKey:@"list"];

        
        [self.refundMessageTable configureTableAfterRequestPagingData:[array mutableCopy]];
        
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

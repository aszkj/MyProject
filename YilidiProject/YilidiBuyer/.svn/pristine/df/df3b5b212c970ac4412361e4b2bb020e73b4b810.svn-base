//
//  DLPrivilegeMessageVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/3/17.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLPrivilegeMessageVC.h"
#import "DLPrivilegeMessageCell.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "GlobleConst.h"
#import "DLMyWalletVC.h"
#import "NSDictionary+SUISafeAccess.h"
#import "PushMessageManager.h"
#import "ProjectRelativeDefineNotification.h"
#import "PushMessageManager+messageListener.h"
#import "DLMessageModel.h"
@interface DLPrivilegeMessageVC ()
@property(nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong) PushMessageModel *lastReceiviedMessageModel;

@end

@implementation DLPrivilegeMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"优惠消息";
    
    
     [self _initMessageTable];
    [self _requestData];
    
    [self startPushMessageListen];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_registerNotification {
    [kNotification addObserver:self selector:@selector(observeRemoteNotification:) name:KNotificationHasRecievedPushNotification object:nil];
}

- (void)observeRemoteNotification:(NSNotification*)notification{

    
}

- (void)startPushMessageListen {
    [[PushMessageManager sharedManager] startListenPushMessage:^(PushMessageModel *model) {
        
    }];
}

-(void)_initMessageTable{
    WEAK_SELF
    
    self.privilegeTableView.cellHeight = 92.0f;
    self.privilegeTableView.noDataLogicModule.nodataAlertTitle = @"没有消息哦";
    self.privilegeTableView.noDataLogicModule.nodataAlertImage = @"无消息";

    [self.privilegeTableView configurecellNibName:@"DLPrivilegeMessageCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        
        DLPrivilegeMessageCell *messageCell = (DLPrivilegeMessageCell *)cell;
        DLMessageModel *model = (DLMessageModel *)cellModel;
        [messageCell setModel:model];
        
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
        DLMessageModel *model = (DLMessageModel *)cellModel;
        if ([model.directType intValue]== 1) {
            
            DLMyWalletVC *myWalletVC = [[DLMyWalletVC alloc]init];
            myWalletVC.index = 0;
            [weak_self navigatePushViewController:myWalletVC animate:YES];
            
        }
    }];
    
    
    [self.privilegeTableView headerRreshRequestBlock:^{
        [weak_self _requestData];
    }];
    
    [self.privilegeTableView footerRreshRequestBlock:^{
        [weak_self _requestData];
    }];

    
}

#pragma mark ------------------------Private-------------------------


#pragma mark ------------------------Api----------------------------------
- (void)_requestData{
    
    NSDictionary *requestParam = @{@"typeValue":@(1),kRequestPageNumKey:@(self.privilegeTableView.dataLogicModule.requestFromPage), kRequestPageSizeKey:@(kRequestDefaultPageSize)};
    
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GetMessageType block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        
        NSDictionary *dic = [resultDic sui_dictionaryForKey:EntityKey];
        NSArray *array = [dic sui_arrayForKey:@"list"];

        NSArray *data =  [DLMessageModel objectMessageModelArr:array];
        [self.privilegeTableView configureTableAfterRequestPagingData:[data mutableCopy]];
        
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

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
#import "DLMessageModel.h"
#import <Masonry/Masonry.h>
#import "DLMainTabBarController.h"
#import "NoActivityView.h"
#import "DLClassificationZoneVC.h"
#import "DLRefundDetailsVC.h"
#import "DLMyWalletVC.h"
#import "DLActivityDetailVC.h"
@interface DLActivityMessageVC ()
@property (nonatomic,strong)NoActivityView *noActivityView;
@property (nonatomic,strong)NSNumber *msgId;
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

    self.activityTableView.cellHeight = 236.0f;
    self.activityTableView.noDataLogicModule.nodataAlertTitle = @"没有消息哦";
    self.activityTableView.noDataLogicModule.nodataAlertImage = @"无消息";
    [self.activityTableView configurecellNibName:@"DLActivityMessageCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        
        DLActivityMessageCell *messageCell = (DLActivityMessageCell *)cell;
        DLMessageModel *model = (DLMessageModel *)cellModel;
        [messageCell setModel:model];

        
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
        DLMessageModel *model = (DLMessageModel *)cellModel;
        weak_self.msgId = model.msgId;
        [weak_self jumpType:[model.directType integerValue]directCode:model.directCode];
        
    }];
    
    [self.activityTableView headerRreshRequestBlock:^{
        [weak_self _requestData];
    }];
    
    [self.activityTableView footerRreshRequestBlock:^{
        [weak_self _requestData];
    }];
    

    
    
}

#pragma mark ------------------------Private-------------------------
- (void)checkHaveActivity {
    if (!self.activityTableView.dataLogicModule.currentDataModelArr.count) {
        self.noActivityView.hidden = NO;
    }else {
        if (_noActivityView) {
            _noActivityView.hidden = YES;
        }
    }
}

#pragma mark ------------------------Api----------------------------------
- (void)_requestData{
    
     NSDictionary *requestParam = @{@"typeValue":@(3),kRequestPageNumKey:@(self.activityTableView.dataLogicModule.requestFromPage), kRequestPageSizeKey:@(kRequestDefaultPageSize)};
    
   
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GetMessageType block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        NSDictionary *dic = [resultDic sui_dictionaryForKey:EntityKey];
        NSArray *array = [dic sui_arrayForKey:@"list"];
        NSArray *data =  [DLMessageModel objectMessageModelArr:array];
        [self.activityTableView configureTableAfterRequestPagingData:[data mutableCopy]];
        [self checkHaveActivity];
    }];
    
}

#pragma mark ------------------------Page Navigate---------------------------
- (void)jumpType:(NSInteger)type directCode:(NSString*)code{

    if (type==1) {

        DLMyWalletVC *myWalletVC = [[DLMyWalletVC alloc]init];
        myWalletVC.index = 0;
        [self navigatePushViewController:myWalletVC animate:YES];
        
    }else if (type==2){
        DLRefundDetailsVC *refundVC = [[DLRefundDetailsVC alloc]init];
        refundVC.saleOrderNo = code;
        [self navigatePushViewController:refundVC animate:YES];
        
        
    }else if (type==3){
    
        DLClassificationZoneVC *classSpecialVC = [[DLClassificationZoneVC alloc] init];
        classSpecialVC.infoDic = @{@"themeType":code};
        [self navigatePushViewController:classSpecialVC animate:YES];
    }else{
    
        DLActivityDetailVC *activityVC = [[DLActivityDetailVC alloc]init];
        activityVC.messageId = self.msgId;
        [self navigatePushViewController:activityVC animate:YES];
    }
    
    
}
#pragma mark ------------------------View Event---------------------------
- (void)goBack {
    [[PushMessageManager sharedManager] messagePageBack];
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------
- (NoActivityView *)noActivityView{
    
    if (!_noActivityView) {
        _noActivityView = BoundNibView(@"NoActivityView", NoActivityView);
        WEAK_SELF
        _noActivityView.block = ^{
            [weak_self enterMain];
        };
        [self.view addSubview:self.noActivityView];
        [self.noActivityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
    
    return _noActivityView;
}

- (void)enterMain {
    DLMainTabBarController *mainVC = [[DLMainTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
}


- (void)dealloc {
    [[PushMessageManager sharedManager] endListenPushMessage];
}



@end

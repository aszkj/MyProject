//
//  DLMessageVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/3/17.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLMessageVC.h"
#import "DLMessageCell.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "DLPrivilegeMessageVC.h"
#import "DLActivityMessageVC.h"
#import "DLRefundMessageVC.h"
#import "DLMessageModel.h"
#import "NSDictionary+SUISafeAccess.h"
@interface DLMessageVC ()
@property(nonatomic,strong)NSArray *dataArr;
@end

@implementation DLMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
   self.pageTitle = @"我的消息";

    
    [self _initMessageTable];
    [self _requestData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------------------------Init---------------------------------
-(void)_initMessageTable{
    WEAK_SELF
    self.messageTableView.cellHeight = 61.0f;
    [self.messageTableView configurecellNibName:@"DLMessageCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        
        DLMessageModel *model = (DLMessageModel *)cellModel;
        DLMessageCell *messageCell = (DLMessageCell *)cell;
        [messageCell setModel:model];
        
        
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
       DLMessageModel *model = (DLMessageModel *)cellModel;
        
        [weak_self jumpPage:model.typeValue];
        
    }];
    
  
}

#pragma mark ------------------------Private-------------------------


#pragma mark ------------------------Api----------------------------------
- (void)_requestData{

   
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:nil subUrl:kUrl_GetUserMessage block:^(NSDictionary *resultDic, NSError *error) {
       [self hideLoadingHub];
        
        NSArray *array = [resultDic sui_arrayForKey:EntityKey];

        _dataArr =  [DLMessageModel objectMessageModelArr:array];
        self.messageTableView.dataLogicModule.currentDataModelArr = [_dataArr mutableCopy];
        [self.messageTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
        
        [self.messageTableView reloadData];
    }];
    
    
    
}

#pragma mark ------------------------Page Navigate---------------------------
- (void)jumpPage:(NSNumber *)index {
    
    
    if ([index intValue]==1) {
        DLPrivilegeMessageVC *vc = [[DLPrivilegeMessageVC alloc]init];
        vc.type =index;
        [self navigatePushViewController:vc animate:YES];
    }else if ([index intValue]==2){
        DLRefundMessageVC *vc = [[DLRefundMessageVC alloc]init];
        vc.type =index;
        [self navigatePushViewController:vc animate:YES];
    }else{
        DLActivityMessageVC *vc = [[DLActivityMessageVC alloc]init];
        vc.type =index;
        [self navigatePushViewController:vc animate:YES];
    }
    
}


#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------


@end

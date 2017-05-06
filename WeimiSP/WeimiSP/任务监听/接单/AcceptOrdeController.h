//
//  AcceptOrdeController.h
//  WeimiSP
//
//  Created by 鹏 朱 on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKO_BaseViewController.h"

@class AcceptOrdeEntity;
@class AcceptOrdePromptView;
//#import "TaskMonitorMainController.h"

@interface AcceptOrdeController : XKO_BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray<AcceptOrdeEntity *> * dataList;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UINavigationController *mainNavController;
@property (strong, nonatomic) UIButton *acceptOrderBtn;
@property (strong, nonatomic) UIImageView *acceptOrderBtnBackImage;
@property (strong, nonatomic) UIView *networkStateView;
@property (strong, nonatomic) UIView *taskStateView;
@property (strong, nonatomic) UIView *mqttStateView;
/**
 *  接单提示视图
 */
@property (nonatomic, strong) AcceptOrdePromptView *acceptOrdePromptView;

- (void)changeNetworkState:(BOOL)hasNetwork;
- (void)WaitAcceptOrderAPI;
- (void)waitCompleteOrderAPI;
- (void)waitCompleteOrderAPIOfNoTip;
- (void)hidePopverView;

@end

//
//  MyTaskMonitorController.h
//  WeimiSP
//
//  Created by 鹏 朱 on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TaskMonitorMainController.h"

@interface MyTaskMonitorController : UIViewController<UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UINavigationController *mainNavController;

@end

//
//  XKJHOffShelfController.h
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKJHPackageManagerController.h"

@interface XKJHOffShelfController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) TicketManagerType requestType;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UINavigationController *mainNavController;

@end

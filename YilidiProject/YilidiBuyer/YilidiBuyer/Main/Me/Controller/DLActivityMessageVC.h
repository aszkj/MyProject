//
//  DLActivityMessageVC.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/3/17.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLBuyerBaseController.h"
#import "MycommonTableView.h"
@interface DLActivityMessageVC : DLBuyerBaseController
@property (strong, nonatomic) IBOutlet MycommonTableView *activityTableView;
@property (nonatomic,strong)NSNumber *type;
@end

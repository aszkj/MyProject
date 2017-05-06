//
//  DLMessageVC.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/3/17.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLBuyerBaseController.h"
#import "MycommonTableView.h"
@interface DLMessageVC : DLBuyerBaseController
@property (strong, nonatomic) IBOutlet MycommonTableView *messageTableView;
@property (nonatomic,strong)NSNumber *type;
@end

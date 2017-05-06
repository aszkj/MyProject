//
//  DLRefundMessageVC.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/3/17.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLBuyerBaseController.h"
#import "MycommonTableView.h"
@interface DLRefundMessageVC : DLBuyerBaseController
@property (strong, nonatomic) IBOutlet MycommonTableView *refundMessageTable;
@property (nonatomic,strong)NSNumber *type;
@end

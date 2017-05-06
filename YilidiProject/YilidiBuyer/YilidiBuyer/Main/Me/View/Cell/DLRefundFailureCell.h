//
//  DLRefundFailureCell.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/3/21.
//  Copyright © 2017年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DLInvoiceStatusModel;
@interface DLRefundFailureCell : UITableViewCell



@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (nonatomic,strong)DLInvoiceStatusModel *model;
@end

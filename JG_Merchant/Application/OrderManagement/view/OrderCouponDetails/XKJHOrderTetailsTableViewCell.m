//
//  XKJHOrderTetailsTableViewCell.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/8.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHOrderTetailsTableViewCell.h"

@interface XKJHOrderTetailsTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *groupSnLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation XKJHOrderTetailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)willCustomCellWith:(NSDictionary *)dict
{
    //默认为0，,使用后为1,-1为过期,3申请退款、5退款中、7退款完成
    self.groupSnLabel.text = dict[@"groupSn"];
    switch ([dict[@"status"] intValue])
    {
        case 1:
        {
            self.statusLabel.text = @"已消费";
        }
            break;
        case -1:
        {
            self.statusLabel.text = @"已过期";
        }
            break;
        case 3:
        {
            self.statusLabel.text = @"申请退款";
        }
            break;
        case 5:
        {
            self.statusLabel.text = @"退款中";
        }
            break;
        case 7:
        {
            self.statusLabel.text = @"退款完成";
        }
            break;
        default:
            break;
    }
}

@end

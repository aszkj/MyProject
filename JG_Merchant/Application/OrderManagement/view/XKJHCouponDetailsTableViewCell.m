//
//  XKJHCouponDetailsTableViewCell.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHCouponDetailsTableViewCell.h"

@interface XKJHCouponDetailsTableViewCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelWide;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation XKJHCouponDetailsTableViewCell

- (void)awakeFromNib {
//    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.nameLabel.hidden = YES;
}

-(void)setNameWithText:(NSString *)text
{
    self.titleLabel.adjustsFontSizeToFitWidth = NO;
    self.nameLabel.text = [NSString stringWithFormat:@"消费者昵称:%@",text];
    self.nameLabel.hidden = NO;
    self.titleLabelWide.constant = -142;
}

@end

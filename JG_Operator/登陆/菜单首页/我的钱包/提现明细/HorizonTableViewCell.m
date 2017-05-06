//
//  HorizonTableViewCell.m
//  Operator_JingGang
//
//  Created by ray on 15/9/20.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "HorizonTableViewCell.h"

@implementation HorizonTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)cleanSubView {
    [self.stackView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
}

- (void)layoutStackView {
    [self.stackView setAxis:UILayoutConstraintAxisVertical];
    [self.stackView setAxis:UILayoutConstraintAxisHorizontal];
}

@end

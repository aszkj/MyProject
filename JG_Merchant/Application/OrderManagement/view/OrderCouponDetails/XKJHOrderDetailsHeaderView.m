//
//  XKJHOrderDetailsHeaderView.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/8.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHOrderDetailsHeaderView.h"

@interface XKJHOrderDetailsHeaderView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xianHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xianHeight1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xianHeight2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xianHeight3;



@end

@implementation XKJHOrderDetailsHeaderView

- (void)awakeFromNib
{
    self.xianHeight.constant = self.xianHeight1.constant = self.xianHeight2.constant = self.xianHeight3.constant = 0.5;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
}

@end

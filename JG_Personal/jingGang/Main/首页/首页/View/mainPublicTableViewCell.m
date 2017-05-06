//
//  mainPublicTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/11/18.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "mainPublicTableViewCell.h"

@implementation mainPublicTableViewCell

- (void)awakeFromNib {
    self.left_img.layer.cornerRadius = 10;
    self.left_img.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

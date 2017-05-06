//
//  TestCell.m
//  jingGang
//
//  Created by wangying on 15/6/3.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell

- (void)awakeFromNib {
    // Initialization code
    self.total_v.backgroundColor = [UIColor whiteColor];
    self.total_v.layer.cornerRadius = 5;
    self.total_v.clipsToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end

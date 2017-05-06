//
//  MyStoreCell.m
//  jingGang
//
//  Created by wangying on 15/6/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "MyStoreCell.h"

@implementation MyStoreCell

- (void)awakeFromNib {
    // Initialization code
    
    self.iconImg.layer.cornerRadius = self.iconImg.frame.size.width/2;
    self.iconImg.clipsToBounds = YES;
//    self.iconImg.layer.borderWidth = 3;
//    
//    self.iconImg.layer.borderColor = [[UIColor colorWithRed:89/255.0 green:196/255.0 blue:241/255.0 alpha:1]CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

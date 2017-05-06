//
//  individualTableViewCell.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/14.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "individualTableViewCell.h"
#import "GlobeObject.h"
@interface individualTableViewCell ()


@end

@implementation individualTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.labelAwokeCount.layer.cornerRadius = 10.0;
    self.labelAwokeCount.clipsToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end

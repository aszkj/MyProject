//
//  PSDataTestItemCell.m
//  jingGang
//
//  Created by 张康健 on 15/7/22.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "PSDataTestItemCell.h"
#import "GlobeObject.h"


@implementation PSDataTestItemCell

- (void)awakeFromNib {
    // Initialization code
    
    if (iOS_7_Above) {
        self.testTypeLabel.font = [UIFont boldSystemFontOfSize:17];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{

    [super layoutSubviews];
    if (self.normalButton.selected) {
        self.normalButton.backgroundColor = kGetColor(94, 180, 231);
    }else{
        self.normalButton.backgroundColor = [UIColor lightGrayColor];
    }
    
    if (self.doubtFulButton.selected) {
        
        self.doubtFulButton.backgroundColor = kGetColor(94, 180, 231);
    }else{
        self.doubtFulButton.backgroundColor = [UIColor lightGrayColor];
    }
}

@end

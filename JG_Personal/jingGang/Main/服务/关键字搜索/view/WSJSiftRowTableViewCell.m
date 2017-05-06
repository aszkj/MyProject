//
//  WSJSiftRowTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/8/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJSiftRowTableViewCell.h"
#import "PublicInfo.h"

@interface WSJSiftRowTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;

@end

@implementation WSJSiftRowTableViewCell

- (void)awakeFromNib {
    self.selectImageView.hidden = YES;
}

- (void) selectCellWith:(BOOL)select
{
    if (select)
    {
        self.selectImageView.hidden = NO;
        self.nameLabel.textColor = status_color;
    }
    else
    {
        self.selectImageView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

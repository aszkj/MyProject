//
//  DLHelpCenterCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/13.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHelpCenterCell.h"

@implementation DLHelpCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //不限制行数
    self.contentLabel.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(DLHelpModel *)model{
    
    _model = model;
    self.contentLabel.text = model.content;
}


@end

//
//  DLMyNewsCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLMyNewsCell.h"

@implementation DLMyNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation DLMyNewsCell (setMyNewsCellModel)

-(void)setMyNewsCell:(DLNewsModel *)model{
    
    _titleLabel.text = model.title;
    _contentLabel.text = model.content;
    
}

@end

//
//  DLMineCell.m
//  YilidiBuyer
//
//  Created by yld on 16/4/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLManagementCell.h"

@implementation DLManagementCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end

@implementation DLManagementCell (setMineCellData)

- (void)setMineCellModel:(CommonImgTitleModel *)model {
    self.meImgView.image = IMAGE(model.normalImgName);
    self.meLabel.text = model.title;
    self.phoneLabel.text = model.phone;
}

@end


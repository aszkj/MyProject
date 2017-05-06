//
//  DLBrandClassificationCell.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBrandClassificationCell.h"
#import "UIImageView+sd_SetImg.h"
#import "DLBrandModel.h"
@implementation DLBrandClassificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DLBrandModel *)model {

    [self.brandImage sd_SetImgWithUrlStr:model.brandUrl placeHolderImgName:nil];
    self.brandTitle.text = model.brandName;
}
@end

//
//  DLActivityMessageCell.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/3/17.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLActivityMessageCell.h"
#import "UIImageView+sd_SetImg.h"
#import "DLMessageModel.h"
@implementation DLActivityMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

 


- (void)setModel:(DLMessageModel *)model{

    [self.contentLabel setText:model.msgAbstract];
    [self.image sd_SetImgWithUrlStr:model.msgImage placeHolderImgName:nil];
    [self.timerLabel setText:model.msgTime];
    [self.titleLabel setText:model.msgTitle];

}
@end

//
//  DLPrivilegeMessageCell.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/3/17.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLPrivilegeMessageCell.h"
#import "DLMessageModel.h"
@implementation DLPrivilegeMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDic:(NSDictionary *)dic{

    
    self.contentLabel.text = dic[@"msgAbstract"];
    self.titleLabel.text = dic[@"msgTitle"];
    self.timerLabel.text = dic[@"msgTime"];
    
}

- (void)setModel:(DLMessageModel *)model{
    
    [self.contentLabel setText:model.msgAbstract];
    [self.timerLabel setText:model.msgTime];
    [self.titleLabel setText:model.msgTitle];
    
    
}

@end

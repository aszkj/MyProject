//
//  DLMessageCell.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/3/17.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLMessageCell.h"
#import "DLMessageModel.h"
@implementation DLMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DLMessageModel *)model{
    
    if (isEmpty(model.msgAbstract)) {
        [self.contentLabel setText:@"暂无最新消息"];
    }else{
        [self.contentLabel setText:model.msgAbstract];
    }
    if (isEmpty(model.msgTime)) {
        self.timerLabel.hidden=YES;
    }else{
        self.timerLabel.hidden=NO;
        [self.timerLabel setText:model.msgTime];
    }
    
    [self.titleLabel setText:model.typeName];
    if (model.modelAtIndexPath.row==0) {
        self.image.image = [UIImage imageNamed:@"优惠消息"];
    }else if(model.modelAtIndexPath.row==1){
        self.image.image = [UIImage imageNamed:@"退款消息"];
    }else{
        self.image.image = [UIImage imageNamed:@"活动"];
        
    }
    
}
 
@end

//
//  DLInvitationCell.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/10/9.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLInvitationCell.h"
#import "UIImageView+sd_SetImg.h"

@implementation DLInvitationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DLShareModel *)model{

    [self.userImage sd_SetImgWithUrlStr:model.imageUrl placeHolderImgName:nil];
    self.phoneLabel.text = model.phoneNum;
    self.countLabel.text = [NSString stringWithFormat:@"%@人",model.count];
    self.nounLabel.text = [NSString stringWithFormat:@"%d",(int)model.modelAtIndexPath.row+1];
    
    
}
@end
